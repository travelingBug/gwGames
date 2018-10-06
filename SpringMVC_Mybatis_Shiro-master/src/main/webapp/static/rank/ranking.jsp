<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>股王大赛</title>
    <%@include file="../head.jsp" %>
</head>
<body>
<div class="pageWrapper2">
    <%@include file="../top.jsp" %>
    <div class="main-box">
        <div class="content">
            <div class="tab1">
                <a class="on" id="allTab">总收益排行榜</a>
                <a id="monthTab">月收益排行榜</a>
            </div>
            <div class="table-area1" id="topAllDiv">
                <table class="table1" id="topAllTable">
                    <tbody id="topAll">
                    </tbody>
                </table>
            </div>

            <div class="table-area1" id="topMonthDiv" style="display: none;">

                <table class="table1" id="topMonthTable">
                    <tbody id="topMonth">
                    </tbody>
                </table>
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
        goPageByAjax2(1);
        $('#monthTab').click(function(){
            $('#topMonthDiv').css('display','');
            $('#topAllDiv').css('display','none');

            $('#monthTab').attr('class','on');
            $('#allTab').attr('class','');
        });
        $('#allTab').click(function(){
            $('#topMonthDiv').css('display','none');
            $('#topAllDiv').css('display','');

            $('#monthTab').attr('class','');
            $('#allTab').attr('class','on');
        });
    });
    function goPageByAjax(pageNo) {
        //获取交易明细
        $.ajax({
            type: "POST",
            url: "interface/gainsInfo/getTopAllByPage.shtml",
            data: {pageNo:pageNo},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (result) {
                    var topAllData = result.list;
                    $('#topAll').html('');
                    $('#pager').remove();
                    $('#topAll').append('<tr><th>排名</th><th>选手</th><th>总收益</th><th>持仓比</th><th>总资产</th><th>操作</th></tr>');
                    if (topAllData != null && topAllData.length > 0) {
                        for (var i = 0 ; i < topAllData.length ; i++) {
                            var showTop= '<td>'+topAllData[i].rank+'</td>';
                            if (topAllData[i].rank == 1) {
                                var showTop= '<td><em class="icon-one">'+topAllData[i].rank+'</em></td>';
                            }
                            if (topAllData[i].rank == 2) {
                                var showTop= '<td><em class="icon-two">'+topAllData[i].rank+'</em></td>';
                            }
                            if (topAllData[i].rank == 3) {
                                var showTop= '<td><em class="icon-three">'+topAllData[i].rank+'</em></td>';
                            }
                            var bg = "";
                            if (i%2 == 1) {
                                bg = "class='bg'";
                            }
                            var topAllHtml = '<tr ' + bg + '>';
                            topAllHtml += showTop;
                            topAllHtml += '<td>'+topAllData[i].accountName +'</td>';
                            topAllHtml += '<td>'+topAllData[i].yieldRate +'%</td>';
                            topAllHtml += '<td >'+topAllData[i].buyForALLRate +'%</td>';
                            topAllHtml += '<td >'+topAllData[i].totalMoney +'</td>';
                            topAllHtml += '<td><a class="red" href="/static/gains/strategy.jsp?account='+$.trim(topAllData[i].account)+'">观赛</a></td>';

                            $('#topAll').append(topAllHtml);

                        }
                        $('#topAllTable').after(result.portalPageHtml);
                    } else {
                        $('#topAll').append('<tr><td  colspan="7">暂无数据</td></tr>');
                    }
                }
        });
    }

    function goPageByAjax2(pageNo) {
        //获取交易明细
        $.ajax({
            type: "POST",
            url: "interface/gainsInfo/getTopMonthByPage.shtml",
            data: {pageNo:pageNo},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (result) {
                var topMonthData = result.list;
                $('#topMonth').html('');
                $('#pager2').remove();
                $('#topMonth').append('<tr><th>排名</th><th>选手</th><th>总收益</th><th>持仓比</th><th>总资产</th><th>操作</th></tr>');
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
                        topMonthHtml += showTop;
                        topMonthHtml += '<td>'+topMonthData[i].accountName +'</td>';
                        topMonthHtml += '<td>'+topMonthData[i].yieldRate +'%</td>';
                        topMonthHtml += '<td >'+topMonthData[i].buyForALLRate +'%</td>';
                        topMonthHtml += '<td >'+topMonthData[i].totalMoney +'</td>';
                        topMonthHtml += '<td><a class="red" href="/static/gains/strategy.jsp?account='+$.trim(topMonthData[i].account)+'">观赛</a></td>';

                        $('#topMonth').append(topMonthHtml);

                    }
                    $('#topMonthTable').after(result.portalPageHtml2);
                } else {
                    $('#topMonth').append('<tr><td  colspan="7">暂无数据</td></tr>');
                }
            }
        });
    }
</script>
</html>