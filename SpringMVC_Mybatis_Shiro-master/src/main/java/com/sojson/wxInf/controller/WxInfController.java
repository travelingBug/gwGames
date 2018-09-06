package com.sojson.wxInf.controller;

import com.sojson.common.controller.BaseController;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@Scope(value="prototype")
@RequestMapping("wxInf")
public class WxInfController extends BaseController {

    @RequestMapping(value="test",method=RequestMethod.GET)
    @ResponseBody
    public void bmIndex(){
        System.out.println("");
    }
}
