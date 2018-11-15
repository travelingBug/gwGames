package com.sojson.playermoney.service;


import com.sojson.common.ResultMessage;
import com.sojson.common.model.TbPlayerMoney;
import com.sojson.common.model.dto.PlayerTopInfo;
import com.sojson.common.model.vo.TbPlayerMoneyVo;
import com.sojson.core.mybatis.page.Pagination;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

/**
 * 选手收益处理层
 */
public interface PlayerMoneyService {
    /**
     * 导入参赛选手数据
     * @param file 参赛选手EXCEL
     * @return
     */
    public ResultMessage importPlayerMoneyExcel(MultipartFile file);

    Pagination<TbPlayerMoneyVo> findByPage(Map<String, Object> resultMap, Integer pageNo,
                                         Integer pageSize);

    /**
     * 修改
     * @param tbPlayerMoney
     * @return
     */
    public ResultMessage update(TbPlayerMoney tbPlayerMoney);

    public ResultMessage add(TbPlayerMoney tbPlayerMoney);

    public ResultMessage deleteById(Long id);

    /**
     * 获取总排行榜
     */
    public void getTopResultForAll();

    /**
     * 根据时间查询排行（一般用于月排行）
     * @param currDate
     * @param preDate
     */
    public void findTopByMonth(String currDate,String preDate);

    /**
     * 重新计算排名
     * @return
     */
    public ResultMessage reComplate();

    /**
     * 获取排名信息
     * @param param
     * @return
     */
    public List<PlayerTopInfo> getTop(Map<String,Object> param);
}
