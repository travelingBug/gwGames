package com.sojson.core.freemarker.extend;

import com.sojson.common.model.URole;
import com.sojson.common.model.UUser;
import com.sojson.common.utils.LoggerUtils;
import com.sojson.core.config.IConfig;
import com.sojson.core.shiro.token.manager.TokenManager;
import com.sojson.core.statics.Constant;
import org.apache.shiro.session.Session;
import org.springframework.web.servlet.view.freemarker.FreeMarkerView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.Map;
public class FreeMarkerViewExtend extends FreeMarkerView {
	
	protected void exposeHelpers(Map<String, Object> model, HttpServletRequest request){
		
		try {
			super.exposeHelpers(model, request);
		} catch (Exception e) {
			LoggerUtils.fmtError(FreeMarkerViewExtend.class,e, "FreeMarkerViewExtend 加载父类出现异常。请检查。");
		}
		model.put(Constant.CONTEXT_PATH, request.getContextPath());
		model.putAll(Ferrmarker.initMap);
		UUser token = TokenManager.getToken();
		if(token != null) {
			URole role = TokenManager.getRoleByUserId(token.getId().toString());
			model.put("role", role.getName());
			if (role.getType().equals("200001")) {
				String status = TokenManager.getDealerStatus(token.getId().toString());
				model.put("status", status);
			}else if(role.getType().equals("200002")){
				String status = TokenManager.queryEmplyoeeStatus(token.getId().toString());
				model.put("status", status);
			}
		}
		//String ip = IPUtils.getIP(request);
		model.put("token", token);//登录的token
		model.put("_time", new Date().getTime());
		model.put("NOW_YEAY", Constant.NOW_YEAY);//今年
		
		model.put("_v", Constant.VERSION);//版本号，重启的时间
		model.put("cdn", Constant.DOMAIN_CDN);//CDN域名
		model.put("basePath", request.getContextPath());//base目录。
		model.put("userId", TokenManager.getUserId());
		model.put("qrCodeUrl", IConfig.get("qrCode_path"));

		
	}
}
