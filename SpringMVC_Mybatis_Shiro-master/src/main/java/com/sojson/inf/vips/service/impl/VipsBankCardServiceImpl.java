package com.sojson.inf.vips.service.impl;

import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbVipsBankCardMapper;
import com.sojson.common.model.TbVipsCard;
import com.sojson.common.utils.RedisUtil;
import com.sojson.inf.vips.service.VipsBankCardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class VipsBankCardServiceImpl implements VipsBankCardService{
    @Autowired
    UTbVipsBankCardMapper uTbVipsBankCardMapper;

    @Override
    public ResultMessage insert(TbVipsCard entity,String sessionId, HttpServletRequest req) {
        String[] arr = RedisUtil.get(sessionId).split(",");
        String phone = arr[0];
        if(phone!=null && !phone.equals("")) {
            entity.setPhone(phone);
            int id = uTbVipsBankCardMapper.insert(entity);
            if (id <= 0) {
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "绑定失败");
            }
        }else{
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "手机号码为空");
        }
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v, "绑定成功");
    }

    @Override
    public ResultMessage delete(String id) {
        uTbVipsBankCardMapper.delete(id);

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v, "解绑成功");
    }

    @Override
    public List<TbVipsCard> findList(String sessionId) {
        String[] arr = RedisUtil.get(sessionId).split(",");
        String phone = arr[0];
        return uTbVipsBankCardMapper.findList(phone);
    }
}