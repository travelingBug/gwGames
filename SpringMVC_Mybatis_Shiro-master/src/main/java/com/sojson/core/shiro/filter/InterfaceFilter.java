package com.sojson.core.shiro.filter;

import com.sojson.common.IConstant;
import com.sojson.common.InfAuth;
import com.sojson.common.utils.EncryptUtils;
import com.sojson.common.utils.RedisUtil;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.StringUtils;
import org.apache.shiro.web.filter.AccessControlFilter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;

public class InterfaceFilter extends AccessControlFilter {
	@Override
	protected boolean isAccessAllowed(ServletRequest request,
			ServletResponse resp, Object mappedValue) throws Exception {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse response = (HttpServletResponse) resp;
		response.setHeader("Access-Control-Allow-Origin", "*"); //解决跨域访问报错
		response.setHeader("Access-Control-Allow-Methods", "POST, PUT, GET, OPTIONS, DELETE");
		 response.setHeader("Access-Control-Max-Age", "3600"); //设置过期时间
		 response.setHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, client_id, uuid, Authorization");
		 response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // 支持HTTP 1.1.
		 response.setHeader("Pragma", "no-cache"); // 支持HTTP 1.0. response.setHeader("Expires", "0");

		String token = req.getHeader("Authorization");
		if (StringUtils.hasText(token)) {
			String content = EncryptUtils.aesDecrypt(token, IConstant.key);
			//判断接收的参数格式是否正确
 			if (StringUtils.hasText(content) && content.split(",").length == 2) {
				String[] contentArr = content.split(",");
//				HttpSession session = req.getSession();
				Object value = RedisUtil.get(contentArr[0]);
				String accUrl = req.getRequestURI();
				boolean flag = false;
				for (String authUrl : InfAuth.NEED_LOGIN) {
					if (accUrl.endsWith(authUrl)) {
						flag = true;
						break;
					}
				}
				if (flag) { //需要验证登录
					if (value == null || "".equals(value.toString())) {
						return Boolean.FALSE;
					}
				}
//				if ((value == null && IConstant.defSessionId.equals(contentArr[0]))
//						|| (value != null && !"".equals(value.toString()))) {
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					//更新最后操作时间
//					if (value != null && !"".equals(value.toString())) {
//						RedisUtil.save(contentArr[0],RedisUtil.get(contentArr[0]).split(",")[0] + "," + new Date().getTime());
//					}
					try{
						formatter.parse(contentArr[1]);
						return Boolean.TRUE;
					}catch(Exception e){
						return Boolean.FALSE;
					}
//				}

			}
		}
		return Boolean.FALSE;
	}

	@Override
	protected boolean onAccessDenied(ServletRequest request,
			ServletResponse response) throws Exception {
		
			Subject subject = getSubject(request, response);  
//	        if (null == subject.getPrincipal()) {//表示没有登录，重定向到登录页面
//	            saveRequest(request);
//				PrintWriter out = response.getWriter();
//				Map<String, String> resultMap = new HashMap<String, String>();
//				ResultMessage msg = new ResultMessage((byte)20);
//				out.println(JSONObject.fromObject(resultMap).toString());
//				out.flush();
//				out.close();
//	            WebUtils.issueRedirect(request, response, "/wxInf/toRegister.shtml");
//	        } else {
//	            if (StringUtils.hasText(ShiroFilterUtils.UNAUTHORIZED)) {//如果有未授权页面跳转过去
//	                WebUtils.issueRedirect(request, response, ShiroFilterUtils.UNAUTHORIZED);
//	            } else {//否则返回401未授权状态码
//	                WebUtils.toHttp(response).sendError(HttpServletResponse.SC_UNAUTHORIZED);
//	            }
//	        }
		return Boolean.FALSE;
	}

}
