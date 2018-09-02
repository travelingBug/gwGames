package com.sojson.core.shiro.filter;

import com.sojson.common.IConstant;
import com.sojson.common.utils.EncryptUtils;
import com.sojson.common.utils.LoggerUtils;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.StringUtils;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.apache.shiro.web.util.WebUtils;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

public class InterfaceFilter extends AccessControlFilter {
	@Override
	protected boolean isAccessAllowed(ServletRequest request,
			ServletResponse response, Object mappedValue) throws Exception {
		HttpServletRequest req = (HttpServletRequest) request;
		String token = req.getHeader("Authorization");
		if (StringUtils.hasText(token)) {
			String content = EncryptUtils.aesDecrypt(token, IConstant.key);
			//判断接收的参数格式是否正确
			if (StringUtils.hasText(content) && content.split(",").length == 2) {
				String[] contentArr = content.split(",");
				HttpSession session = req.getSession();
				Object value = session.getAttribute(contentArr[0]);

				if ((value == null && IConstant.defSessionId.equals(contentArr[0]))
						|| value != null) {
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					try{
						formatter.parse(contentArr[1]);
						return Boolean.TRUE;
					}catch(Exception e){
						return Boolean.FALSE;
					}
				}

			}
		}
		return Boolean.FALSE;
	}

	@Override
	protected boolean onAccessDenied(ServletRequest request,
			ServletResponse response) throws Exception {
		
			Subject subject = getSubject(request, response);  
	        if (null == subject.getPrincipal()) {//表示没有登录，重定向到登录页面  
	            saveRequest(request);  
	            WebUtils.issueRedirect(request, response, ShiroFilterUtils.LOGIN_URL);  
	        } else {  
	            if (StringUtils.hasText(ShiroFilterUtils.UNAUTHORIZED)) {//如果有未授权页面跳转过去  
	                WebUtils.issueRedirect(request, response, ShiroFilterUtils.UNAUTHORIZED);  
	            } else {//否则返回401未授权状态码  
	                WebUtils.toHttp(response).sendError(HttpServletResponse.SC_UNAUTHORIZED);  
	            }  
	        }  
		return Boolean.FALSE;
	}

}
