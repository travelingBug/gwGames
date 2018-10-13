package com.sojson.common.utils;

import com.sojson.core.config.IConfig;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class WaterMarkUtil {

    public static BufferedImage drawTranslucentStringPic(int width, int height, Integer fontHeight, String drawStr){
        try{
            BufferedImage buffImg = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
            Graphics2D gd = buffImg.createGraphics();
            //设置透明  start
            buffImg = gd.getDeviceConfiguration().createCompatibleImage(width, height, Transparency.TRANSLUCENT);
            gd=buffImg.createGraphics();
            //设置透明  end
            gd.setFont(new Font("微软雅黑", Font.PLAIN, fontHeight)); //设置字体
            gd.setBackground(Color.white);
            gd.setColor(Color.gray); //设置颜色
//            gd.drawRect(0, 0, width - 1, height - 1); //画边框
            gd.drawString(drawStr, width/2-fontHeight*drawStr.length()/2,fontHeight); //输出文字（中文横向居中）
            return buffImg;
        } catch (Exception e) {
            return null;
        }
    }

    public static void main(String[] args) {
        BufferedImage imgMap = drawTranslucentStringPic(400, 80, 36,"AT123321312");
        String path = IConfig.get("qrCode_path");
        File imgFile=new File("D://qrcode/"+"1.jpg");
        try
        {
            ImageIO.write(imgMap, "JPG", imgFile);
        } catch (IOException e)
        {
            e.printStackTrace();
        }
        System.out.println("生成完成");
    }
}