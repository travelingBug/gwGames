package com.sojson;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.math.BigDecimal;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.*;

import com.sojson.common.utils.MathUtil;
import com.sojson.common.utils.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import sun.misc.BASE64Encoder;


public class Test
{
    /**
     * @功能：手工构建一个简单格式的Excel
     */
    private static List<Member> getMember() throws Exception
    {
        List list = new ArrayList();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-mm-dd");

        Member user1 = new Member(1, "熊大", 24, df.parse("1993-08-28"));
        Member user2 = new Member(2, "熊二", 23, df.parse("1994-08-19"));
        Member user3 = new Member(3, "熊熊", 24, df.parse("1983-11-22"));
        list.add(user1);
        list.add(user2);
        list.add(user3);

        return list;
    }

    public static void main(String[] args) throws Exception
    {
//        new BASE64Encoder
//        // 第一步，创建一个webbook，对应一个Excel文件
//        XSSFWorkbook wb = new XSSFWorkbook();
//        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
//        Sheet sheet = wb.createSheet("学生表一");
//        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
//        Row row = sheet.createRow((int) 0);
//        // 第四步，创建单元格，并设置值表头 设置表头居中
//        CellStyle style = wb.createCellStyle();
////        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
//
//        Cell cell = row.createCell((short) 0);
//        cell.setCellValue("学号");
//        cell.setCellStyle(style);
//        cell = row.createCell((short) 1);
//        cell.setCellValue("姓名");
//        cell.setCellStyle(style);
//        cell = row.createCell((short) 2);
//        cell.setCellValue("年龄");
//        cell.setCellStyle(style);
//        cell = row.createCell((short) 3);
//        cell.setCellValue("生日");
//        cell.setCellStyle(style);
//
//        // 第五步，写入实体数据 实际应用中这些数据从数据库得到，
//        List list = Test.getMember();
//
//        for (int i = 0; i < list.size(); i++)
//        {
//            row = sheet.createRow((int) i + 1);
//            Member stu = (Member) list.get(i);
//            // 第四步，创建单元格，并设置值
//            row.createCell((short) 0).setCellValue((double) stu.getCode());
//            row.createCell((short) 1).setCellValue(stu.getName());
//            row.createCell((short) 2).setCellValue((double) stu.getAge());
//            cell = row.createCell((short) 3);
//            cell.setCellValue(new SimpleDateFormat("yyyy-mm-dd").format(stu
//                    .getBirth()));
//        }
//        // 第六步，将文件存到指定位置
//        try
//        {
//            FileOutputStream fout = new FileOutputStream("D:/Members.xlsx");
//            wb.write(fout);
//            fout.close();
//        }
//        catch (Exception e)
//        {
//            e.printStackTrace();
//        }


//        String pwd = String.format("%s#%s","123","123");
//        pwd = MathUtil.getMD5(pwd);
//        System.out.println(pwd);
String[] accountArr = {"5788158","5737087","5717756","5775945","5735530","5771978","5760065","5781504","5772176","5702997","5785716","5759258","5772377","5719671","5747333","5785374","5719976","5740511","5761283","5718463","5784304","5708334","5702702","5721883","5722977","5745732","5752033","5716834","5776277","5796003","5780083","30401342","5767462","5751541","30407693","5764456","50091836","5705693","5739980","5738202","5780386","5736295","5703249","5710715","5789596","30400668","5778847","5768403","5773127","5753291"};
        FileOutputStream fos=new FileOutputStream(new File("D:/12.sql"));
        OutputStreamWriter osw=new OutputStreamWriter(fos, "UTF-8");
        BufferedWriter bw=new BufferedWriter(osw);
        String player = "insert into tb_player (ID,ACCOUNT_NAME,NAME,ID_CARD,TEL_PHONE,DEL_FLAG,AUDIT_FLAG,CRT_TIME,ACCOUNT,CAPITAL) values (";
        List<Integer> idCards = new ArrayList<Integer>();
        Map<Integer,Double> playerMoney = new HashMap<Integer,Double>();
        Map<Integer,Double> balanceMoneyMap = new HashMap<Integer,Double>();

        //插入300个参赛选手
        for (int i = 0; i < 50 ; i++) {
            idCards.add(i);
            String playerData = player + "'"+ StringUtils.getUUID32()+"',";
            playerData += "'测试账号A"+i+"',";
            playerData += "'测试账号"+i+"',";
            playerData += "'"+i+"',";
            playerData += "'"+i+"',";
            playerData += "0,";
            playerData += "1,";
            playerData += "'2018-09-21 00:00:00',"+accountArr[i]+",'300000');";
            bw.write(playerData+"\t\n");
            playerMoney.put(i,300000d);
            balanceMoneyMap.put(i,300000d);
            System.out.println(playerData);
        }


        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");

        Date today = f.parse("2018-10-01");

        //股票
        List<String> gp = new ArrayList<>();
        //股票名称
        List<String> gpName = new ArrayList<>();
        //股票价格
        List<Double> gpMoney1 = new ArrayList<>();

        List<Double> gpMoney2 = new ArrayList<>();
        for (int i = 0 ; i < 20 ; i++){
            gp.add("股票代码"+i);
            gpName.add("股票名称"+i);
            gpMoney1.add(i+0.12);
            gpMoney2.add((30-i)+0.25);
        }
        Random random = new Random();
        String gainsInfo = "insert into tb_gains_info (ACCOUNT,SHARES_CODE,SHARES_NAME,BUSINESS_FLAG,VOLUME,PRICE,BALANCE_MONEY,TOTAL_MONEY,BUSINESS_TIME,CRT_TIME,AMOUNT) values (";


        //简写如下：
        //BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(
        //        new FileOutputStream(new File("E:/phsftp/evdokey/evdokey_201103221556.txt")), "UTF-8"));



        for (int i = 0; i < 300 ; i++) { //IDCARD
            Calendar c = Calendar.getInstance();
            c.setTime(today);
            for (int j = 0; j < 310; j++) { //天数


                String gainsInfoData = gainsInfo + "'"+i+"',";
                int a = random.nextInt(20);
                gainsInfoData +="'"+gp.get(a)+"',";
                gainsInfoData +="'"+gpName.get(a)+"',";
                int b = random.nextInt(2);
                gainsInfoData +="'"+ b +"',";
                int volume = random.nextInt(101);
                gainsInfoData +="'"+ volume +"',";
                int a2 = random.nextInt(2);
                double money = 0;
                if (a2 == 0) {
                    gainsInfoData +="'"+gpMoney1.get(a)+"',";
                    money = gpMoney1.get(a);

                }else {
                    gainsInfoData +="'"+gpMoney2.get(a)+"',";
                    money = gpMoney2.get(a);
                }

                int balanceMoney = 0;


                BigDecimal bg = new BigDecimal(random.nextInt(5000) + random.nextDouble());
                if (b == 0) {
                    BigDecimal xx1 = new BigDecimal((balanceMoneyMap.get(i) + volume * money));
                    gainsInfoData +="'"+  xx1.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()+"',";


                    int jiajian = random.nextInt(2);
                    double nn =bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
                    double total = playerMoney.get(i);
                    if (jiajian == 0) {
                        total = total + nn;
                    } else {
                        total = total - nn;
                    }
                    BigDecimal xx = new BigDecimal(total);
                    gainsInfoData +="'"+  xx.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() +"',";
                    playerMoney.put(i,total);
                }else {
                    BigDecimal xx1 = new BigDecimal((balanceMoneyMap.get(i) + volume * money));
                    gainsInfoData +="'"+ xx1.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() +"',";

                    int jiajian = random.nextInt(2);
                    double nn = bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
                    double total = playerMoney.get(i);
                    if (jiajian == 0) {
                        total = total + nn;
                    } else {
                        total = total - nn;
                    }
                    BigDecimal xx = new BigDecimal(total);
                    gainsInfoData +="'"+ xx.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() +"',";
                    playerMoney.put(i,total);
                }

                gainsInfoData +="'"+f.format(c.getTime())+" 00:00:00',";
                gainsInfoData +="'"+f.format(c.getTime())+" 00:00:00',";
                BigDecimal tt = new BigDecimal(volume*money);
                gainsInfoData +="'"+  tt.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() +"');";
                c.add(Calendar.DAY_OF_MONTH, 1);// 今天+i天
                bw.write(gainsInfoData+"\t\n");
            }
        }


        //注意关闭的先后顺序，先打开的后关闭，后打开的先关闭
        bw.close();
        osw.close();
        fos.close();

    }
}
