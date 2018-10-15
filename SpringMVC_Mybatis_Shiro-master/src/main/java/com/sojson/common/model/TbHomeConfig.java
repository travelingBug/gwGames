package com.sojson.common.model;

import java.io.Serializable;
import java.util.Date;

public class TbHomeConfig implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    private String id;

    /**
     * 标题
     */
    private String title;

    /**
     * 图片路径
     */
    private String imgPath;


    /**
     * 图片链接
     */
    private String url;


    /**
     * 图片位置（0：首页BANNER，1：广告）
     */
    private Byte pathFlag;

    /**
     * 修改时间
     */
    private Date crtTime;

    /**
     * 序号
     */
    private Integer volume;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Date getCrtTime() {
        return crtTime;
    }

    public void setCrtTime(Date crtTime) {
        this.crtTime = crtTime;
    }

    public Integer getVolume() {
        return volume;
    }

    public void setVolume(Integer volume) {
        this.volume = volume;
    }

    public Byte getPathFlag() {
        return pathFlag;
    }

    public void setPathFlag(Byte pathFlag) {
        this.pathFlag = pathFlag;
    }
}
