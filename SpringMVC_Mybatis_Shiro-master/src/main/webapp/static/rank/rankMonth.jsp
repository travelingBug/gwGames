<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>天下股神实盘大赛</title>

    <%@include file="../head.jsp" %>
</head>
<body>
<%@include file="../float.jsp" %>
<div class="pageWrapper2">
    <%@include file="../top.jsp" %>
    <%@include file="../banner_chlid.jsp" %>
    <div class="main-box">
        <div class="content">
            <div class="tab1">
                <a class="on">月度冠军</a>
            </div>
            <div class="tab1" id="monthCount">
            </div>
            <%--<div class="table-area1">--%>
                <%--<table class="table1">--%>
                    <%--<tbody>--%>
                    <%--<tr>--%>
                        <%--<th>月份</th>--%>
                        <%--<th>排名</th>--%>
                        <%--<th>选手</th>--%>
                        <%--<th>本金</th>--%>
                        <%--<th>收益</th>--%>
                        <%--<th>收益率</th>--%>
                        <%--<th>操作</th>--%>
                    <%--</tr>--%>

                    <%--</tbody>--%>
                <%--</table>--%>
            <%--</div>--%>
        </div>
    </div>
    <%@include file="../bottom.jsp" %>
    <%@include file="../footer.jsp" %>
</div>
</body>
<script>

    $(function() {
        //获取月份
        $.ajax({
            type: "POST",
            url: "interface/gainsInfo/getMonths.shtml",
            data: {},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (result) {
                if (result != null && result.length > 0) {
                    for (var i = 0; i < result.length; i++) {
                        var classStr = "";
                        var showCss = "style='display:none;'";
                        if ( i ==0) {
                            classStr = "class='on'";
                            showCss = "";
                        }
                        $('#monthCount').append('<a '+classStr+'>'+result[i]+'</a>');
                        $('#monthCount').after('<div class="table-area1" id="div'+result[i]+'" '+showCss+'><table class="table1" id="table'+result[i]+'"><tbody  id="tb'+result[i]+'"></tbody></table></div>');
                        //请求对应的月份数据
                        goPageByAjax(1,result[i]);
                    }

                    $('#monthCount').find('a').each(function(){
                        $(this).click(function(){
                            var month = $(this).html();
                            $('.table-area1').css('display','none');
                            $('#monthCount').find('a').attr('class','');
                            $('#div'+month).css('display','');
                            $(this).attr('class','on');
                        });


                    });
                } else {
                    $('#monthCount').after('<div class="table-area1"><table class="table1"><tr><td>暂无历史月度排名</td></tr></table></div>');
                }
            }
        });
    });

    function goPageByAjax(pageNo,month) {
        //获取交易明细
        $.ajax({
            type: "POST",
            url: "interface/gainsInfo/getTopMonthHisByPage.shtml",
            data: {month:month,pageNo:pageNo},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (result) {
                var topMonthData = result.list;
                $('#tb'+month).html('');
                $('#pager'+month).remove();
                $('#tb'+month).append('<tr><th>月份</th><th>排名</th><th>选手</th><!--<th>本金</th><th>收益</th>--><th>收益率</th><th>操作</th></tr>');
                if (topMonthData != null && topMonthData.length > 0) {
                    for (var i = 0 ; i < topMonthData.length ; i++) {
                        var showTop= '<td>'+topMonthData[i].rank+'</td>';
                        if (topMonthData[i].rank == 1) {
                            var showTop= '<td><em class="icon-one">'+topMonthData[i].rank+'</em></td>';
                        }
                        if (topMonthData[i].rank == 2) {
                            var showTop= '<td><em class="icon-two">'+topMonthData[i].rank+'</em></td>';
                        }
                        if (topMonthData[i].rank == 3) {
                            var showTop= '<td><em class="icon-three">'+topMonthData[i].rank+'</em></td>';
                        }
                        var bg = "";
                        if (i%2 == 1) {
                            bg = "class='bg'";
                        }
                        var topMonthHtml = '<tr ' + bg + '>';
                        topMonthHtml += '<td>'+topMonthData[i].month +'</td>';
                        topMonthHtml += showTop;
                        topMonthHtml += '<td>'+topMonthData[i].accountName +'</td>';
//                        topMonthHtml += '<td>'+topMonthData[i].capital +'</td>';
//                        topMonthHtml += '<td >'+topMonthData[i].yield +'</td>';
                        topMonthHtml += '<td >'+topMonthData[i].yieldRate +'%</td>';
                        topMonthHtml += '<td><a class="red" href="/static/gains/strategy.jsp?account='+$.trim(topMonthData[i].account)+'">观赛</a></td>';

                        $('#tb'+month).append(topMonthHtml);

                    }
                    $('#table'+month+'').after(getPager(month,result));
                } else {
                    $('#tb'+month).append('<tr><td  colspan="7">暂无数据</td></tr>');
                }
            }
        });
    }

    function getPager(month,result){
        var totalPage = Math.ceil((result.totalCount/result.pageSize));
        var pager = "<div class='pager' id='pager"+month+"'><ul class='floatR'>";
        pager +="<li><a  class='text' href='javascript:;' onclick='goPageByAjax(1,\""+month+"\")'>首页</a></li>";
        if (result.pageNo > 1) {
            pager += "<li><a  class='icon' href='javascript:;'  onclick='goPageByAjax(" + (result.pageNo - 1) + ",\""+month+"\")'>&lt;</a></li>";
        }
        for (var i = (result.pageNo-2<=0?1:result.pageNo-2),no = 1; i <= result.totalPage && no < 6 ; i++,no++) {
            if (result.pageNo == i) {
                pager += "<li><span class='numb on'>"+i+"</span></li>";
            }else{
                pager += "<li><a class='numb' href='javascript:;' onclick='goPageByAjax("+i+",\""+month+"\")'>"+i+"</a></li>";
            }
        }
        if (result.pageNo < totalPage) {
            pager +="<li><a class='icon' href='javascript:;'  onclick='goPageByAjax(" + (result.pageNo + 1) + ",\""+month+"\")'>&gt;</a></li>";
        }
        pager +="<li><a class='icon' href='javascript:;'  onclick='goPageByAjax("+(totalPage)+",\""+month+"\")'>尾页</a></li>";
        pager +="</ul><span class='page-numb'>第"+result.pageNo+"页 / 共"+totalPage+"页</span></div>";

        return pager;
    }
</script>
</html>
