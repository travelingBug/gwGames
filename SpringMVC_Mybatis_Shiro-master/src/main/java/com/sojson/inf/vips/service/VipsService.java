package com.sojson.inf.vips.service;

import com.sojson.common.ResultMessage;
import com.sojson.common.model.TbVipRecord;
import com.sojson.common.model.TbVips;
import com.sojson.core.mybatis.page.Pagination;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by lx on 2018/9/4.
 */
public interface VipsService {
    Pagination<TbVips> findByPage(Map<String, Object> resultMap, Integer pageNo,
                                  Integer pageSize);

    ResultMessage update(TbVips entity, HttpServletRequest req) throws Exception;

    ResultMessage insert(TbVips entity, HttpServletRequest req);

    ResultMessage delete(String id);

    ResultMessage login(TbVips entity, HttpServletRequest req);

    ResultMessage validPhone(String telPhone);

    ResultMessage loginOut(String token);

    TbVips queryVipsInfo(String phone);

    void updateLevelByDay();

    String getSurplusTime(String phone);

    ResultMessage validatePwd(String pwd, String phone);

    ResultMessage validInviteCode(String inviteCode);

    ResultMessage updatePwd(TbVips entity, HttpServletRequest req) throws Exception;

    public int updateSurplusDay();
}
