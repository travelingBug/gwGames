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
        <div class="cont-box">
            <div class="content bg-white">
                <h3 class="title">赛事报道</h3>
                <div class="list4" id="eventReport">
                </div>
            </div>
        </div>
    <%@include file="../bottom.jsp" %>
    <%@include file="../footer.jsp" %>
</div>
</body>
<script>
    $(function() {
        goPageByAjax(1);
    });
    function goPageByAjax(pageNo) {
        $('#eventReport').html("");
        //获取交易明细
        $.ajax({
            type: "POST",
            url: "interface/eventreport/list.shtml",
            data: {pageNo:pageNo},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (data) {
                if (data != null && data.list != null && data.list.length > 0) {
                    var reportData = data.list;
                    for (var i = 0 ; i < reportData.length;i++ ) {

                        var html = '<div class="item">';
                        html += '<img src="'+reportData[i].cover+'"/>';
                        html += '<div class="text">';
                        html += '<h3><a href="/static/eventReport/eventReportDetail.jsp?id='+reportData[i].id+'">'+reportData[i].title+'</a></h3>';
                        html += '<p>'+reportData[i].described+'<a href="/static/eventReport/eventReportDetail.jsp?id='+reportData[i].id+'">查看更多</a></p>';
                        html += '</div></div>';
                        $('#eventReport').append(html);
                    }

                    $('#eventReport').append(getPager(data));

                }
            }
        });
    }

    function getPager(result){
        var totalPage = Math.ceil((result.totalCount/result.pageSize));
        var pager = "<div class='pager  mr-20 mb-20' ><ul class='floatR'>";
        pager +="<li><a  class='text' href='javascript:;' onclick='goPageByAjax(1)'>首页</a></li>";
        if (result.pageNo > 1) {
            pager += "<li><a  class='icon' href='javascript:;'  onclick='goPageByAjax(" + (result.pageNo - 1) + ")'>&lt;</a></li>";
        }
        for (var i = (result.pageNo-2<=0?1:result.pageNo-2),no = 1; i <= result.totalPage && no < 6 ; i++,no++) {
            if (result.pageNo == i) {
                pager += "<li><span class='numb on'>"+i+"</span></li>";
            }else{
                pager += "<li><a class='numb' href='javascript:;' onclick='goPageByAjax("+i+")'>"+i+"</a></li>";
            }
        }
        if (result.pageNo < totalPage) {
            pager +="<li><a class='icon' href='javascript:;'  onclick='goPageByAjax(" + (result.pageNo + 1) + ")'>&gt;</a></li>";
        }
        pager +="<li><a class='icon' href='javascript:;'  onclick='goPageByAjax("+(totalPage)+")'>尾页</a></li>";
        pager +="</ul><span class='page-numb'>第"+result.pageNo+"页 / 共"+totalPage+"页</span></div>";

        return pager;
    }
</script>
</html>