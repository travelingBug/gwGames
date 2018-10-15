<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>股王大赛</title>
    <%@include file="../head.jsp" %>
    <script  src="<%=basePath%>/js/bankCardAttribution.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
    <link href="${basePath}/css/gwGame.css?${_v}" rel="stylesheet"/>
</head>
<body>
<div class="pageWrapper2 bg-gray me style1" id="pay_main_div">
    <%@include file="../top.jsp" %>
    <ul class="page-nav">
        <li><a>我的账户</a></li>
        <li>></li>
        <li><span>充值中心</span></li>
    </ul>
    <div class="main-box">
        <div class="content bg-white">
            <div class="head-box">
                <img src="images/img_head.png"/>
            </div>
            <div class="head-cont-box">
                <h3><span>ITS-GUSHEN</span><span class="tag">B类</span></h3>
                <p class="day">剩余观看比赛日期<b>20天</b></p>
                <p>目前权限：前20名选手早盘午盘实盘赛况。</p>
            </div>
        </div>
        <div class="content bg-white">
            <div class="select-box">
                <div class="one-area on">
                    <i class="icon-on"></i>
                    <div class="img-area">
                        <span class="L">A类</span>
                        <span class="R">¥5000/月</span>
                    </div>
                    <p>前20名选手早盘午盘实盘赛况</p>
                </div>
                <div class="one-area">
                    <div class="img-area">
                        <span class="L">B类</span>
                        <span class="R">¥2000/月</span>
                    </div>
                    <p>前20名选手24小时实盘赛况</p>
                </div>
                <div class="one-area">
                    <div class="img-area">
                        <span class="L">C类</span>
                        <span class="R">¥500/月</span>
                    </div>
                    <p>前20名选手48小时实盘赛况</p>
                </div>
            </div>
            <div class="select-box">
                <p class="title-style">选择方式：</p>
                <div class="select-cont">
                    <a class="select-btn">充值</a>
                    <a class="select-btn on"><i class="icon-on"></i>升级</a>
                </div>
            </div>
            <div class="select-box">
                <p class="title-style">支付方式：</p>
                <div class="select-cont">
                    <div class="one">
                        <p class="radio-style"><input type="radio"/></p>
                        <p class="tit">中国建设银行</p>
                        <p>***1231</p>
                        <p>储蓄卡|快捷</p>
                        <p>支付<b>5000.00</b>元</p>
                    </div>
                    <div class="one on">
                        <p class="radio-style"><input type="radio"/></p>
                        <p class="tit">中国建设银行</p>
                        <p>***1231</p>
                        <p>储蓄卡|快捷</p>
                        <p>支付<b>5000.00</b>元</p>
                    </div>
                    <a class="add-btn" id="pay_add_bank">添加快捷/网银付款</a>
                </div>
            </div>
            <div class="select-box">
                <p class="title-style">支付密码：</p>
                <div class="select-cont">
                    <div class="input-numb">
                        <input type="password" class="width-60"/>
                        <input type="password" class="width-60"/>
                        <input type="password" class="width-60"/>
                        <input type="password" class="width-60"/>
                        <input type="password" class="width-60"/>
                        <input type="password" class="width-60"/>
                    </div>
                    <p class="tip">请输入6位数字支付密码</p>
                </div>
            </div>
            <a class="btn-zf">确认支付</a>
        </div>
    </div>
    <%@include file="../bottom.jsp" %>
    <%@include file="../footer.jsp" %>
</div>

<div class="overlay layer-small recharge" id="pay_bank_div">
    <div class="overlay-bg"></div>
    <div class="float-div">
        <a class="icon icon-close" id="pay_icon_close"></a>
        <h3 class="title">快捷支付</h3>
        <div class="content">
            <table class="table2" id="pay_table">
                <tbody>
                <form action="#" method="post" id="addBankForm">
                <tr>
                    <th>付款银行：</th>
                    <td><span id="pay_bank" name="bankName"></span></td>
                </tr>
                <tr>
                    <th>银行卡号：</th>
                    <td>
                        <input  class="input width-240" id="pay_bank_no" name="cardNo"/>
                        <input id="cardCode" type="hidden" name="cardCode"/>
                        <span class="icon-vali"></span>
                    </td>
                </tr>
                <tr>
                    <th>姓     名：</th>
                    <td>
                        <input class="input width-240" id="pay_name" name="cardName"/>
                        <span class="icon-vali"></span>
                    </td>
                </tr>
                <tr>
                    <th>证件号码：</th>
                    <td>
                        <input class="input width-240" id="pay_cardno" name="idNo"/>
                        <span class="icon-vali"></span>
                    </td>
                </tr>
                <%--<tr>--%>
                    <%--<th>手     机：</th>--%>
                    <%--<td><input class="input width-240"/><span class="icon-vali"></span></td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                    <%--<th>短信验证：</th>--%>
                    <%--<td><input class="input width-100" /><a class="yzm">获取验证码</a></td>--%>
                <%--</tr>--%>
                <tr>
                    <th></th>
                    <td><a class="btn-register" onclick="addBank();" id="pay_add_btn">同意开通</a></td>
                </tr>
                </tbody>
                </form>
            </table>
        </div>
    </div>
