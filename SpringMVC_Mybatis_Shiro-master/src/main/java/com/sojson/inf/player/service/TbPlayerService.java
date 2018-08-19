package com.sojson.inf.player.service;

import com.sojson.common.ResultMessage;
import com.sojson.common.model.UUser;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.inf.player.model.dto.TbPlayerDto;
import com.sojson.permission.bo.URoleBo;
import com.sojson.permission.bo.UserRoleAllocationBo;
import org.springframework.ui.ModelMap;

import java.util.List;
import java.util.Map;

public interface TbPlayerService {

	public ResultMessage insert(TbPlayerDto entity);

	public ResultMessage updateByPrimaryKeySelective(TbPlayerDto record);

}
