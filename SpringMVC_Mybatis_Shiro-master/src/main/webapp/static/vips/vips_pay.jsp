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
            <div class="head-cont-box" id="pay_vip_info">
                <h3><span id="nickName"></span><span id="level"></span><input type="hidden" id="level-data"/> </h3>
                <p class="day" id="endTime"></p>
                <p id="level_info"></p>
            </div>
        </div>
        <div class="content bg-white">
            <div class="select-box">
                <div class="one-area">
                    <div class="img-area img-a">
                        <span class="L"></span>
                        <span class="R"></span>
                    </div>
                    <p>前20名选手早盘午盘实盘赛况</p>
                </div>
                <div class="one-area">
                    <div class="img-area img-b">
                        <span class="L"></span>
                        <span class="R"></span>
                    </div>
                    <p>前20名选手24小时实盘赛况</p>
                </div>
                <div class="one-area">
                    <div class="img-area img-c">
                        <span class="L"></span>
                        <span class="R"></span>
                    </div>
                    <p>前20名选手48小时实盘赛况</p>
                </div>
                <input type="hidden" id="pay_ticket"/>
            </div>
            <div class="select-box">
                <p class="title-style">选择方式：</p>
                <div class="select-cont">
                    <a class="select-btn on"><i class="icon-on"></i>购票</a>
                </div>
            </div>
            <div class="select-box">
                <p class="title-style">支付方式：</p>
                <div class="select-cont" id="pay_list">
                </div>
            </div>
            <div class="select-box" id="pay_yzm">
                <p class="title-style">验证码：</p>
                <div class="select-cont">
                    <div class="input-numb">
                        <input type="text" class="width-60 smsCode" readonly="true" maxlength="1"/>
                        <input type="text" class="width-60 smsCode" readonly="true" maxlength="1"/>
                        <input type="text" class="width-60 smsCode" readonly="true" maxlength="1"/>
                        <input type="text" class="width-60 smsCode" readonly="true" maxlength="1"/>
                        <input type="text" class="width-60 smsCode" readonly="true" maxlength="1"/>
                        <input type="text" class="width-60 smsCode" readonly="true" maxlength="1"/>
                        <input type="hidden" id="smsCode"/>
                        <a class="yzm width-60" id="sendSmsCode" onclick="sendSmsCode();">获取验证码</a>
                    </div>
                    <p class="tip">请输入验证码</p>
                </div>
            </div>
            <a class="btn-zf" id="pay_zf" onclick="pay();">确认支付</a>
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
                <tr>
                    <th>手机号码：</th>
                    <td>
                        <input class="input width-240" id="pay_phone" name="bankPhone"/>
                        <span class="icon-vali"></span>
                    </td>
                </tr>
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

        queryVipsCards();

        getBankCardInfo();

        validata();

        set4space();

        $("#pay_icon_close").click(function(){
            $("#pay_bank_div").hide();
        });

        switchTicket();

        focusNextInput();

        queryVipsInfo();

    });

    var smsCodeFlag = false;
    var payFlag = false;
    var p1 = false;

    function canSendSmsCode() {
        valiParams();
        if (smsCodeFlag) {
            $('#sendSmsCode').removeAttr('disabled');
            $('#sendSmsCode').attr('class', 'yzm');
        } else {
            $('#sendSmsCode').attr('disabled', 'disabled');
            $('#sendSmsCode').attr('class', 'yzm-disable');
        }
    }

    function canPay() {
        valiPay();
        if (payFlag && smsCodeFlag && p1) {
            $('#pay_zf').removeAttr('disabled');
            $('#pay_zf').attr('class', 'btn-zf');
        } else {
            $('#pay_zf').attr('disabled', 'disabled');
            $('#pay_zf').attr('class', 'btn-zf-disable');
        }
    }
    /**
     * 打开添加银行
     */
    function openAddBank(){
            $("#pay_bank_div").show();

            $("#pay_bank").text();
            $("#pay_bank_no").val();
            $("#cardCode").val();
            $("#pay_name").val();
            $("#pay_cardno").val();

            $('body,html').animate({
                scrollTop: 700
            }, 500);
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

//        $("#pay_add_btn").click(function(){

            if($("#pay_table").find(".fail").length<=0){
                var payBank = $("#pay_bank").text();
                var cardNo = Trim($("#pay_bank_no").val(), "g");
                var cardCode = Trim($("#cardCode").val(),"g");
                var payName = Trim($("#pay_name").val(),"g");
                var idNo = Trim($("#pay_cardno").val(),"g");
                var bankPhone = $("#pay_phone").val();
                var bankInfo = {
                    "bankName":payBank,
                    "cardNo":cardNo,
                    "cardCode":cardCode,
                    "cardName":payName,
                    "idNo":idNo,
                    "bankPhone":bankPhone
                }

                $.ajax({
                    type: "POST",
                    url: "interface/vipsBankCard/addBankCard.shtml",
                    data: bankInfo,
                    dataType: "json",
                    beforeSend: function (request) {
                        request.setRequestHeader("Authorization", getAuthorization());
                    },
                    success: function (result) {
                        $("#pay_bank_div").hide();
                        layer.alert(result.messageText, {
                            icon: 0,
                            skin: 'layui-layer-lan'
                        });
                        queryVipsCards();
                    }, error: function (result) {

                    }

                });
            }
//        });

    }

    function delBank(cardNo){
        $.ajax({
            type: "GET",
            url: "interface/vipsBankCard/delBankCard.shtml",
            data: {"cardNo":cardNo},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (result) {
                $("#pay_bank_div").hide();
                layer.alert(result.messageText, {
                    icon: 0,
                    skin: 'layui-layer-lan'
                });
                queryVipsCards();
            }, error: function (result) {

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

    /**
     * 查询银行卡列表
     */
    function queryVipsCards(){
        $.ajax({
            type: "POST",
            url: "interface/vipsBankCard/list.shtml",
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (result) {
                setCardsData(result);
            }, error: function (result) {

            }

        });
    }

    /**
     * 设置数据
     * @param data
     */
    function setCardsData(data){
        $("#pay_list").empty();
        var html = "";
        for(var i=0; i<data.length; i++) {
            var cardNo = data[i].cardNo;
            cardNo = cardNo.replace(/^.+(.{4})$/g, "******$1");
            html += '<div class="one" data-card="'+data[i].cardNo+'"><p class="radio-style"><input type="radio"/></p>' +
                    '<p class="tit">'+data[i].bankName+'</p><p>'+cardNo+'</p><p>储蓄卡|快捷</p>' +
                    '<p id="icon-bank-del"><i class="far fa-trash-alt del" title="删除" onclick="delBank(\''+data[i].cardNo+'\')"></i></p></div>';
        }
        $("#pay_list").append(html);
        $("#pay_list .one:last-child").addClass("on");
        $("#pay_list .one:last-child").find("input[type='radio']").attr("checked","checked");
        var length = $("#pay_list .one").length;
        if(length<5){
            $("#pay_list").append('<a class="add-btn" id="pay_add_bank" onclick="openAddBank();">添加快捷/网银付款</a>');
        }

        canSendSmsCode();

        canPay();
    }

    function switchTicket(){
        $(".one-area").click(function(){
            var index = $(".one-area").index(this);
            var levelData = $("#level-data").val();
            var fee = 0;
            if(index==0){
                if(levelData==1) {
                    return false;
                }
                fee = "A";
            }else if(index==1){
                if(levelData<=2 && levelData>0){
                    return false;
                }
                fee = "B";
            }else if(index==2){
                if(levelData<=3 && levelData>0){
                    return false;
                }
                fee = "C";
            }
            $("#pay_ticket").val(fee);

            $(".one-area i").remove();
            $(this).addClass("on");
            $(this).siblings().removeClass("on");
            $(this).prepend('<i class="icon-on"></i>');

            canSendSmsCode();
        });
    }

    function focusNextInput(){
        $("#pay_yzm").find(':text').on('keyup', function(e) {

            var c=$(this);
            if(/[^\d]/.test(c.val())){//替换非数字字符
                var temp_amount=c.val().replace(/[^\d{1}]/g,'');
                $(this).val(temp_amount);
            }

//            if(e.keyCode>=48&&e.keyCode<=57){
                /*输入0-9*/
                changeDiv();

            if(e.keyCode=="8") {
                /*退格回删事件*/
                returnDiv();

            }


            payFlag = valiPay();
            if(payFlag){
                var str = "";
                $("#pay_yzm").find(':text').each(function(n){
                    if($(this).val()!=""){
                        str += $(this).val();
                    }
                });
                $("#smsCode").val(str);
                canPay();
            }
        });
    }

    //倒计时
    var countdown=60;
    var canClick=false;
    var isCountDown = false;
    function sendSmsCode(){
        if(!smsCodeFlag){
            return false;
        }

        var fee = $("#pay_ticket").val();
        var smsCode = $("#smsCode").val();
        var cardNo = $("#pay_list .on").attr("data-card");
        var data = {
            "fee":fee,
            "smsCode":smsCode,
            "cardNo":cardNo,
            "step":"p1"
        }
        $.ajax({
            type: "POST",
            url: "interface/vipsBankCard/addOrder.shtml",
            dataType: "json",
            data: data,
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (result) {
                layer.alert(result.messageText, {
                    icon: 0,
                    skin: 'layui-layer-lan'
                });
                p1 = true;
            }, error: function (result) {

            }
        });

        $('#smsCode').css('color','#5e5e5e');
        $('#smsCode').attr("href", 'javascript:;');
        settime();
    }

    function pay(){
        if($('#pay_zf').attr('disabled')){
            return false;
        }

        var fee = $("#pay_ticket").val();
        var smsCode = $("#smsCode").val();
        var cardNo = $("#pay_list .on").attr("data-card");
        var data = {
            "fee":fee,
            "smsCode":smsCode,
            "cardNo":cardNo,
            "step":"p3"
        }
        $.ajax({
            type: "POST",
            url: "interface/vipsBankCard/addOrder.shtml",
            dataType: "json",
            data: data,
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (result) {
                layer.alert(result.messageText, {
                    icon: 0,
                    skin: 'layui-layer-lan'
                });
                if(result.messageText=="支付成功"){
//                    queryVipsInfo();
                    window.location.href="/static/gains/strategy.jsp";
                }

            }, error: function (result) {

            }

        });
    }

    function valiPay(){
        var num=0;
        $("#pay_yzm").find(':text').each(function(n){
            if($(this).val()==""){
                num++;
            }
        });
        if(num>0){
            return false;
        }else{
            return true;
        }
    }

    function valiParams(){
        var length = $("#pay_list .one").length;
        if(length<0) {
//            layer.alert("请绑定银行卡", {
//                icon: 0,
//                skin: 'layui-layer-lan'
//            });
            return false;
        }

        var fee = $("#pay_ticket").val();
        if(fee==0 || fee==""){
//            layer.alert("请选择观赛门票", {
//                icon: 0,
//                skin: 'layui-layer-lan'
//            });
            return false;
        }

        smsCodeFlag = true;
    }

    function settime() {

        if (countdown == 0) {
            $('#smsCode').html('获取验证码');
            countdown = 60;
            canClick=true;
            isCountDown = false;
            return;
        } else {
            $('#smsCode').html("获取验证码(" + countdown + "s)");
            countdown--;
        }
        setTimeout(function() {
                    settime() }
                ,1000)
    }

    function queryVipsInfo(){
        $.ajax({
            type: "POST",
            url: "interface/vips/queryVipsInfo.shtml",
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (result) {
                $("#pay_vip_info #nickName").text(result.nickName);
                var level = result.level;
                $("#level-data").val(level);
                if(level==1){
                    $("#pay_vip_info #level").text('A类');
                    $("#pay_vip_info #level_info").text("前20名选手早盘午盘实盘赛况");
                    $("#pay_vip_info #level").addClass("tag");
                }else if(level==2){
                    $("#pay_vip_info #level").text('B类');
                    $("#pay_vip_info #level_info").text("前20名选手24小时实盘赛况");
                    $("#pay_vip_info #level").addClass("tag");
                }else if(level==3){
                    $("#pay_vip_info #level").text('C类');
                    $("#pay_vip_info #level_info").text("前20名选手48小时实盘赛况");
                    $("#pay_vip_info #level").addClass("tag");
                }else {
                    $("#pay_vip_info #level").removeClass("tag");
                }
                if(result.endTimeStr!=null) {
                    $("#pay_vip_info #endTime").text(result.endTimeStr);
                }

            }, error: function (result) {

            }

        });
    }

    /**
     * 设置默认选中
     **/
    var paw = $(".smsCode");
    var pawCount=paw.length;
    /*设置第一个输入框默认选中*/
    $(paw[0]).addClass("yzm-highLight");
    paw[0].readOnly=false;
//    paw[0].focus();

    /*定义自动选中下一个输入框事件*/
    var changeDiv = function(){
        for(var i=0;i<pawCount;i++){
            if(paw[i].value.length=="1"){
                if((i+1)<pawCount) {
                    /*处理当前输入框*/
                paw[i].blur();
                $(paw[i]).removeClass("yzm-highLight");
//                paw[i].readOnly = true;

                    /*处理下一个输入框*/
                $(paw[i + 1]).addClass("yzm-highLight");
                paw[i + 1].focus();
                paw[i + 1].readOnly = false;
                }
            }
        }
    };

    /*回删时选中上一个输入框事件*/
    var returnDiv = function(){
        for(var i=0;i<pawCount;i++){
            console.log(i);
            if(paw[i].value.length=="0"){
                if(i>=0) {
                    /*处理当前输入框*/
                    console.log(i);
                    paw[i].blur();
                    $(paw[i]).removeClass("yzm-highLight");
                    paw[i].readOnly = true;

                    /*处理上一个输入框*/
                    $(paw[i - 1]).addClass("yzm-highLight");
                    paw[i - 1].focus();
                    paw[i - 1].readOnly = false;
                    paw[i - 1].value = "";
                    break;
                }
            }
        }
    };



</script>
</html>
