

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <meta charset="UTF-8">
	<#include "../head.ftl" >
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <title>重置密码</title>
    <!--必要样式-->
    <link href="${basePath}/css/recharge/styles.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}/css/recharge/demo.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}/css/recharge/loaders.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}/css/drag/drag.css" rel="stylesheet" type="text/css" />
    <script src="${basePath}/js/common/particleground/Particleground.js" type="text/javascript"></script>
    <script  src="${basePath}/js/common/layer/layer.js"></script>
    <script  src="${basePath}/js/common/drag/drag.js"></script>
    <script type="text/javascript" src="${basePath}/js/encrypt/aes.js"></script>
    <script type="text/javascript" src="${basePath}/js/encrypt/mode-ecb.js"></script>
	<style>
        .sms {
            border-radius: 50px;
            background: transparent;
            padding: 5px 50px;
            border: 0px solid #4FA1D9;
            color: #4FA1D9;
            text-transform: uppercase;
            font-size: 11px;
        }

	</style>
</head>
<body>
<div class='login'>
    <div class='login_title'>
        <span>重置密码</span>
    </div>
    <div class='login_fields'>
        <div class='login_fields__user'>
            <div class='icon'>
                <img alt="" src='${basePath}/css/recharge/img/user_icon_copy.png'>
            </div>
            <input name="login" placeholder='手机号码' maxlength="16" id="telPhoneId" type='text' autocomplete="off" />
            <div class='validation'>
                <img alt="" src='${basePath}/css/recharge/img/tick.png'>
            </div>
        </div>
        <div class='login_fields__password'>
            <div class='icon'>
                <img alt="" src='${basePath}/css/recharge/img/key.png'>
            </div>
            <input  name="code" id="code" placeholder='短信验证码' maxlength="6" type='text' name="ValidateNum" autocomplete="off" style="padding-left: 65px;padding-right: 10px;">
                <a  id="sendVerfiCode" class='sms' href="javascript:;" style="color: #5e5e5e;">获取验证码</a>

			<div style="width:100%;padding: 20px 30px;">
            	<div id="drag" style="width: 80%;"></div>
			</div>
        </div>
        <div class='login_fields__submit'>
            <input type='button' id="buttonSubmit" value='重置密码'>
        </div>
    </div>

</div>
<script type="text/javascript">
    var telPhoneFlag = false;
    var canSubm = false;
	$(function(){
        $("#telPhoneId").bind("input propertychange",function(event){
            var telPhone= $("#telPhoneId").val();
            telPhoneFlag = false;
            if (telPhone && telPhone != null && telPhone != '' && telPhone.length == 11 && !isCountDown ) {
                if (!isPhoneNo(telPhone)) {
                    layer.msg('电话号码错误！',function(){});
                    return;
                }
                $.post("${basePath}/u/userPhone.shtml",{phone: telPhone} ,function(result){
                    if (result == null || result.level == null || result.level != 1) {
                        layer.msg('电话号码错误！',function(){});
                        canClick=false;
                        $('#sendVerfiCode').css('color','#5e5e5e');
                        $('#sendVerfiCode').attr("href", 'javascript:;');
                    } else {
                        $('#sendVerfiCode').css('color','blue');
                        canClick=true;
                        telPhoneFlag=true;
//                        canSubmit();

                    }
                },"json");

            } else {
                canClick=false;
                $('#sendVerfiCode').css('color','#5e5e5e');
                $('#sendVerfiCode').attr("href", 'javascript:;');
            }
        });

        $('#sendVerfiCode').click(function(){
            if (canClick) {
                //获取手机号码
                var telPhone = $('#telPhoneId').val();
                isCountDown = true;
                canClick = false;
                $.ajax({
                    type: "POST",
                    url: "/interface/meaage/send.shtml",
                    data: {telPhone:telPhone},
                    dataType: "json",
                    beforeSend: function(request) {
                        request.setRequestHeader("Authorization", getAuthorization());
                    },
                    success: function(data) {
                        if (data.level == 1) {

                        } else {
                            layer.msg(data.messageText,function(){});
                        }
                    },
                    error: function(data) {
                        layer.msg('系统错误请联系管理员',function(){});
                    }
                });

                $('#sendVerfiCode').css('color','#5e5e5e');
                $('#sendVerfiCode').attr("href", 'javascript:;');
                settime();
            }
        });

        $('#buttonSubmit').click(function (){
            if (!canSubm) {
                layer.msg('请先拉动验证滚动条！',function(){});
                return;
			}
            var telPhone = $('#telPhoneId').val();
            var code = $('#code').val();
            $.post("${basePath}/u/rePass.shtml",{phone: telPhone,code:code} ,function(result){
                if (result == null || result.level == null || result.level != 1) {
                    layer.msg(result.messageText,function(){});
                } else {
                    layer.msg(result.messageText,function(){});
                    window.location.href='/u/login.shtml'

                }
            },"json");
		});
	});

    //倒计时
    var countdown=60;
    var canClick=false;
    var isCountDown = false;


    function settime() {


        if (countdown == 0) {
            $('#sendVerfiCode').html('发送验证码');
            $('#sendVerfiCode').css('color','blue');
            countdown = 60;
            canClick=true;
            isCountDown = false;
            return;
        } else {
            $('#sendVerfiCode').html("发送验证码(" + countdown + "s)");
            countdown--;
        }
        setTimeout(function() {
                    settime() }
                ,1000)
    }
    //粒子背景特效
    $('body').particleground({
        dotColor: '#E8DFE8',
        lineColor: '#133b88'
    });

//    function canSubmit(){
//        if (telPhoneFlag) {
//            $('#buttonSubmit').removeAttr('disabled');
//            $('#buttonSubmit').attr('class','btn-bm1');
//        } else {
//            $('#buttonSubmit').attr('disabled','disabled');
//            $('#buttonSubmit').attr('class','btn-bm1 disable');
//        }
//    }

    // 验证手机号
    function isPhoneNo(phone) {
        var pattern = /^1[34578]\d{9}$/;
        return pattern.test(phone);
    }

    function getAuthorization(){

        var sessionId = 'visitor';
        var date = new Date().Format("yyyy-MM-dd HH:mm:ss");
        return encrypt(sessionId + "," + date);
    }

    function encrypt(word) {
        var key = CryptoJS.enc.Utf8.parse('tJjwxDz4WF0Sf9JT');
        var srcs = CryptoJS.enc.Utf8.parse(word);
        var encrypted = CryptoJS.AES.encrypt(srcs, key, {mode:CryptoJS.mode.ECB,padding: CryptoJS.pad.Pkcs7});
        return encrypted.toString();
    }

    // 对Date的扩展，将 Date 转化为指定格式的String
    // 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
    // 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
    Date.prototype.Format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "H+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }

    $('#drag').drag();
    function dragComplete() {
        canSubm = true;
    }
</script>
</body>
</html>
