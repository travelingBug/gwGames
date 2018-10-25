<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="../head.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>天下股神实盘大赛</title>
    <link href="${basePath}/css/gwGame.css?${_v}" rel="stylesheet"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
</head>
<body>
<div class="pageWrapper2 register">
    <%@include file="../top.jsp" %>
    <div class="main">
        <div class="content">
            <div class="title">
                <h3>重置密码</h3>
            </div>
            <form action="#" method="post" id="changePassForm">
                <table class="table2">
                    <tbody>
                    <tr>
                        <th><span style="color: red;">*</span>新密码：</th>
                        <td id="newPassTd"><input id="newPwd" name="password" type="password" class="input width-240 pwd" /><span class="icon-vali"></span></td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span>确认密码：</th>
                        <td id="newRePwdTd"><input id="newRePwd" type="password" class="input width-240 pwd" /><span class="icon-vali"></span></td>
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
                        <td><a id="forgetPassSubmit" class="btn-changePwd-disable" disabled="disabled">重置密码</a></td>
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

    });

    var valiPhone = false
    var pwdFlag = false;

    function canSubmit(){
        if (valiPhone && pwdFlag) {
            $('#forgetPassSubmit').removeAttr('disabled');
            $('#forgetPassSubmit').attr('class','btn-changePwd');
        } else {
            $('#forgetPassSubmit').attr('disabled','disabled');
            $('#forgetPassSubmit').attr('class','btn-changePwd-disable');
        }
    }

    $("#newRePwd").on("input propertychange",function(){
        var rePwd = $('#newRePwd').val();
        var objRePwd = $('#newRePwd');

        if(rePwd && rePwd != null && rePwd != ''){
            var pwd = $('#newPwd').val();
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

    $("#newPwd").on("input propertychange",function(){
        var pwd = $('#newPwd').val();
        var objPwd = $('#newPwd');

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

    $("#telPhone").blur(function(){
        var phone = $("#telPhone").val();
        var obj = $(this);
        $.ajax({
            type: "POST",
            url: "interface/vips/validPhone.shtml",
            data: {telPhone:phone},
            dataType: "json",
            beforeSend: function(request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function(data) {
                if(data.level!=1 && data.messageText=="电话号码已经存在！"){
                    valiPhone = true;
                    canClick=true;
                    setTip(obj,"",1);
                    canSubmit();
                }else{
                    setTip(obj,"手机号码未注册",0);
                }
            },
            error: function(data) {

            }
        });
    });

    $("#forgetPassSubmit").click(function(){
        var pwd = $('#newPwd').val();
        var phone = $("#telPhone").val();
        var verfiCode = $("#verfiCode").val();
        $.ajax({
            type: "POST",
            url: "interface/vips/resetPwd.shtml",
            data: {password:pwd,phone:phone,verfiCode:verfiCode},
            dataType: "json",
            beforeSend: function(request) {
                request.setRequestHeader("Authorization", getAuthorization());

            },
            success: function(data) {
                if(data.level==1){
                    window.location.href="/static/home.jsp";
                }else{
                    layer.alert(data.messageText, {
                        icon: 0,
                        skin: 'layui-layer-lan'
                    });
                }
            },
            error: function(data) {

            }
        });
    });

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

</script>