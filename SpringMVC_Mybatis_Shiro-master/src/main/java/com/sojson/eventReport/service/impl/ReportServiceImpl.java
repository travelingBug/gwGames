package com.sojson.eventReport.service.impl;

import com.sojson.common.ImportHeader;
import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbEventReportMapper;
import com.sojson.common.dao.UTbGainsInfoMapper;
import com.sojson.common.model.TbEventReport;
import com.sojson.common.model.TbGainsInfo;
import com.sojson.common.model.dto.TbPlayerDto;
import com.sojson.common.utils.ExcelToBeanUtil;
import com.sojson.common.utils.ExcelUtil;
import com.sojson.common.utils.LoggerUtils;
import com.sojson.common.utils.StringUtils;
import com.sojson.core.config.IConfig;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.eventReport.service.ReportService;
import com.sojson.gainsinfo.service.impl.ExcelToBeanParamImpl;
import com.sojson.gainsinfo.service.impl.GainsInfoServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by lx on 2018/8/27.
 */
@Service
public class ReportServiceImpl extends BaseMybatisDao<UTbEventReportMapper> implements ReportService {

    @Autowired
    UTbEventReportMapper uTbEventReportMapper;

    @SuppressWarnings("unchecked")
    @Override
    public Pagination<TbEventReport> findByPage(Map<String, Object> resultMap, Integer pageNo, Integer pageSize) {
        return super.findPage(resultMap, pageNo, pageSize);
    }

    @Override
    @Transactional
    public ResultMessage add(MultipartFile file, TbEventReport tbEventReport){
        String id = StringUtils.getUUID32();
        if(file.getSize()>0){
            //新文件名称
            String newFileName = id + ".jpg";
            //文件保存地址
            String path = IConfig.get("eventReport_path_real");
            File pathFile = new File(path);
            if(!pathFile.exists()){//目录不存在就创建
                pathFile.mkdirs();
            }
            //保存文件
            try {
                file.transferTo(new File(path + newFileName));
                tbEventReport.setCover(newFileName);
            } catch (IOException e) {
                LoggerUtils.error(GainsInfoServiceImpl.class,"文件上传失败："+e.getMessage());
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"文件上传失败！");
            }
        }
        tbEventReport.setId(id);
        tbEventReport.setCrtTime(new Date());
        uTbEventReportMapper.insert(tbEventReport);
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    public TbEventReport findById(String id){
        TbEventReport tbEventReport = uTbEventReportMapper.findById(id);
        return tbEventReport;
    }

    @Override
    @Transactional
    public ResultMessage update(MultipartFile file, TbEventReport tbEventReport){
        if(file.getSize()>0){
            //新文件名称
            String newFileName = tbEventReport.getId() + ".jpg";
            //文件保存地址
            String path = IConfig.get("eventReport_path_real");
            File pathFile = new File(path);
            if(!pathFile.exists()){//目录不存在就创建
                pathFile.mkdirs();
            }
            //保存文件
            try {
                file.transferTo(new File(path + newFileName));
                tbEventReport.setCover(newFileName);
            } catch (IOException e) {
                LoggerUtils.error(GainsInfoServiceImpl.class,"文件上传失败："+e.getMessage());
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"文件上传失败！");
            }
        }
        uTbEventReportMapper.update(tbEventReport);
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }


    @Override
    @Transactional
    public ResultMessage deleteById(String id){
        String path = IConfig.get("eventReport_path_real");
        File file = new File(path+id+".jpg");
        if (file.exists() && file.isFile()) {
            file.delete();
        }
        uTbEventReportMapper.deleteById(id);
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

}
