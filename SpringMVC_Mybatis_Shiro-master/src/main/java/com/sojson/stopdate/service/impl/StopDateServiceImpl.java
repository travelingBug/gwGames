package com.sojson.stopdate.service.impl;

import com.sojson.common.IConstant;
import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbPlayerMapper;
import com.sojson.common.dao.UTbStopDateMapper;
import com.sojson.common.dao.UTbVipsMapper;
import com.sojson.common.model.TbPlayer;
import com.sojson.common.model.TbStopDate;
import com.sojson.common.model.TbStopDateHis;
import com.sojson.common.model.dto.TbPlayerDto;
import com.sojson.common.utils.StringUtils;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.core.shiro.token.manager.TokenManager;
import com.sojson.player.service.PlayerService;
import com.sojson.stopdate.service.StopDateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by lx on 2018/8/27.
 */
@Service
public class StopDateServiceImpl extends BaseMybatisDao<UTbStopDateMapper> implements StopDateService {

    @Autowired
    UTbStopDateMapper uTbStopDateMapper;

    @Resource
    UTbVipsMapper uTbVipsMapper;


    @Override
    public TbStopDate findStopDate() {
        List<TbStopDate> vos = uTbStopDateMapper.findAll();
        return vos.get(0);
    }

    @Override
    public ResultMessage update(TbStopDate tbStopDate) {
        TbStopDate oldVo = uTbStopDateMapper.findAll().get(0);
        if (oldVo.getStopFlag() == tbStopDate.getStopFlag()) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.HINT.v,"停止标识已经更新，请刷新后重试");
        }
        if (tbStopDate.getStopFlag() == IConstant.YES_OR_NO.YES.v) { //开始停止
            tbStopDate.setBgnTime(new Date());
            tbStopDate.setUserId(TokenManager.getUserId());
            uTbStopDateMapper.update(tbStopDate);
        } else if (tbStopDate.getStopFlag() == IConstant.YES_OR_NO.NO.v) { //结束停止
            TbStopDateHis his = new TbStopDateHis();
            his.setBgnTime(oldVo.getBgnTime());
            his.setEndTime(new Date());
            his.setBgnUserId(oldVo.getUserId());
            his.setEndUserId(TokenManager.getUserId());
            //停止结束后加上时间
            uTbVipsMapper.updateEndTimeByStop();
            oldVo.setBgnTime(null);
            oldVo.setEndTime(null);
            oldVo.setUserId(null);
            oldVo.setStopFlag(tbStopDate.getStopFlag());
            uTbStopDateMapper.update(oldVo);
            uTbStopDateMapper.insertHis(his);

        } else {
            return new ResultMessage(ResultMessage.MSG_LEVEL.HINT.v,"停止标识错误!");
        }
        return  new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v,"操作成功!");
    }
}
