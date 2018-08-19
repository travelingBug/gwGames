<%@ page pageEncoding="utf-8"%>
<%--shiro 标签 --%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path = request.getContextPath(); String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; %> 
<base href="<%=basePath%>">
<script baseUrl="<%=basePath%>" src="<%=basePath%>/js/common/jquery/jquery-3.3.1.js"></script>
<div class="navbar navbar-inverse navbar-fixed-top animated fadeInDown" style="z-index: 101;height: 41px;">

<label>姓名：</label> <input type="text" value="123" id="test1" />
</div>
<script>
    $.ajax({
        type: "POST",
        url: "/interface/test.shtml",
        data: {user:"333"},
        dataType: "json",
        beforeSend: function(request) {
            request.setRequestHeader("Authorization", "1");
        },
        success: function(data) {
            debugger
        },
        error: function(data) {

        }
    });
</script>
