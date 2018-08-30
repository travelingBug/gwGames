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
                <%--<ul class="floatL">--%>
                    <%--<li><a>大赛介绍</a></li>--%>
                    <%--<li><a>大赛规则</a></li>--%>
                <%--</ul>--%>
                <%--<ul class="floatR">--%>
                    <%--<li><a>奖金设置</a></li>--%>
                    <%--<li><a>赛事报道</a></li>--%>
                <%--</ul>--%>
            </div>


                <div class="form bm-form">
                    <form method="post" action="" id="addForm" class="form-inline">
                    <div class="input-style" id="accountNameDiv">
                        <p>昵称</p><em>|</em><input maxlength="20" name="accountName" id="accountNameId" class="width-4" type="text" />
                        <%--<span class="link tip-wrong"><i class="icon icon-wrong"></i>昵称已被使用</span>--%>
                        <!--<span class="link tip-right"><i class="icon icon-right"></i></span>-->
                    </div>
                    <div class="input-style" id="nameDiv"><p>真实姓名</p><em>|</em><input  maxlength="20" name="name" id="nameId" class="width-4" type="text" /></div>
                        <div class="input-style" id="idCardDiv"><p>身份证</p><em>|</em><input  maxlength="20" name="idCard" id="idCardId" class="width-4" type="text" /></div>
                    <div class="input-style">
                        <p>手机号</p><em>|</em><input maxlength="11" name="telPhone" id="telPhoneId"  class="width-4" type="text" />
                        <a id="sendVerfiCode" class="link" href="javascript:;" style="color: #5e5e5e;">发送验证码</a>
                    </div>
                    </form>
                    <div class="input-style" id="verfiCodeDiv"><p>验证码</p><em>|</em><input maxlength="6" name="verfiCode" id="verfiCodeId"  class="width-4" type="text" /><span class="numb"></span></div>

                        <div class="one-line">
                            <p class="tip">注意：昵称确认后将无法修改！</p>
                        </div>
                        <div class="one-line">
                            <div class="read-text"><input type="radio" value="1" id="readText"/><p>已阅读并同意<a>参赛须知</a></p></div>
                            <button type="button" class="btn-bm1" id="buttonSubmit" disabled="disabled">提交</button>
                        </div>
                </div>

        </div>
        <div class="footer">
            <p>Copyright © 和富甲文化股份有限公司 </p>
        </div>
    </div>
</div>
</body>
</html>
<script>

    var accountFlag = false;
    var nameFlag = false;
    var idCardFlag = false;
    var telPhoneFlag = false;
    var readTextFlag = false;

    $("#readText").click(function(){
        readTextFlag = true;
        canSubmit();
    });

    function canSubmit(){
        if (accountFlag && nameFlag && idCardFlag && telPhoneFlag && readTextFlag) {
            $('#buttonSubmit').removeAttr('disabled');
        } else {
            $('#buttonSubmit').attr('disabled','disabled');
        }
    }

    $("#idCardId").blur(function(event){
        var idCard= $("#idCardId").val();
        idCardFlag = false;
        $('#idCardDiv').find('span').remove();
        if(isCardNo(idCard)){
            $.ajax({
                type: "POST",
                url: "interface/player/findAllNoPage.shtml",
                data: {idCard:idCard},
                dataType: "json",
                beforeSend: function (request) {
                    request.setRequestHeader("Authorization", "1");
                },
                success: function (data) {
                    if (data != null && data.length > 0) {
                        $("#idCardId").after('<span class="link tip-wrong"><i class="icon icon-wrong"></i>身份证已被使用</span>');

                    } else {
                        $("#idCardId").after('<span class="link tip-right"><i class="icon icon-right"></i></span>');
                        idCardFlag = true;
                        canSubmit();
                    }
                }
            });
        } else {
            $("#idCardId").after('<span class="link tip-wrong"><i class="icon icon-wrong"></i>身份证格式错误</span>');
        }

    });



    $("#telPhoneId").bind("input propertychange",function(event){
        var telPhone= $("#telPhoneId").val();
        telPhoneFlag = false;
        if (telPhone && telPhone != null && telPhone != '' && telPhone.length == 11) {
            if (!isPhoneNo(telPhone)) {
                layer.alert('电话号码格式错误', {
                    icon: 0,
                    skin: 'layui-layer-lan'
                });
                return;
            }
                $.ajax({
                    type: "POST",
                    url: "interface/player/findAllNoPage.shtml",
                    data: {telPhone: telPhone},
                    dataType: "json",
                    beforeSend: function (request) {
                        request.setRequestHeader("Authorization", "1");
                    },
                    success: function (data) {
                        if (data != null && data.length > 0) {
                            layer.alert('电话号码已被使用', {
                                icon: 0,
                                skin: 'layui-layer-lan'
                            });
                            canClick=false;
                            $('#sendVerfiCode').css('color','#5e5e5e');
                            $('#sendVerfiCode').setAttribute("href", 'javascript:;');
                        } else {
                            $('#sendVerfiCode').css('color','blue');
                            canClick=true;
                            telPhoneFlag=true;
                            canSubmit();
                        }
                    }
                });
            }
    });

    // 验证手机号
    function isPhoneNo(phone) {
        var pattern = /^1[34578]\d{9}$/;
        return pattern.test(phone);
    }



    $("#nameId").blur(function(){
        var name = $('#nameId').val();
        nameFlag = false;
        $('#nameDiv').find('span').remove();

        if (!name || name.length > 20) {
            $("#nameId").after('<span class="link tip-wrong"><i class="icon icon-wrong"></i>姓名格式错误</span>');
        } else {
            $("#nameId").after('<span class="link tip-right"><i class="icon icon-right"></i></span>');
            nameFlag = true;
            canSubmit();
        }

    });


    $("#accountNameId").blur(function(){
        var accountName = $('#accountNameId').val();
        accountFlag = false;
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
                    $('#accountNameDiv').find('span').remove();
                    if (data != null && data.length > 0) {
                        $("#accountNameId").after('<span class="link tip-wrong"><i class="icon icon-wrong"></i>昵称已被使用</span>');

                    } else {
                        $("#accountNameId").after('<span class="link tip-right"><i class="icon icon-right"></i></span>');
                        accountFlag = true;
                        canSubmit();
                    }
                }
            });
        } else {
            $('#accountNameDiv').find('span').remove();
            $("#accountNameId").after('<span class="link tip-wrong"><i class="icon icon-wrong"></i>请输入昵称</span>');
        }

    });


    $("#buttonSubmit").click(function(){
        var verfiCode = $('#verfiCodeId').val();
        if (!verfiCode || verfiCode.length != 6) {
            $("#verfiCodeId").after('<span class="link tip-wrong"><i class="icon icon-wrong"></i>请输入6位验证码</span>');
            return;
        }
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


    // 验证身份证
    function isCardNo(card) {
        var pattern = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
        return pattern.test(card);
    }

    //倒计时
    var countdown=60;
    var canClick=false;
    $('#sendVerfiCode').click(function(){
        if (canClick) {
            canClick = false;
            $('#sendVerfiCode').css('color','#5e5e5e');
            $('#sendVerfiCode').attr("href", 'javascript:;');
            settime();
        }
    });

    function settime() {


        if (countdown == 0) {
            $('#sendVerfiCode').html('发送验证码');
            $('#sendVerfiCode').css('color','blue');
            countdown = 60;
            canClick=true;
            return;
        } else {
            $('#sendVerfiCode').html("发送验证码(" + countdown + "s)");
            countdown--;
        }
        setTimeout(function() {
                settime() }
            ,1000)
    }
</script>
