package com.sojson.inf.vips.service;

import com.sojson.common.ResultMessage;
import com.sojson.common.model.TbVipsCard;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by lx on 2018/9/4.
 */
public interface VipsBankCardService {

    ResultMessage insert(TbVipsCard entity,String sessionId, HttpServletRequest req);

    ResultMessage delete(String id);

    List<TbVipsCard> findList(String sessionId);

}
