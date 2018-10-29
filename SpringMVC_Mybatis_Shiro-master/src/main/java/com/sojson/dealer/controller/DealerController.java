package com.sojson.dealer.controller;

import com.sojson.common.ResultMessage;
import com.sojson.common.controller.BaseController;
import com.sojson.common.model.TbDealer;
import com.sojson.common.model.TbVipRecord;
import com.sojson.common.model.TbVips;
import com.sojson.common.model.vo.DealerCountVo;
import com.sojson.common.utils.StringUtils;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.dealer.service.DealerService;
import com.sojson.dealer.service.VipsListService;
import com.sojson.dealer.service.VipsRecordListService;
import com.sojson.user.service.UUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by lx on 2018/9/4.
 */
@Controller
@Scope(value="prototype")
@RequestMapping("dealer")
public class DealerController extends BaseController {

    @Autowired
    DealerService dealerService;

    @Autowired
    VipsListService vipsListService;

    @Autowired
    UUserService userService;

    @Autowired
    VipsRecordListService vipsRecordListService;

    /**
     * 增加经销商
     *
     * @param entity
     * @return
     */
    @RequestMapping(value = "addDealer", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage addDealer(TbDealer entity) {
        entity.setId(StringUtils.getUUID32());
        return dealerService.insert(entity);
    }

    /**
     * 编辑经销商
     *
     * @param req
     * @return
     */
    @RequestMapping(value = "editDealer", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage editDealer(TbDealer entity, HttpServletRequest req) {
        return dealerService.update(entity);
    }

    /**
     * 删除经销商
     *
     * @param id
     * @param req
     * @return
     */
    @RequestMapping(value = "deleteDealerById", method = RequestMethod.GET)
    @ResponseBody
    public ResultMessage deleteDealerById(String id, HttpServletRequest req) {
        return dealerService.delete(id);
    }

    /**
     * 经销商主页
     *
     * @return
     */
    @RequestMapping(value = "list")
    public ModelAndView list(ModelMap map, Integer pageNo, String findContent,
                             String parentId) {

        map.put("findContent", findContent);
        map.put("parentId", parentId);
        Pagination<TbDealer> page = dealerService.findByPage(map, pageNo, pageSize);
        map.put("page", page);
        return new ModelAndView("dealer/list");
    }

    /**
     * 员工主页
     *
     * @return
     */
    @RequestMapping(value = "employeeList")
    public ModelAndView employeeList(ModelMap map, Integer pageNo, String findContent,
                             String parentId) {

        map.put("findContent", findContent);
        map.put("parentId", parentId);
        Pagination<TbDealer> page = dealerService.findByPage(map, pageNo, pageSize);
        map.put("page", page);
        return new ModelAndView("employee/list");
    }

    @RequestMapping(value="forbidUserById",method=RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> forbidUserById(Long id, Long status){
        return userService.updateForbidUserById(id,status);
    }

    @RequestMapping(value = "countDealerList")
    public ModelAndView countDealerList(ModelMap modelMap,@RequestParam Map<String,Object> map) {

        if (map.get("bgnTime") == null && map.get("endTime") == null) {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            map.put("bgnTime", formatter.format(new Date()) + " 00:00:00");
            map.put("endTime", formatter.format(new Date()) + " 23:59:59");
        }
        modelMap.put("listData", dealerService.countDealerVip(map));
        modelMap.putAll(map);
        return new ModelAndView("dealer/countDealerList");
    }


    @RequestMapping(value = "countEmployeeList")
    public ModelAndView countEmployeeList(ModelMap modelMap,@RequestParam Map<String,Object> map) {

        if (map.get("bgnTime") == null && map.get("endTime") == null) {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            map.put("bgnTime", formatter.format(new Date()) + " 00:00:00");
            map.put("endTime", formatter.format(new Date()) + " 23:59:59");
        }
        modelMap.put("listData", dealerService.countDealerVipById(map));
        modelMap.putAll(map);
        return new ModelAndView("employee/countEmployeeList");
    }

    @RequestMapping(value="exportExcelDealerVip",method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage exportExcelDealerVip(@RequestParam Map<String,Object> map){
        return dealerService.exportExcelDealerVip(map);
    }

    @RequestMapping(value="exportEmployee",method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage exportEmployee(@RequestParam Map<String,Object> map){
        return dealerService.exportEmployee(map);
    }

    /**
     * 查询连接
     *
     * @param telPhone
     * @return
     */
    @RequestMapping(value = "queryPlayerSignup", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage queryPlayerSignup(String telPhone) {
        return dealerService.queryPlayerSignup(telPhone);
    }

    /**
     * 查询连接
     *
     * @param telPhone
     * @return
     */
    @RequestMapping(value = "queryLink", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage queryLink(String telPhone) {
        return dealerService.queryLink(telPhone);
    }

    /**
     * 查询返佣金额
     *
     * @param userId
     * @return
     */
    @RequestMapping(value = "queryMoney", method = RequestMethod.POST)
    @ResponseBody
    public String queryMoney(String userId) {
        return dealerService.queryMoney(userId);
    }

    /**
     * 客户主页
     *
     * @return
     */
    @RequestMapping(value = "vipsList")
    public ModelAndView vipsList(ModelMap map, Integer pageNo, String findContent,
                             String parentId) {

        map.put("findContent", findContent);
        map.put("parentId", parentId);
        Pagination<TbVips> page = null;

        TbDealer dealer = dealerService.queryByUserId(parentId);
        if(null!=dealer){
            page = vipsListService.findByPage(map, pageNo, pageSize);
        }else{
            String type = dealerService.queryUserType(parentId);
            if("888888".equals(type) || "100004".equals(type) || "100005".equals(type) || "100006".equals(type)){
                page = vipsListService.findByPageAdmin(map,pageNo,pageSize);
            }
        }
        map.put("page", page);
        return new ModelAndView("dealer/vipsList");
    }

    @RequestMapping(value = "vipsRecordList")
    public ModelAndView vipsRecordList(ModelMap map, Integer pageNo, Integer pageSize,
                                 String userId) {

        Pagination<TbVipRecord> page = null;

        TbDealer dealer = dealerService.queryByUserId(userId);
        if(null!=dealer){
            if("0".equals(dealer.getParentId())){
                map.put("search","2");
                map.put("seatNum", dealer.getSeatNum());
                page = vipsRecordListService.findByPageDealer(map,pageNo,pageSize);
            }else{
                map.put("search","3");
                map.put("inviteCode", dealer.getInviteNum());
                page = vipsRecordListService.findByPageEmployee(map,pageNo,pageSize);
            }
        }else{
            String type = dealerService.queryUserType(userId);
            if("888888".equals(type) || "100004".equals(type) || "100005".equals(type) || "100006".equals(type)){
                map.put("search","1");
                page = vipsRecordListService.findByPageAdmin(map,pageNo,pageSize);
            }
        }

        map.put("page", page);
        return new ModelAndView("dealer/vipsRecordList");
    }

    @RequestMapping(value = "valiPhone", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage valiPhone(String phone, HttpServletRequest req) {
        return dealerService.validPhone(phone);
    }


//    @RequestMapping(value="countDealerVip",method=RequestMethod.POST)
//    @ResponseBody
//    public List<DealerCountVo> countDealerVip(@RequestParam Map<String,Object> map){
//        return
//    }

    @RequestMapping(value = "valiSeatNum", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage valiSeatNum(String seatNum, HttpServletRequest req) {
        return dealerService.valiSeatNum(seatNum);
    }

    @RequestMapping(value = "querySeatNum", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage querySeatNum(HttpServletRequest req) {
        return dealerService.querySeatNum();
    }

}
