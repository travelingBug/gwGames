<%@ page pageEncoding="utf-8"%>
<%--shiro 标签 --%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path = request.getContextPath(); String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; %> 
<base href="<%=basePath%>">
<script baseUrl="<%=basePath%>" src="<%=basePath%>/js/common/jquery/jquery-3.3.1.js"></script>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>股王大赛</title>
    <link href="<%=basePath%>/css/all.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="bg">
    <div class="pageWrapper">
        <div class="main-page">
            <div class="top-nav">
                <ul class="floatL">
                    <li><a>大赛介绍</a></li>
                    <li><a>大赛规则</a></li>
                </ul>
                <ul class="floatR">
                    <li><a>奖金设置</a></li>
                    <%--<li><a>赛事报道</a></li>--%>
                </ul>
            </div>
            <div class="btn-bm">
                <a class="btn-bm-1"></a>
                <%--<a class="btn-bm-2"></a>--%>
                <%--<a class="btn-bm-3"></a>--%>
            </div>
        </div>
        <div class="footer">
            <div class="content">
            </div>
            <p>Copyright © 和讯网北京和讯在线信息咨询服务有限公司 </p>
        </div>
    </div>
</div>
</body>
</html>

<script>
    $("#buttonSubmit").click(function(){
        var data =$('#addForm').serializeArray();
        debugger
        $.ajax({
            type: "POST",
            url: "interface/player/save.shtml",
            data: data,
            dataType: "json",
            beforeSend: function(request) {
                request.setRequestHeader("Authorization", "1");
            },
            success: function(data) {
            },
            error: function(data) {

            }
        });
    });

</script>
