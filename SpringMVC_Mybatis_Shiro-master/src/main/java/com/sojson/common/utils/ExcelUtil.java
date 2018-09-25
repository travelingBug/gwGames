package com.sojson.common.utils;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.*;
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


    /**
     * 写Excel(错误提示信息，最后一行会标红)
     * @param dataList
     * @param excelPath
     * @param sheetName
     * @throws IOException
     */
    public static void writeExcel(List<Object[]> dataList,String excelPath,String sheetName)  throws IOException{
        OutputStream out = null;
        try {
            Workbook workBook = null;
            if(excelPath.toLowerCase().endsWith(".xls")){     //Excel&nbsp;2003
                workBook = new HSSFWorkbook();
            }else if(excelPath.toLowerCase().endsWith(".xlsx")){    // Excel 2007/2010
                workBook = new XSSFWorkbook();
            }
            // sheet 对应一个工作页
            Sheet sheet = workBook.createSheet(sheetName);

            sheet.setDefaultColumnWidth(15);

            CellStyle commStyle = workBook.createCellStyle();
            commStyle.setAlignment(HorizontalAlignment.CENTER);
            commStyle.setVerticalAlignment(VerticalAlignment.CENTER);

            CellStyle errorStyle = workBook.createCellStyle();
            errorStyle.setAlignment(HorizontalAlignment.CENTER);
            errorStyle.setVerticalAlignment(VerticalAlignment.CENTER);
            Font font = workBook.createFont();
            font.setColor(HSSFColor.RED.index);
            errorStyle.setFont(font);
            /**
             * 往Excel中写数据
             */
            for (int j = 0; j < dataList.size(); j++) {
                // 创建一行
                Row row = sheet.createRow(j);
                // 得到要插入的每一条记录
                Object[] objArr = dataList.get(j);
                for (int k = 0; k < objArr.length; k++) {
                    // 在一行内循环
                    Cell cell = row.createCell(k);
                    cell.setCellValue(objArr[k] == null? "":objArr[k].toString());
                    if (k == objArr.length -1) {
                        cell.setCellStyle(errorStyle);
                    } else {
                        cell.setCellStyle(commStyle);
                    }
                }
            }
            // 创建文件输出流，准备输出电子表格：这个必须有，否则你在sheet上做的任何操作都不会有效
            out =  new FileOutputStream(excelPath);
            workBook.write(out);
            workBook.close();
        } finally{
            try {
                if(out != null){
                    out.flush();
                    out.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }


    /**
     * 写Excel(普通Excel，第一行为标题)
     * @param dataList
     * @param excelPath
     * @param sheetName
     * @throws IOException
     */
    public static void writeCommonExcel(List<Object[]> dataList,String excelPath,String sheetName)  throws IOException{
        OutputStream out = null;
        try {
            Workbook workBook = null;
            if(excelPath.toLowerCase().endsWith(".xls")){     //Excel&nbsp;2003
                workBook = new HSSFWorkbook();
            }else if(excelPath.toLowerCase().endsWith(".xlsx")){    // Excel 2007/2010
                workBook = new XSSFWorkbook();
            }
            // sheet 对应一个工作页
            Sheet sheet = workBook.createSheet(sheetName);

            sheet.setDefaultColumnWidth(15);

            CellStyle commStyle = workBook.createCellStyle();
            commStyle.setAlignment(HorizontalAlignment.CENTER);
            commStyle.setVerticalAlignment(VerticalAlignment.CENTER);
            /**
             * 往Excel中写数据
             */
            for (int j = 0; j < dataList.size(); j++) {
                // 创建一行
                Row row = sheet.createRow(j);
                // 得到要插入的每一条记录
                Object[] objArr = dataList.get(j);
                for (int k = 0; k < objArr.length; k++) {
                    // 在一行内循环
                    Cell cell = row.createCell(k);
                    cell.setCellValue(objArr[k] == null? "":objArr[k].toString());
                    cell.setCellStyle(commStyle);
                }
            }
            // 创建文件输出流，准备输出电子表格：这个必须有，否则你在sheet上做的任何操作都不会有效
            out =  new FileOutputStream(excelPath);
            workBook.write(out);
            workBook.close();
        } finally{
            try {
                if(out != null){
                    out.flush();
                    out.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }


}
