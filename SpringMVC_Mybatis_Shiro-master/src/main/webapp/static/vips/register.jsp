<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="../head.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>天下股神实盘大赛</title>
    <link href="${basePath}/css/gwGame.css?${_v}" rel="stylesheet"/>
    <%--<link href="css/all.css" rel="stylesheet" type="text/css" />--%>
    <style>
        .top-box .content .logo1 {
            background:url(images/logo-xhbs.png) no-repeat;
            background-size: 70%;
            width: 421px;
            height: 49px;
            float: left;
            margin-left: -50px;
            margin-bottom: 20px;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='http://60.205.189.94/images/logo.png',sizingMethod='scale');
        }
    </style>
</head>
<body>
<div class="overlay layer-small login">
    <div class="overlay-bg"></div>
    <div class="float-div">
        <a class="icon icon-close loginClose"></a>
        <h3 class="title">登录</h3>
        <div class="content">
            <form action="#" method="post" id="loginForm">
                <div class="one"><div class="input-area" id="loginPhoneDiv"><i class="icon-un"></i><input class="width-250 telPhone" name="phone" placeholder="请输入手机号码"/></div></div>
                <div class="one"><div class="input-area"><i class="icon-pw"></i><input class="width-250 pwd" name="password" type="password" placeholder="请输入密码"/></div></div>
                <div class="one"><div class="left-area"><!--<input type="radio" class="radio">自动登录</div>--><a class="right-area" id="forgetPwd" href="javascript:;">忘记密码？</a></div></div>
                <div class="one"><a class="login-btn" id="loginBtn">登录</a></div>
                <div class="one"><p>还没有账号？<a class="link" href="/static/vips/register.jsp?a=2">立即注册</a></p></div>
            </form>
        </div>
    </div>
</div>
<div class="pageWrapper2 register">
    <div class="top-box">
        <div class="content">
            <%--<div class="logo1" id="topLogo1" style="cursor: pointer;"></div>--%>
            <div class="logo" id="toHomeLogo" style="cursor: pointer;"></div>
            <div class="right-area">
                <p>已有账号？请直接<a class="link loginBtn" href="/static/vips/register.jsp?a=1">登录</a></p>
            </div>
        </div>
    </div>
    <div class="main">
        <div class="content">
            <div class="title">
                <h3>注册</h3>
            </div>
            <form action="#" method="post" id="registerForm">
                <table class="table2">
                    <tbody>
                    <tr>
                        <th><span style="color: red;">*</span>昵称：</th>
                        <td id="nickNameTd"><input id="nickName" name="nickName" class="input width-240" /><span class="icon-vali"></span></td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span>密码：</th>
                        <td id="pwdTd"><input id="pwd" name="password" type="password" class="input width-240 pwd" /><span class="icon-vali"></span></td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span>确认密码：</th>
                        <td id="rePwdTd"><input id="rePwd" type="password" class="input width-240 pwd" /><span class="icon-vali"></span></td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span>推荐码：</th>
                        <td id="inviteCodeTd">
                            <input id="inviteCode" name="inviteCode" class="input width-240" /><span class="icon-vali"></span>
                        </td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span>手机号：</th>
                        <td><input id="telPhone" name="phone" class="input width-240"/><span class="icon-vali"></span></td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span>验证码：</th>
                        <td>
                            <input id="verfiCode" name="verfiCode" class="input width-100" />
                            <a class="yzm" id="sendVerfiCode">获取验证码</a>
                        </td>
                    </tr>
                    <tr>
                        <th></th>
                        <td><a id="buttonSubmit" class="btn-changePwd" disabled="disabled">立即注册</a></td>
                    </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </div>
    <%@include file="../bottom.jsp" %>
    <%@include file="../footer.jsp" %>
