<%@ page pageEncoding="utf-8"%>
<%--shiro 标签 --%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path = request.getContextPath(); String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; %> 
<base href="<%=basePath%>">
<script baseUrl="<%=basePath%>" src="<%=basePath%>/js/common/jquery/jquery-3.3.1.js"></script>
<div class="navbar navbar-inverse navbar-fixed-top animated fadeInDown" enctype="application/x-www-form-urlencoded" style="z-index: 101;height: 41px;">
    <form method="post" action="" id="addForm" class="form-inline">
        <table width="100%" border="0" cellpadding="2">
            <COLGROUP>
                <COL width='10%' align="right">
                <COL width='23%' align="left">
                <COL width='10%' align="right">
                <COL width='23%' align="left">
                <COL width='10%' align="right">
                <COL width='23%' align="left">
            </COLGROUP>

            <tr height="23">
                <td nowrap="nowrap">
                    账户名
                </td>
                <td>
                    <input type="text" class="form-control" name="accountName" />
                </td>
                <td nowrap="nowrap">
                    姓名
                </td>
                <td>
                    <input type="text" class="form-control" name="name" />
                </td>
                <td nowrap="nowrap">
                    身份证
                </td>
                <td>
                    <input type="text" class="form-control" name="idCard" />
                </td>
            </tr>
            <tr height="23">
                <td nowrap="nowrap">
                    电话号码
                </td>
                <td>
                    <input type="text" class="form-control" name="telPhone" />
                </td>
                <td>
                    <input type="button" id="buttonSubmit" value="提交" />
                </td>
            </tr>
        </table>
    </form>
</div>
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
