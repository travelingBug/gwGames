package com.sojson.homeconfig.service.impl;

import com.sojson.common.IConstant;
import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbEventReportMapper;
import com.sojson.common.dao.UTbHomeConfigMapper;
import com.sojson.common.model.TbEventReport;
import com.sojson.common.model.TbHomeConfig;
import com.sojson.common.utils.LoggerUtils;
import com.sojson.common.utils.StringUtils;
import com.sojson.core.config.IConfig;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.eventReport.service.ReportService;
import com.sojson.gainsinfo.service.impl.GainsInfoServiceImpl;
import com.sojson.homeconfig.service.HomeConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lx on 2018/8/27.
 */
@Service
public class HomeConfigServiceImpl extends BaseMybatisDao<UTbHomeConfigMapper> implements HomeConfigService {

    @Autowired
    UTbHomeConfigMapper uTbHomeConfigMapper;

    @SuppressWarnings("unchecked")
    @Override
    public Pagination<TbHomeConfig> findByPage(Map<String, Object> resultMap, Integer pageNo, Integer pageSize) {
        return super.findPage(resultMap, pageNo, pageSize);
    }

    @Override
    @Transactional
    public ResultMessage add(MultipartFile file, TbHomeConfig tbHomeConfig){
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
                tbHomeConfig.setImgPath(newFileName);
            } catch (IOException e) {
                LoggerUtils.error(GainsInfoServiceImpl.class,"文件上传失败："+e.getMessage());
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"文件上传失败！");
            }
        } else {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"请上传图片!");
        }
        tbHomeConfig.setId(id);
        tbHomeConfig.setCrtTime(new Date());
        uTbHomeConfigMapper.insert(tbHomeConfig);
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    public TbHomeConfig findById(String id){
        TbHomeConfig tbHomeConfig = uTbHomeConfigMapper.findById(id);
        return tbHomeConfig;
    }


    @Override
    @Transactional
    public ResultMessage update(MultipartFile file, TbHomeConfig tbHomeConfig){
        if(file.getSize()>0){
            //新文件名称
            String newFileName = tbHomeConfig.getId() + ".jpg";
            //文件保存地址
            String path = IConfig.get("eventReport_path_real");
            File pathFile = new File(path);
            if(!pathFile.exists()){//目录不存在就创建
                pathFile.mkdirs();
            }
            //保存文件
            try {
                file.transferTo(new File(path + newFileName));
                tbHomeConfig.setImgPath(newFileName);
            } catch (IOException e) {
                LoggerUtils.error(GainsInfoServiceImpl.class,"文件上传失败："+e.getMessage());
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"文件上传失败！");
            }
        }
        uTbHomeConfigMapper.update(tbHomeConfig);
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
        uTbHomeConfigMapper.deleteById(id);
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    /**
     *
     * @return
     */
    @Override
    public ResultMessage getHomeConfig(){
        String path = IConfig.get("eventReport_path");
        //查询前三条banner数据
        Map<String,Object> param = new HashMap<String,Object>();
        param.put("pathFlag", IConstant.PATH_FLAG.BANNER.v);
        param.put( "page_sql"," limit  0 , 3 ");
        List<TbHomeConfig>  bannerList = uTbHomeConfigMapper.findAll(param);
        if (bannerList != null && bannerList.size() > 0) {
            for (TbHomeConfig tbHomeConfig : bannerList) {
                tbHomeConfig.setImgPath(path+tbHomeConfig.getImgPath());
            }
        }
        param.put("pathFlag", IConstant.PATH_FLAG.ADVERT_BOTTOM.v);
        param.put( "page_sql"," limit  0 , 1 ");
        List<TbHomeConfig>  advertList = uTbHomeConfigMapper.findAll(param);

        if (advertList != null && advertList.size() > 0) {
            for (TbHomeConfig tbHomeConfig : advertList) {
                tbHomeConfig.setImgPath(path+tbHomeConfig.getImgPath());
            }
        }


        Map<String,List<TbHomeConfig>> data = new HashMap<String,List<TbHomeConfig>>();
        data.put("banner",bannerList);
        data.put("advert",advertList);
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v,"",data);
    }

    @Override
    public ResultMessage getHomeAdvert(){
        String path = IConfig.get("eventReport_path");
        //查询首页广告
        Map<String,Object> param = new HashMap<String,Object>();
        param.put("pathFlag", IConstant.PATH_FLAG.ADVERT_HOME.v);
        param.put( "page_sql"," limit  0 , 1 ");
        List<TbHomeConfig>  advertList = uTbHomeConfigMapper.findAll(param);

        if (advertList != null && advertList.size() > 0) {
            for (TbHomeConfig tbHomeConfig : advertList) {
                tbHomeConfig.setImgPath(path+tbHomeConfig.getImgPath());
            }
        }
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v,"",advertList);
    }


}
