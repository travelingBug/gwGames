package com.sojson.common.controller;


import com.sojson.common.utils.LoggerUtils;
import com.sojson.common.utils.StringUtils;
import com.sojson.common.utils.VerifyCodeUtils;
import com.sojson.common.utils.vcode.Captcha;
import com.sojson.common.utils.vcode.GifCaptcha;
import com.sojson.common.utils.vcode.SpecCaptcha;
import com.sojson.core.shiro.token.manager.TokenManager;
import com.sojson.permission.service.RoleService;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UrlPathHelper;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.URLDecoder;

@Controller
@Scope(value="prototype")
public class DownLoadController extends BaseController {
	@Resource
	RoleService roleService;
	/**
	 * 下载文件
	 * @param filePath 文件路径
	 * @return
	 */
	@RequestMapping("download")
	public void downloadLocal(String filePath,String fileOutName,HttpServletResponse response,HttpServletRequest request) throws FileNotFoundException {
		// 下载本地文件
		try {
			fileOutName = URLDecoder.decode(fileOutName, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		// 读到流中
		InputStream inStream = new FileInputStream(filePath);// 文件的存放路径
		// 设置输出的格式
		response.reset();
		response.setContentType("bin");
		response.addHeader("Content-Disposition", "attachment; filename=\"" + fileOutName + "\"");
		// 定义输出类型
		response.setContentType("application/msexcel;charset=utf-8");
		// 循环取出流中的数据
		byte[] b = new byte[100];
		int len;
		try {
			while ((len = inStream.read(b)) > 0)
				response.getOutputStream().write(b, 0, len);
			inStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
