package com.sojson.player.service.impl;

import com.sojson.common.ImportHeader;
import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbPlayerMapper;
import com.sojson.common.model.TbPlayer;
import com.sojson.common.model.dto.TbPlayerDto;
import com.sojson.common.utils.ExcelToBeanUtil;
import com.sojson.common.utils.ExcelUtil;
import com.sojson.common.utils.LoggerUtils;
import com.sojson.common.utils.StringUtils;
import com.sojson.core.config.IConfig;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.player.service.PlayerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by lx on 2018/8/27.
 */
@Service
public class PlayerServiceImpl extends BaseMybatisDao<UTbPlayerMapper> implements PlayerService{

    @Autowired
    UTbPlayerMapper uTbPlayerMapper;
    /**
     * 根据会员ID修改会员信息
     * @param entity 会员信息
     * @return
     */
    @Override
    public ResultMessage updateByPrimaryKeySelective(TbPlayer entity) {
        //数据验证
        ResultMessage msg = beforeUpdateVaild(entity);
        if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v) {
            Date currentTime = new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String dateStr = formatter.format(currentTime);
            entity.setModTime(currentTime); //设置修改时间
            entity.setAuditTime(dateStr);
            uTbPlayerMapper.updateByPrimaryKeySelective(entity);
        }
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    private ResultMessage beforeUpdateVaild(TbPlayer entity){
        //修改ID验证
        if (StringUtils.isBlank(entity.getId())) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"选手信息错误！");
        }

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    @SuppressWarnings("unchecked")
    @Override
    public Pagination<TbPlayer> findByPage(Map<String, Object> resultMap, Integer pageNo, Integer pageSize) {
        return super.findPage(resultMap, pageNo, pageSize);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<TbPlayer> findAll(TbPlayerDto player) {
        return uTbPlayerMapper.findAll(player);
    }

    @Override
    public ResultMessage importPlayerExcel(MultipartFile file) {
        ResultMessage msg = beforeImport(file);
        if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v ) { //验证正确则继续处理后续文件操作

            //新文件名称
            String newFileName = StringUtils.getUUID32() + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
            //文件保存地址
            String path = IConfig.get("excel_file_path");
            File pathFile = new File(path);
            if(!pathFile.exists()){//目录不存在就创建
                pathFile.mkdirs();
            }
            //保存文件
            try {
                file.transferTo(new File(path + newFileName));
                ExcelToPlayerParamImpl param = new ExcelToPlayerParamImpl();
                //解析Excel
                msg = ExcelToBeanUtil.changeExcelToPo(path + newFileName, ImportHeader.playerHeadReal,ImportHeader.getPlayerHeadFormat(),TbPlayer.class,0,param);
                if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v) {
                    Map<Byte, Object> result = (Map<Byte, Object>) msg.getData();
                    //导入正确的数据
                    List<TbPlayerDto> succList = (List<TbPlayerDto>) result.get(ResultMessage.MSG_LEVEL.SUCC.v);
                    //导入失败的数据
                    List<Object[]> failList = (List<Object[]>) result.get(ResultMessage.MSG_LEVEL.FAIL.v);
                    int succCount = 0;
                    int failCount = 0;
                    //处理正确的数据
                    if (succList.size() > 0) {
                        Date now = new Date();
                        for (TbPlayer player : succList) {
                            player.setCrtTime(now);
                            player.setId(StringUtils.getUUID32());
                        }
                        uTbPlayerMapper.insertBatch(succList);
                        succCount = succList.size();
                    }
                    if (failList.size() > 0) {
                        failCount = failList.size();
                        String errorPath = IConfig.get("excel_file_error_path");
                        File errorFile = new File(errorPath);
                        if(!errorFile.exists()){//目录不存在就创建
                            errorFile.mkdirs();
                        }
                        //设置头消息
                        Object[] head =  ImportHeader.playerHeadReal.keySet().toArray();
                        Object[] errorHead = new Object[head.length + 1];
                        System.arraycopy(head, 0, errorHead, 0, head.length );
                        errorHead[head.length] = "错误原因";
                        failList.add(0,errorHead);
                        String errorFileName = StringUtils.getUUID32() + "_error" + newFileName.substring(newFileName.lastIndexOf("."));
                        ExcelUtil.writeExcel(failList,errorPath+errorFileName,"sheet1");
                        List<String> errorFileInfo = new ArrayList<String>();
                        String errorName = file.getOriginalFilename().substring(0,file.getOriginalFilename().lastIndexOf(".")) + "_error" + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
                        errorFileInfo.add(errorName);//下载文件名
                        errorFileInfo.add(errorPath+errorFileName);//错误文件路径
                        msg.setData(errorFileInfo);
                    }
                    msg.setMessageText("导入完成，共计"+(succCount+failCount)+"条数据,其中正确"+succCount+"条,错误"+failCount+"条");

                }
            } catch (IOException e) {
                LoggerUtils.error(PlayerServiceImpl.class,"文件上传失败："+e.getMessage());
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"文件上传失败！");
            }catch (Exception e){
                LoggerUtils.error(PlayerServiceImpl.class,"EXCEL解析失败："+e.getMessage());
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"EXCEL解析失败！");
            }

        }
        return msg;
    }

    private ResultMessage beforeImport(MultipartFile file){
        if (StringUtils.isBlank(file.getOriginalFilename())
                || !(file.getOriginalFilename().toLowerCase().endsWith(".xls") || file.getOriginalFilename().toLowerCase().endsWith(".xlsx"))) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"EXCEL文件格式错误!");
        }
        if (file.getSize() < 1) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"EXCEL文件大小错误!");
        }
        return  new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    /**
     * 根据会员ID修改会员信息
     * @param entity 会员信息
     * @return
     */
    @Override
    public ResultMessage insertPlayer(TbPlayerDto entity) {
        try {
            Date currentTime = new Date();
            entity.setCrtTime(currentTime); //设置创建时间
            entity.setId(StringUtils.getUUID32());

            List<TbPlayerDto> playerList = new ArrayList<TbPlayerDto>();
            playerList.add(entity);
            uTbPlayerMapper.insertBatch(playerList);
        }catch(Exception e){
            e.getStackTrace();
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"新增失败");
        }
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }


    @Override
    public ResultMessage updateCapitalBatch(MultipartFile file) {
        ResultMessage msg = beforeImport(file);
        if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v ) { //验证正确则继续处理后续文件操作

            //新文件名称
            String newFileName = StringUtils.getUUID32() + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
            //文件保存地址
            String path = IConfig.get("excel_file_path");
            File pathFile = new File(path);
            if(!pathFile.exists()){//目录不存在就创建
                pathFile.mkdirs();
            }
            //保存文件
            try {
                file.transferTo(new File(path + newFileName));
                ExcelToPlayerParamCapImpl param = new ExcelToPlayerParamCapImpl();
                param.setPlayes(this.findAll(new TbPlayerDto()));
                //解析Excel
                msg = ExcelToBeanUtil.changeExcelToPo(path + newFileName, ImportHeader.playerCapitalReal,ImportHeader.getPlayerCapitalFormat(),TbPlayer.class,0,param);
                if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v) {
                    Map<Byte, Object> result = (Map<Byte, Object>) msg.getData();
                    //导入正确的数据
                    List<TbPlayer> succList = (List<TbPlayer>) result.get(ResultMessage.MSG_LEVEL.SUCC.v);
                    //导入失败的数据
                    List<Object[]> failList = (List<Object[]>) result.get(ResultMessage.MSG_LEVEL.FAIL.v);
                    int succCount = 0;
                    int failCount = 0;
                    //处理正确的数据
                    if (succList.size() > 0) {
                        uTbPlayerMapper.updateCapitalBatch(succList);
                        succCount = succList.size();
                    }
                    if (failList.size() > 0) {
                        failCount = failList.size();
                        String errorPath = IConfig.get("excel_file_error_path");
                        File errorFile = new File(errorPath);
                        if(!errorFile.exists()){//目录不存在就创建
                            errorFile.mkdirs();
                        }
                        //设置头消息
                        Object[] head =  ImportHeader.playerCapitalReal.keySet().toArray();
                        Object[] errorHead = new Object[head.length + 1];
                        System.arraycopy(head, 0, errorHead, 0, head.length );
                        errorHead[head.length] = "错误原因";
                        failList.add(0,errorHead);
                        String errorFileName = StringUtils.getUUID32() + "_error" + newFileName.substring(newFileName.lastIndexOf("."));
                        ExcelUtil.writeExcel(failList,errorPath+errorFileName,"sheet1");
                        List<String> errorFileInfo = new ArrayList<String>();
                        String errorName = file.getOriginalFilename().substring(0,file.getOriginalFilename().lastIndexOf(".")) + "_error" + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
                        errorFileInfo.add(errorName);//下载文件名
                        errorFileInfo.add(errorPath+errorFileName);//错误文件路径
                        msg.setData(errorFileInfo);
                    }
                    msg.setMessageText("导入完成，共计"+(succCount+failCount)+"条数据,其中正确"+succCount+"条,错误"+failCount+"条");

                }
            } catch (IOException e) {
                LoggerUtils.error(PlayerServiceImpl.class,"文件上传失败："+e.getMessage());
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"文件上传失败！");
            }catch (Exception e){
                LoggerUtils.error(PlayerServiceImpl.class,"EXCEL解析失败："+e.getMessage());
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"EXCEL解析失败！");
            }

        }
        return msg;
    }


}
