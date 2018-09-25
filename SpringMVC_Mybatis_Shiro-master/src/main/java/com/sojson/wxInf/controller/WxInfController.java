package com.sojson.wxInf.controller;

import com.sojson.common.controller.BaseController;
import com.sojson.common.model.vo.TbGainsInfoVo;
import com.sojson.core.mybatis.page.Pagination;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;


@Controller
@Scope(value="prototype")
@RequestMapping("wxInf")
public class WxInfController extends BaseController {

    @RequestMapping(value="toRegister")
    public void  toRegister(HttpServletRequest req, HttpServletResponse resp){
//        return new ModelAndView("redirect:/static/vips/register.jsp","name","小张张");
//        return "forward:/static/vips/register.jsp";
//        try {
//            req.getRequestDispatcher("/static/vips/register.jsp").forward(req,resp);
//        } catch (ServletException e) {
//            e.printStackTrace();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
    }
}
