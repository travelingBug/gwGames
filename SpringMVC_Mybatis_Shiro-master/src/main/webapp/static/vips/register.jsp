<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="../head.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>股王大赛</title>
    <link href="css/all.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="overlay layer-small login">
    <div class="overlay-bg"></div>
    <div class="float-div">
        <a class="icon icon-close loginClose"></a>
        <h3 class="title">登录</h3>
        <div class="content">
            <form action="#" method="post" id="loginForm">
                <div class="one"><div class="input-area" id="loginPhoneDiv"><i class="icon-un"></i><input class="width-250 telPhone" name="phone"/></div></div>
                <div class="one"><div class="input-area"><i class="icon-pw"></i><input class="width-250 pwd" name="password" type="password"/></div></div>
                <div class="one"><div class="left-area"><!--<input type="radio" class="radio">自动登录</div><a class="right-area">找回密码？</a>--></div></div>
                <div class="one"><a class="login-btn" id="loginBtn">登录</a></div>
                <div class="one"><p>还没有账号？<a class="link" href="/static/vips/register.jsp?a=2">立即注册</a></p></div>
            </form>
        </div>
    </div>
</div>
<div class="pageWrapper2 register">
    <div class="top-bar"></div>
    <div class="top-box">
        <div class="content">
            <div class="logo" id="toHomeLogo"></div>
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
                        <td id="nickNameTd"><input id="nickName" name="nickName" class="input width-240" /></td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span>密码：</th>
                        <td id="pwdTd"><input id="pwd" name="password" type="password" class="input width-240 pwd" /></td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span>确认密码：</th>
                        <td id="rePwdTd"><input id="rePwd" type="password" class="input width-240 pwd" /></td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span>推荐码：</th>
                        <td id="inviteCodeTd">
                            <input id="inviteCode" name="inviteCode" class="input width-240" />
                        </td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span>手机号：</th>
                        <td><input id="telPhone" name="phone" class="input width-240"/></td>
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
                        <td><a id="buttonSubmit" class="disable" disabled="disabled">立即注册</a></td>
                    </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </div>
    <%@include file="../footer.jsp" %>
</div>
</body>
</html>
<script>
    $(function(){
        $('#toHomeLogo').click(function () {
            window.location.href="/static/home.jsp";
        });
        var a = getUrlParam('a') || 2;
        if(a!=1){
            $(".login").hide();
        }

//        $("#seatNum").text(getUrlParam('seatNum'));
        $("#inviteCode").val(getUrlParam('inviteNum'));

    });

    var nameFlag = false;
    var pwdFlag = false;
    var inviteCodeFlag = false;
    var telPhoneFlag = false;

    function canSubmit(){
        if (nameFlag && pwdFlag && inviteCodeFlag && telPhoneFlag) {
            $('#buttonSubmit').removeAttr('disabled');
            $('#buttonSubmit').attr('class','btn-register');
        } else {
            $('#buttonSubmit').attr('disabled','disabled');
            $('#buttonSubmit').attr('class','disable');
        }
    }

    $("#nickName").blur(function(){
        var nickName = $('#nickName').val();
        nameFlag = false;
        $('#nickNameTd').find('span').remove();
        if(nickName && nickName != null && nickName != ''){
            $("#nickName").after('<span class="link tip-right"><i class="icon icon-right"></i></span>');
            nameFlag = true;
            canSubmit();
        } else {
            $('#nickNameTd').find('span').remove();
            $("#nickName").after('<span class="link tip-wrong"><i class="icon icon-wrong"></i>请输入昵称</span>');
        }
    });

    $("#inviteCode").blur(function(){
        var inviteCode = $('#inviteCode').val();
        inviteCodeFlag = false;
        $('#inviteCodeTd').find('span').remove();
        if(inviteCode && inviteCode != null && inviteCode != ''){
//            $.ajax({
//                type: "POST",
//                url: "interface/vips/validInviteCode.shtml",
//                data: {telPhone: telPhone},
//                dataType: "json",
//                beforeSend: function (request) {
//                    request.setRequestHeader("Authorization", getAuthorization());
//                },
//                success: function (data) {
//                    if (data != null && data.length > 0) {
//                        layer.alert('电话号码已被使用', {
//                            icon: 0,
//                            skin: 'layui-layer-lan'
//                        });
//                        canClick=false;
//                        $('#sendVerfiCode').css('color','#5e5e5e');
//                        $('#sendVerfiCode').attr("href", 'javascript:;');
//                    } else {
//                        $('#sendVerfiCode').css('color','#f90606');
//                        canClick=true;
//                        telPhoneFlag=true;
//                        canSubmit();
//
//                    }
//                }
//            });
            $("#inviteCode").after('<span class="link tip-right"><i class="icon icon-right"></i></span>');
            inviteCodeFlag = true;
            canSubmit();
        } else {
            $('#inviteCodeTd').find('span').remove();
            $("#inviteCode").after('<span class="link tip-wrong"><i class="icon icon-wrong"></i>请输入邀请码</span>');
        }
    });

    $(".pwd").blur(function(){
        var pwd = $('#pwd').val();
        var rePwd = $('#rePwd').val();
        pwdFlag = false;
        $('#pwdTd').find('span').remove();
        $('#rePwdTd').find('span').remove();
        if(pwd && pwd != null && pwd != '' && rePwd && rePwd != null && rePwd != ''){
            if(pwd==rePwd){
                $("#pwd").after('<span class="link tip-right"><i class="icon icon-right"></i></span>');
                $("#rePwd").after('<span class="link tip-right"><i class="icon icon-right"></i></span>');
                pwdFlag = true;
                canSubmit();
            }else{
                $('#rePwdTd').find('span').remove();
                $("#rePwd").after('<span class="link tip-wrong"><i class="icon icon-wrong"></i>密码不一致</span>');
            }
        } else if(pwd == null || pwd == '') {
            $('#pwdTd').find('span').remove();
            $("#pwd").after('<span class="link tip-wrong"><i class="icon icon-wrong"></i>请输入密码</span>');
        } else if(rePwd == null || rePwd == ''){
            $('#rePwdTd').find('span').remove();
            $("#rePwd").after('<span class="link tip-wrong"><i class="icon icon-wrong"></i>请输入确认密码</span>');
        }
    });

    $("#telPhone").bind("input propertychange",function(event){
        var telPhone= $("#telPhone").val();
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
                    if (data != null && data.length > 0) {
                        layer.alert('电话号码已被使用', {
                            icon: 0,
                            skin: 'layui-layer-lan'
                        });
                        canClick=false;
                        $('#sendVerfiCode').css('color','#5e5e5e');
                        $('#sendVerfiCode').attr("href", 'javascript:;');
                    } else {
                        $('#sendVerfiCode').css('color','#f90606');
                        canClick=true;
                        telPhoneFlag=true;
                        canSubmit();

                    }
                }
            });
        } else {
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
        var verfiCode = $('#verfiCode').val();
        if (!verfiCode || verfiCode.length != 6) {
            $('#inviteCodeTd').find('span').remove();

            $("#sendVerfiCode").after('<span class="link tip-wrong"><i class="icon icon-wrong"></i>请输入6位验证码</span>');
            return;
        }
        var inviteCode = $('#inviteCode').val();
        if(inviteCode && inviteCode != null && inviteCode != ''){
            $("#inviteCode").after('<span class="link tip-right"><i class="icon icon-right"></i></span>');
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
                debugger;
                if (data.level == 1) {
                    $('#registerForm')[0].reset();
                    sessionStorage.setItem("sessionId", data.data);
                    window.location.href="/static/home.jsp";
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

</script>