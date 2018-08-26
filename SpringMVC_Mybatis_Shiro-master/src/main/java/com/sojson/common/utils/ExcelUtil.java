package com.sojson.common.utils;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by wlh on 2016/1/5.
 */
public class ExcelUtil{

    /**
     * 读取XLSX格式的Excel的文件
     * @param path 文件路径
     * @param sheetNum 读取的第几个工作空间
     * @return  Excel中的数据
     * @throws IOException
     */
    public static List<Object[]> readXlsx(String path, int sheetNum) throws IOException {
        InputStream is = new FileInputStream(path);
        XSSFWorkbook xssfWorkbook = new XSSFWorkbook(is);
        //返回的数据
        List<Object[]> datas = new ArrayList<Object[]>();
        // Read the Sheet
        for (int numSheet = 0; numSheet < xssfWorkbook.getNumberOfSheets(); numSheet++) {
            //找到对应的工作区间
            if (sheetNum != numSheet ) {
                continue;
            }

            XSSFSheet xssfSheet = xssfWorkbook.getSheetAt(numSheet);
            if (xssfSheet == null) {
                return datas;
            }
            //获取总共有多少行数据因为中间空行的话，则读取出来的数据不准确
            int hasRowNum =  xssfSheet.getPhysicalNumberOfRows();
            //已经处理了的行数
            int procssedNum = 0;
            //读取数据
            for (int rowNum = 0;; rowNum++) {
                //读取每一行的数据
                XSSFRow xssfRow = xssfSheet.getRow(rowNum);
                if (xssfRow != null) {
                    int colsNum = xssfRow.getLastCellNum();
                    if(colsNum > 0) {
                        Object[] colDara = new Object[colsNum];
                        for (int j = 0; j <colsNum; j++) {
                            colDara[j] = xssfRow.getCell(j);
                        }
                        datas.add(colDara);
                    }

                    procssedNum++;
                    if (procssedNum == hasRowNum) {
                        break;
                    }
                }
            }
        }
        is.close();
        return datas;
    }


    /**
     * 读取XLS格式的文件
     * @param filePath 文件路径
     * @param sheetNum 读取的工作区间
     * @return  返回工作区间的值
     * @throws Exception
     */
    public static List<Object[]> readXls(String filePath,int sheetNum) throws Exception{
        FileInputStream file= new FileInputStream(filePath);
        POIFSFileSystem ts= new POIFSFileSystem(file);
        //返回结果集
        List<Object[]> datas = new ArrayList<Object[]>();
        HSSFWorkbook wb=new HSSFWorkbook(ts);

        //获取Excel的工作区间
        for (int i = 0 ; i < wb.getNumberOfSheets(); i ++) {
            //判断是否为需要取得工作区间
            if (i != sheetNum) {
                continue;
            }
            HSSFSheet sh = wb.getSheetAt(i);
            if (sh == null) {
                return datas;
            }
            //获取总共有多少行数据因为中间空行的话，则读取出来的数据不准确
            int hasRowNum =  sh.getPhysicalNumberOfRows();
            //已经处理了的行数
            int procssedNum = 0;
            for (int j = 0;  ; j++) {
                HSSFRow rowTitle = sh.getRow(j);
                if (rowTitle != null) {
                    //获取每一行的长度
                    int colsNum = rowTitle.getLastCellNum();
                    if (colsNum > 0) {
                        Object[] colData = new Object[colsNum];
                        for (int k = 0; k < colsNum; k++) {
                            colData[k] = rowTitle.getCell(k);
                        }
                        datas.add(colData);
                    }
                    procssedNum++;
                    if (procssedNum == hasRowNum) {
                        break;
                    }
                }
            }
        }
        file.close();
        return datas;
    }

}