</div>
</body>
</html>
<script>
    $(function(){
        $('#toHomeLogo').click(function () {
            window.location.href="/static/home.jsp";
        });

//        $('#topLogo1').click(function () {
//            window.location.href="/static/home.jsp";
//        });

        $("#forgetPwd").click(function(){
            window.location.href="/static/vips/forgitPass.jsp";
        });
        var a = getUrlParam('a') || 2;
        if(a!=1){
            $(".login").hide();
        }

//        $("#seatNum").text(getUrlParam('seatNum'));
        $("#inviteCode").val(getUrlParam('inviteNum'));

        canSubmit();

    });

    var nameFlag = false;
    var pwdFlag = false;
    var inviteCodeFlag = false;
    var telPhoneFlag = false;

    function canSubmit(){
        if (nameFlag && pwdFlag && inviteCodeFlag && telPhoneFlag) {
            $('#buttonSubmit').removeAttr('disabled');
            $('#buttonSubmit').attr('class', 'btn-changePwd');
        } else {
            $('#buttonSubmit').attr('disabled', 'disabled');
            $('#buttonSubmit').attr('class', 'btn-changePwd-disable');
        }
    }

    $("#nickName").blur(function(){
        var nickName = $('#nickName').val();
        nameFlag = false;
        var obj = $(this);
//        $('#nickNameTd').find('span').remove();
        if(nickName && nickName != null && nickName != ''){
            setTip(obj,"",1);
//            $("#nickName").after('<span class="link tip-right"><i class="icon icon-right"></i></span>');
            nameFlag = true;
            canSubmit();
        } else {
            setTip(obj,"请输入昵称",0);
//            $('#nickNameTd').find('span').remove();
//            $("#nickName").after('<span class="link tip-wrong"><i class="icon icon-wrong"></i>请输入昵称</span>');
        }
    });

    $("#inviteCode").blur(function(){
        var inviteCode = $('#inviteCode').val();
        inviteCodeFlag = false;
//        $('#inviteCodeTd').find('span').remove();
        var obj = $(this);
        if(inviteCode != null && inviteCode != ''){
            $.ajax({
                type: "POST",
                url: "interface/vips/validInviteCode.shtml",
                data: {inviteCode: inviteCode},
                dataType: "json",
                beforeSend: function (request) {
                    request.setRequestHeader("Authorization", getAuthorization());
                },
                success: function (data) {
                    if (data.level!=1) {
                        setTip(obj,data.messageText,0);
                        canClick=false;
                        $('#sendVerfiCode').css('color','#5e5e5e');
                        $('#sendVerfiCode').attr("href", 'javascript:;');
                    } else {
                        $('#sendVerfiCode').css('color','#f90606');
                        setTip(obj,"",1);
                        canClick=true;
                        telPhoneFlag=true;
                        inviteCodeFlag = true;
                        canSubmit();

                    }
                }
            });

//            $("#inviteCode").after('<span class="link tip-right"><i class="icon icon-right"></i></span>');
        } else {
            setTip(obj,"请输入邀请码",0);
//            $('#inviteCodeTd').find('span').remove();
//            $("#inviteCode").after('<span class="link tip-wrong"><i class="icon icon-wrong"></i>请输入邀请码</span>');
        }
    });

    $("#rePwd").on("input propertychange",function(){
        var rePwd = $('#rePwd').val();
        var objRePwd = $('#rePwd');

        if(rePwd && rePwd != null && rePwd != ''){
            var pwd = $('#pwd').val();
            if(pwd==rePwd) {
                setTip(objRePwd, "", 1);
                pwdFlag = true;
                canSubmit();
            }else{
                setTip(objRePwd,"密码不一致",0);
            }
        } else if(objRePwd == null || objRePwd == '') {
            setTip(objRePwd,"请输入确认密码",0);
        }
    });

    $("#pwd").on("input propertychange",function(){
        var pwd = $('#pwd').val();
        var objPwd = $('#pwd');

        if(pwd && pwd != null && pwd != ''){
            if(pwd.length>=6) {
                setTip(objPwd, "", 1);
            }else{
                setTip(objPwd,"密码最少6位",0);
            }
        } else if(pwd == null || pwd == '') {
            setTip(objPwd,"请输入新密码",0);
        }
    });

    $("#telPhone").bind("input propertychange",function(event){
        var telPhone= $("#telPhone").val();
        var obj = $("#telPhone");
        telPhoneFlag = false;
        if (telPhone && telPhone != null && telPhone != '' && telPhone.length == 11 && !isCountDown ) {
            if (!isPhoneNo(telPhone)) {
                layer.alert('手机号码格式错误', {
                    icon: 0,
                    skin: 'layui-layer-lan'
                });
                return;
            }
            $.ajax({
                type: "POST",
                url: "interface/vips/validPhone.shtml",
                data: {telPhone: telPhone},
                dataType: "json",
                beforeSend: function (request) {
                    request.setRequestHeader("Authorization", getAuthorization());
                },
                success: function (data) {
                    if (data.level!=1) {
                        setTip(obj,"手机号码已被使用",0);
                        canClick=false;
                        $('#sendVerfiCode').css('color','#5e5e5e');
                        $('#sendVerfiCode').attr("href", 'javascript:;');
                    } else {
                        setTip(obj,"",1);
                        $('#sendVerfiCode').css('color','#f90606');
                        canClick=true;
                        telPhoneFlag=true;
                        canSubmit();

                    }
                }
            });
        } else {
            setTip(obj,"请输入正确的手机号码",0);
            canClick=false;
            $('#sendVerfiCode').css('color','#5e5e5e');
            $('#sendVerfiCode').attr("href", 'javascript:;');
        }
    });

    function settime() {

        if (countdown == 0) {
            $('#sendVerfiCode').html('获取验证码');
            countdown = 60;
            canClick=true;
            isCountDown = false;
            return;
        } else {
            $('#sendVerfiCode').html("获取验证码(" + countdown + "s)");
            countdown--;
        }
        setTimeout(function() {
                    settime() }
                ,1000)
    }

    //倒计时
    var countdown=60;
    var canClick=false;
    var isCountDown = false;
    $('#sendVerfiCode').click(function(){
        if (canClick) {
            //获取手机号码
            var telPhone = $('#telPhone').val();
            isCountDown = true;
            canClick = false;
            $.ajax({
                type: "POST",
                url: "interface/meaage/sendValidCode.shtml",
                data: {telPhone:telPhone},
                dataType: "json",
                beforeSend: function(request) {
                    request.setRequestHeader("Authorization", getAuthorization());
                },
                success: function(data) {
                    if (data.level == 1) {

                    } else {
                        layer.alert(data.messageText, {
                            icon: 0,
                            skin: 'layui-layer-lan'
                        });
                    }
                },
                error: function(data) {
                    layer.alert('系统错误，请联系管理员！', {
                        icon: 2,
                        skin: 'layui-layer-lan'
                    });
                }
            });

            $('#sendVerfiCode').css('color','#5e5e5e');
            $('#sendVerfiCode').attr("href", 'javascript:;');
            settime();
        }
    });

    // 验证手机号
    function isPhoneNo(phone) {
        var pattern = /^1[34578]\d{9}$/;
        return pattern.test(phone);
    }

    $("#buttonSubmit").click(function(){
        var obj = $(this);
        var verfiCode = $('#verfiCode').val();
        if (!verfiCode || verfiCode.length != 6) {
            setTip(obj,"请输入6位验证码",0);
//            $('#inviteCodeTd').find('span').remove();
//
//            $("#sendVerfiCode").after('<span class="link tip-wrong"><i class="icon icon-wrong"></i>请输入6位验证码</span>');
            return;
        }
        var inviteCode = $('#inviteCode').val();
        if(inviteCode && inviteCode != null && inviteCode != ''){
            setTip(obj,"",1);
//            $("#inviteCode").after('<span class="link tip-right"><i class="icon icon-right"></i></span>');
            inviteCodeFlag = true;
        }

        canSubmit();
        var btn = $('#buttonSubmit').attr("class");
        if(btn=='disable'){
            return;
        }
        var data =$('#registerForm').serializeArray();
        $.ajax({
            type: "POST",
            url: "interface/vips/register.shtml",
            data: data,
            dataType: "json",
            beforeSend: function(request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function(data) {
                if (data.level == 1) {

                    $('#registerForm')[0].reset();
                    sessionStorage.setItem("sessionId", data.data);

                    $.ajax({
                        type: "POST",
                        url: "interface/gainsInfo/getNickName.shtml",
                        data: {},
                        dataType: "json",
                        beforeSend: function (request) {
                            request.setRequestHeader("Authorization", getAuthorization());
                        },
                        success: function (result) {
                            sessionStorage.setItem("nickName", result.data);
                            window.location.href="/static/vips/vips_pay.jsp";
                        },
                        error: function(data1) {
                            putTokenToDef();
                            layer.alert('系统错误，请联系管理员！', {
                                icon: 2,
                                skin: 'layui-layer-lan'
                            });
                        }
                    });
                } else {
                    layer.alert(data.messageText, {
                        icon: 0,
                        skin: 'layui-layer-lan'
                    });
                }
            },
            error: function(data) {
                layer.alert('系统错误，请联系管理员！', {
                    icon: 2,
                    skin: 'layui-layer-lan'
                });
            }
        });
    });

    $("#loginBtn").click(function(){
        var telPhone = $('#loginForm .telPhone').val();
        var pwd = $('#loginForm .pwd').val();
        if (telPhone=='' || pwd=='') {
            return;
        }
        var data =$('#loginForm').serializeArray();
        $.ajax({
            type: "POST",
            url: "interface/vips/login.shtml",
            data: data,
            dataType: "json",
            beforeSend: function(request) {
                request.setRequestHeader("Authorization", getAuthorization());

            },
            success: function(data) {
                if (data.level == 1) {
                    sessionStorage.setItem("sessionId", data.data);


                    $.ajax({
                        type: "POST",
                        url: "interface/gainsInfo/getNickName.shtml",
                        data: {},
                        dataType: "json",
                        beforeSend: function (request) {
                            request.setRequestHeader("Authorization", getAuthorization());

                        },
                        success: function (result) {
                            sessionStorage.setItem("nickName", result.data);
                            window.location.href="/static/home.jsp";
                        },
                        error: function(data1) {
                            putTokenToDef();
                            layer.alert('系统错误，请联系管理员！', {
                                icon: 2,
                                skin: 'layui-layer-lan'
                            });
                        }
                    });

                } else {
                    layer.alert(data.messageText, {
                        icon: 0,
                        skin: 'layui-layer-lan'
                    });
                }
            },
            error: function(data) {
                putTokenToDef();
                layer.alert('系统错误，请联系管理员！', {
                    icon: 2,
                    skin: 'layui-layer-lan'
                });
            }
        });
    });

    $(".register .loginBtn").click(function(){
        $(".login").show();
    });

    $(".login .loginClose").click(function(){
        $(".login").hide();
    });

    //获取url中的参数
    function getUrlParam(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.search.substr(1).match(reg);  //匹配目标参数
        if (r != null) return unescape(r[2]); return null; //返回参数值
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
            $(obj).siblings(".icon-vali").append("<i class='fas fa-times-circle fail' title='"+msg+"'></i>   "+msg);
        }
    }
</script>