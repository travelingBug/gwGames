<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>天下股神实盘大赛</title>
    <%@include file="../head.jsp" %>
</head>
<body>
<div class="pageWrapper2">
    <%@include file="../top.jsp" %>
    <%@include file="../banner.jsp" %>
        <div class="cont-box detail">
            <div class="content bg-white">
                <h3 class="title" id="title"></h3>
                <div class="infor">
                    <p class="floatL" id="crtTime"></p>
                    <p class="floatR"></p>
                </div>
                <div class="detail-cont" id="content">
                </div>
            </div>
            <%@include file="../bottom.jsp" %>
            <%@include file="../footer.jsp" %>
        </div>

</div>
</body>
<script>
    $(function() {
        var id = '${param.id}';
        $.ajax({
            type: "POST",
            url: "interface/eventreport/findById.shtml",
            data: {id:id},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (data) {
                $('#title').html(data.title);
                $('#crtTime').html(data.crtTimeStr);
                $('#content').html(data.content);
            }
        });
    });

</script>
</html>