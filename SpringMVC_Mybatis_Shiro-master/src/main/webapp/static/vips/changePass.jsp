<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="../head.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>股王大赛</title>
    <link href="${basePath}/css/gwGame.css?${_v}" rel="stylesheet"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
</head>
<body>
<div class="pageWrapper2 register">
    <%@include file="../top.jsp" %>
    <div class="main">
        <div class="content">
            <div class="title">
                <h3>修改密码</h3>
            </div>
            <form action="#" method="post" id="changePassForm">
                <table class="table2">
                    <tbody>
                    <tr>
                        <th><span style="color: red;">*</span>旧密码：</th>
                        <td id="oldPassTd"><input id="oldPwd" name="password" type="password" class="input width-240 oldPwd" /><span class="icon-vali"></span></td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span>新密码：</th>
                        <td id="newPassTd"><input id="newPwd" name="password" type="password" class="input width-240 pwd" /><span class="icon-vali"></span></td>
                    </tr>
                    <tr>
                        <th><span style="color: red;">*</span>确认密码：</th>
                        <td id="newRePwdTd"><input id="newRePwd" type="password" class="input width-240 pwd" /><span class="icon-vali"></span></td>
                    </tr>
                    <tr>
                        <th></th>
                        <td><a id="changePassSubmit" class="btn-changePwd-disable" disabled="disabled">提交</a></td>
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

    var valiPwd = false
    var pwdFlag = false;

    function canSubmit(){
        if (valiPwd && pwdFlag) {
            $('#changePassSubmit').removeAttr('disabled');
            $('#changePassSubmit').attr('class','btn-changePwd');
        } else {
            $('#changePassSubmit').attr('disabled','disabled');
            $('#changePassSubmit').attr('class','btn-changePwd-disable');
        }
    }

//    $(".pwd").change(function(){
//        var pwd = $('#newPwd').val();
//        var rePwd = $('#newRePwd').val();
//        var objPwd = $('#newPwd');
//        var objRePwd = $('#newRePwd');
//        pwdFlag = false;
//        if(pwd && pwd != null && pwd != '' && rePwd && rePwd != null && rePwd != ''){
//
//            if(pwd==rePwd){
//                setTip(objRePwd,"",1);
//                pwdFlag = true;
//                canSubmit();
//            }else{
//                setTip(objRePwd,"密码不一致",0);
//            }
//        } else if(pwd == null || pwd == '') {
//            setTip(objPwd,"请输入新密码",0);
//        } else if(rePwd == null || rePwd == ''){
//            setTip(objPwd,"",1);
//            setTip(objRePwd,"请输入确认密码",0);
//        }
//    });

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

    $("#oldPwd").blur(function(){
        var oldPwd = $("#oldPwd").val();
        var obj = $(this);
        $.ajax({
            type: "POST",
            url: "interface/vips/valiPass.shtml",
            data: {pwd:oldPwd},
            dataType: "json",
            beforeSend: function(request) {
                request.setRequestHeader("Authorization", getAuthorization());

            },
            success: function(data) {
                if(data.level==1){
                    valiPwd = true;
                    setTip(obj,"",1);
                }else{
                    setTip(obj,data.messageText,0);
                }
            },
            error: function(data) {

            }
        });
    });

    $("#changePassSubmit").click(function(){
        var pwd = $('#newPwd').val();
        $.ajax({
            type: "POST",
            url: "interface/vips/editVips.shtml",
            data: {password:pwd},
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

</script>