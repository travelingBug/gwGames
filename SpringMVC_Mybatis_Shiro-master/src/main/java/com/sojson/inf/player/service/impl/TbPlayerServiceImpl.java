package com.sojson.inf.player.service.impl;

import com.sojson.common.IConstant;
import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbPlayerMapper;
import com.sojson.common.model.TbPlayer;
import com.sojson.common.model.dto.TbPlayerDto;
import com.sojson.common.utils.RedisUtil;
import com.sojson.common.utils.SendMsgUtil;
import com.sojson.common.utils.StringUtils;
import com.sojson.common.utils.VaildUtils;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.inf.player.service.TbPlayerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class TbPlayerServiceImpl extends BaseMybatisDao<UTbPlayerMapper> implements TbPlayerService {
	@Autowired
	UTbPlayerMapper uTbPlayerMapper;

//	RedisUtil redisUtil = RedisUtil.getRedis();
	@Override
	public ResultMessage insert(TbPlayerDto dto) {
		//数据验证
		ResultMessage msg = beforeAddVaild(dto);
		if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v) {
			dto.setId(StringUtils.getUUID32()); //获取UUID
			dto.setAuditFlag(IConstant.AUDIT_STATUS.WAIT_AUDIT.v); //设置待审核
			dto.setDelFlag(IConstant.YES_OR_NO.NO.v); //设置未删除
			dto.setCrtTime(new Date()); //设置创建时间
			//插入会员信息
			uTbPlayerMapper.insert(dto);
			msg.setMessageText("申请成功！");
			//删除redies缓存
			RedisUtil.delete(dto.getTelPhone());

			SendMsgUtil.sendAdminMsg("18019565656,18980907645,15982113122");
		}
		return msg;
	}

	/**
	 * 保存会员前验证
	 * @param dto 会员信息
	 * @return ResultMessage 返回结果
	 */
	private ResultMessage beforeAddVaild(TbPlayerDto dto){

		//验证用户名
		if (StringUtils.isEmpty(dto.getName())
				|| dto.getName().length() > 20) {
			return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"观众名称必填且不能超过20个字符！");
		}

		//验证身份证
		if (!VaildUtils.cardCodeValid(dto.getIdCard())) {
			return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"身份格式不正确！");
		}

		//验证电话号码
		if (StringUtils.isEmpty(dto.getTelPhone())
				|| dto.getTelPhone().length() > 20) {
			return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"电话号码必填且不能超过20个字符！");
		}

		//验证短信验证码

		String code = RedisUtil.get(dto.getTelPhone());
		if (StringUtils.isBlank(code)) {
			return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"未找到对应验证码！");
		}
		String[] codeArr = code.split(",");
		if (codeArr.length != 2 || !codeArr[0].equalsIgnoreCase(dto.getVerfiCode())) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"验证码错误！");
        }


		return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
	}

	/**
	 * 根据会员ID修改会员信息
	 * @param entity 会员信息
	 * @return
	 */
	@Override
	public ResultMessage updateByPrimaryKeySelective(TbPlayer entity) {
		//数据验证
		ResultMessage msg = beforeUpdateVaild(entity);
		if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v) {
			entity.setModTime(new Date()); //设置修改时间
			uTbPlayerMapper.updateByPrimaryKeySelective(entity);
			msg.setMessageText("修改成功！");
		}
		return new ResultMessage();
	}

	private ResultMessage beforeUpdateVaild(TbPlayer dto){
		//修改ID验证
		if (StringUtils.isBlank(dto.getId())) {
			return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"修改人信息错误！");
		}

		return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
	}


	@Override
	public List<TbPlayer> findAllNoPage(TbPlayerDto dto){
		return uTbPlayerMapper.findAllNoPage(dto);
	}
}
