package com.sojson.common.dao;

import com.sojson.common.model.TbGainsInfo;
import com.sojson.common.model.TbPlayer;
import com.sojson.common.model.dto.TbPlayerDto;
import com.sojson.common.model.vo.TbGainsInfoVo;

import java.util.List;
import java.util.Map;

public interface UTbGainsInfoMapper {

    /**
     * 批量插入
     * @param list
     * @return
     */
    int insertBatch(List<TbGainsInfo> list);

    int updateByPrimaryKeySelective(TbGainsInfo tbGainsInfo);

    /**
     * 不分页查询
     * @param gainsInfo
     * @return
     */
    List<TbGainsInfoVo> findGainsInfo(Object gainsInfo);

    /**
     * 添加
     * @param gainsInfo
     * @return
     */
    int insert(Object gainsInfo);

    /**
     * 删除
     * @param id
     * @return
     */
    int deleteById(Long id);


    /**
     * 根据身份证查询选手数据
     */
    List<TbGainsInfoVo> getGainsInfoByIdCards(List<String> idCards);

    /**
     * 根据身份证查询选手数据
     */
    List<TbGainsInfoVo> findAll(Object param);
}