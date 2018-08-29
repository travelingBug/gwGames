<%@ page pageEncoding="utf-8"%>
<%--shiro 标签 --%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path = request.getContextPath(); String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; %> 
<base href="<%=basePath%>">
<script baseUrl="<%=basePath%>" src="<%=basePath%>/js/common/jquery/jquery-3.3.1.js"></script>
<script  src="<%=basePath%>/js/common/layer/layer.js"></script>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>股王大赛</title>
    <link href="<%=basePath%>/css/all.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="bg1">
    <div class="pageWrapper1">
        <div class="main-page">
            <div class="top-nav">
                <ul class="floatL">
                    <li><a>大赛介绍</a></li>
                    <li><a>大赛规则</a></li>
                </ul>
                <ul class="floatR">
                    <li><a>奖金设置</a></li>
                    <li><a>赛事报道</a></li>
                </ul>
            </div>
            <form method="post" action="" id="addForm" class="form-inline">
                <div class="form bm-form">
                    <div class="input-style">
                        <p>昵称</p><em>|</em><input  maxlength="20" name="accountName" id="accountNameId" class="width-4" type="text" />
                        <span class="link tip-wrong" id="accountErrorId" style="display: none">昵称已被使用</span>
                        <!--<span class="link tip-right">昵称可用</span>-->
                    </div>
                    <div class="input-style"><p>真实姓名</p><em>|</em><input maxlength="20" name="name" id="nameId" type="text" /></div>
                    <div class="input-style"><p>身份证</p><em>|</em><input maxlength="20" name="idCard" id="idCardId" type="text" /></div>
                    <div class="input-style"><p>手机号</p><em>|</em><input maxlength="11" name="telPhone" id="telPhoneId" class="width-4" type="text" /><a class="link">发送验证码</a></div>
                    <div class="input-style"><p>验证码</p><em>|</em><input maxlength="4" name="verfiCode" id="verfiCodeId" type="text" /></div>

                    <div class="one-line">
                        <p class="tip">注意：昵称确认后将无法修改！</p>
                    </div>
                    <div class="one-line">
                        <div class="read-text"><input type="radio"/><p>已阅读并同意<a>参赛须知</a></p></div>
                        <a class="btn-bm1" id="buttonSubmit">提交</a>
                    </div>
                </div>
            </form>
        </div>
        <div class="footer">
            <p>Copyright © 和讯网北京和讯在线信息咨询服务有限公司 </p>
        </div>
    </div>
</div>
</body>
</html>
<script>

    $("#accountNameId").blur(function(){
        var accountName = $('#accountNameId').val();
        if (accountName && accountName != null && accountName != '') {
            $.ajax({
                type: "POST",
                url: "interface/player/findAllNoPage.shtml",
                data: {accountName:accountName},
                dataType: "json",
                beforeSend: function (request) {
                    request.setRequestHeader("Authorization", "1");
                },
                success: function (data) {
                    if (data != null && data.length < 1) {
                        $('#accountErrorId').css('display','none');
                    } else {
                        $('#accountErrorId').css('display','');
                    }
                }
            });
        }
    });
    $("#buttonSubmit").click(function(){
        var data =$('#addForm').serializeArray();
        $.ajax({
            type: "POST",
            url: "interface/player/save.shtml",
            data: data,
            dataType: "json",
            beforeSend: function(request) {
                request.setRequestHeader("Authorization", "1");
            },
            success: function(data) {
                debugger
                if (data.level == 1) {
                    layer.alert(data.messageText, {
                        icon: 1,
                        skin: 'layui-layer-lan'
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

</script>
