package com.sojson.inf.player.service.impl;

import com.sojson.common.IConstant;
import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbPlayerMapper;
import com.sojson.common.utils.StringUtils;
import com.sojson.common.utils.VaildUtils;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.inf.player.model.dto.TbPlayerDto;
import com.sojson.inf.player.service.TbPlayerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class TbPlayerServiceImpl extends BaseMybatisDao<UTbPlayerMapper> implements TbPlayerService {
	@Autowired
	UTbPlayerMapper uTbPlayerMapper;


	@Override
	public ResultMessage insert(TbPlayerDto entity) {
		//数据验证
		ResultMessage msg = beforeAddVaild(entity);
		if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v) {
			entity.setId(StringUtils.getUUID32()); //获取UUID
			entity.setAuditFlag(IConstant.AUDIT_STATUS.WAIT_AUDIT.v); //设置待审核
			entity.setDelFlag(IConstant.YES_OR_NO.NO.v); //设置未删除
			entity.setCrtTime(new Date()); //设置创建时间
			//插入会员信息
			uTbPlayerMapper.insert(entity);
			msg.setMessageText("申请成功！");
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
			return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"会员名称必填且不能超过20个字符！");
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

		return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
	}

	/**
	 * 根据会员ID修改会员信息
	 * @param entity 会员信息
	 * @return
	 */
	@Override
	public ResultMessage updateByPrimaryKeySelective(TbPlayerDto entity) {
		//数据验证
		ResultMessage msg = beforeUpdateVaild(entity);
		if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v) {
			entity.setModTime(new Date()); //设置修改时间
			uTbPlayerMapper.updateByPrimaryKeySelective(entity);
			msg.setMessageText("修改成功！");
		}
		return new ResultMessage();
	}

	private ResultMessage beforeUpdateVaild(TbPlayerDto dto){
		//修改ID验证
		if (StringUtils.isBlank(dto.getId())) {
			return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"修改人信息错误！");
		}

		return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
	}

}