</div>
</body>
<script>
    $(function() {
        openOrCloseAddBank();

        getBankCardInfo();

        validata();

        set4space();

    });

    /**
     * 打开/关闭添加银行
     */
    function openOrCloseAddBank(){
        $("#pay_add_bank").click(function(){
            $("#pay_bank_div").show();

            $("#pay_bank").text();
            $("#pay_bank_no").val();
            $("#cardCode").val();
            $("#pay_name").val();
            $("#pay_cardno").val();

            $('body,html').animate({
                scrollTop: 1100
            }, 500);
        });

        $("#pay_icon_close").click(function(){
            $("#pay_bank_div").hide();
        });
    }

    /**
     * 取得银行卡信息
     */
    function getBankCardInfo(){
        $("#pay_bank_no").blur(function(){

           var cardNo = Trim($("#pay_bank_no").val(),"g");
           console.log(Trim(cardNo,"g"));
           var bankInfo = bankCardAttribution(cardNo);
           console.log(bankInfo);

            if(bankInfo!='error') {
                if(bankInfo.cardTypeName!='信用卡') {
                    $("#pay_bank").text(bankInfo.bankName);
                    $("#cardCode").val(bankInfo.bankCode);
                    setTip($(this),"",1);
                }else{
                    setTip($(this),"不支持信用卡",0);
                }
            }else{
                setTip($(this),"错误的银行卡号",0);
            }
        });
    }

    /**
     * 设置4位空格
     */
    function set4space(){
        $('#pay_bank_no').on('keyup', function(e) {

            var c=$(this);
            if(/[^\d]/.test(c.val())){//替换非数字字符
                var temp_amount=c.val().replace(/[^\d]/g,'');
                $(this).val(temp_amount);
            }
            //只对输入数字时进行处理
//            if((e.which >= 48 && e.which <= 57) ||
//                    (e.which >= 96 && e.which <= 105 )){
//                //获取当前光标的位置
//                var caret = this.selectionStart;
//                //获取当前的value
//                var value = this.value;
//                //从左边沿到坐标之间的空格数
//                var sp =  (value.slice(0, caret).match(/\s/g) || []).length;
//                //去掉所有空格
//                var nospace = value.replace(/\s/g, '');
//                //重新插入空格
//                var curVal = this.value = nospace.replace(/\D+/g,"").replace(/(\d{4})/g, "$1 ").trim();
//                //从左边沿到原坐标之间的空格数
//                var curSp = (curVal.slice(0, caret).match(/\s/g) || []).length;
//                //修正光标位置
//                this.selectionEnd = this.selectionStart = caret + curSp - sp;
//
//            }

            var value=$(this).val().replace(/\s/g,'').replace(/(\d{4})(?=\d)/g,"$1 ");
            $(this).val(value)

        })
    }

    /**
     * 去掉空格
     * @param str
     * @param is_global
     * @returns {XML|void|*|string}
     * @constructor
     */
    function Trim(str,is_global){

        var result;

        result = str.replace(/(^\s+)|(\s+$)/g,"");

        if(is_global.toLowerCase()=="g"){

            result = result.replace(/\s/g,"");

        }

        return result;

    }

    function validata(){
        $("#pay_name").blur(function(){
            var name = Trim($("#pay_name").val(),"g");
            var realname = /^([\u4e00-\u9fa5]{2,8}|[a-zA-Z]{2,16})$/g;

            if(realname.test(name)){
                setTip($(this),"",1);
            }else{
                setTip($(this),"请输入正确的姓名",0);
            }
        });

        $("#pay_cardno").blur(function(){
            var cardno = Trim($("#pay_cardno").val(),"g");
            var isIDCard1 = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;//(15位)
            var isIDCard2 = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;//(18位)

            if(isIDCard1.test(cardno) || isIDCard2.test(cardno)){
                setTip($(this),"",1);
            }else{
                setTip($(this),"请输入正确的身份证",0);
            }

        });
    }

    function addBank(){

        $("#pay_add_btn").click(function(){

            if($("#pay_table").find(".fail").length<=0){
                var sessionId = sessionStorage.getItem("sessionId");
                var payBank = $("#pay_bank").text();
                var cardNo = Trim($("#pay_bank_no").val(), "g");
                var cardCode = Trim($("#cardCode").val(),"g");
                var payName = Trim($("#pay_name").val(),"g");
                var idNo = Trim($("#pay_cardno").val(),"g");
                var bankInfo = "bankName="+payBank+"&cardNo="+cardNo+"&cardCode="+cardCode+"&cardName="+payName+"&idNo="+idNo;

                $.ajax({
                    type: "POST",
                    url: "interface/vipsBankCard/addBankCard.shtml",
                    data: {bankInfo,sessionId},
                    dataType: "json",
                    beforeSend: function (request) {
                        request.setRequestHeader("Authorization", getAuthorization());
                    },
                    success: function (result) {
                        $("#pay_bank_div").hide();
                    }, error: function (result) {

                    }

                });
            }
        });

    }

    /**
     *
     * @param obj 对象
     * @param msg 提示信息
     * @param s 1-正确 0-错误
     */
    function setTip(obj,msg,s){
        $(obj).siblings(".icon-vali").empty();
        if(s){
            $(obj).siblings(".icon-vali").append("<i class='fas fa-check-circle pass'></i>");
        }else{
            $(obj).siblings(".icon-vali").append("<i class='fas fa-times-circle fail' title='"+msg+"'></i>");
        }
    }


</script>
</html>
