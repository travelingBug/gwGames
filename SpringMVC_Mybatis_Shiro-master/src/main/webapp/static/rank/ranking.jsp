<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>天下股神实盘大赛</title>
    <%@include file="../head.jsp" %>
    <style>
        .hide-article-box {
            /*position: absolute;*/
            z-index: 9999;
            bottom: 0;
            width: 100%;
            padding-top: 160px;
            background-image: -webkit-gradient(linear,left top, left bottom,from(rgba(255,255,255,0)),color-stop(70%, #fff));
            background-image: linear-gradient(-180deg,rgba(255,255,255,0) 0%,#fff 70%);
        }

        .changImgColor{
            background-color: #EFEFEF;
            height: 28px;
            valign:middle;
        }
        .changImgColor:hover
        {
            background-color:#E6E6E6;
        }
    </style>
</head>
<body>
<%@include file="../float.jsp" %>
<div class="pageWrapper2">
    <%@include file="../top.jsp" %>
    <%@include file="../banner_chlid.jsp" %>
    <div class="main-box">
        <div class="content">
            <div class="tab1">
                <a class="on" id="allTab">总收益排行榜</a>
                <a id="monthTab">月收益排行榜</a>
            </div>
            <div class="table-area1" id="topAllDiv">
                <table class="table1" id="topAllTable">
                    <tbody id="topAll">
                        <tr><th>排名</th><th>选手</th><th>总收益</th><th>持仓比</th><!--<th>总资产</th>--><th>操作</th></tr>
                    </tbody>
                </table>
                <table class="table1">
                    <tr><td colspan="6" height="20px;"></td></tr>
                    <tr>
                        <td colspan="6" class="changImgColor"  style="display: none;cursor: pointer;" id="readAll">
                            <span style="font-size: 14px;font-family:微软雅黑;">加载更多</span>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="table-area1" id="topMonthDiv" style="display: none;">

                <table class="table1" id="topMonthTable">
                    <tbody id="topMonth">
                    <tr><th>排名</th><th>选手</th><th>总收益</th><th>持仓比</th><!--<th>总资产</th>--><th>操作</th></tr>
                    </tbody>
                </table>
                <table class="table1" >
                    <tr><td colspan="6" height="20px;"></td></tr>
                    <tr>
                        <td colspan="6" class="changImgColor"  style="display: none;cursor: pointer;" id="readMonth">
                            <span style="font-size: 14px;font-family:微软雅黑;">加载更多</span>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <br/><br/><br/>
    </div>
    <%@include file="../bottom.jsp" %>
    <%@include file="../footer.jsp" %>
</div>
</body>
<script>
    var continueLoad = true;
    var continueLoadMonth = true;
    $(function() {
        goPageByAjax(1,20);
        goPageByAjax2(1,20);
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
    function goPageByAjax(pageNo,pageSize) {
        //获取交易明细
        $.ajax({
            type: "POST",
            url: "interface/gainsInfo/getTopAllByPage.shtml",
            data: {pageNo:pageNo,pageSize:pageSize},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (result) {
                    var topAllData = result.list;
//                    $('#topAll').html('');
//                    $('#pager').remove();
//                    $('#topAll').append('<tr><th>排名</th><th>选手</th><th>总收益</th><th>持仓比</th><th>总资产</th><th>操作</th></tr>');
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
//                            topAllHtml += '<td >'+topAllData[i].totalMoney +'</td>';
                            topAllHtml += '<td><a class="red" href="/static/gains/strategy.jsp?account='+$.trim(topAllData[i].account)+'">观赛</a></td>';

                            $('#topAll').append(topAllHtml);

                        }
                        if(result.totalCount > (result.pageNo * result.pageSize)) {
                            $("#readAll").css('display','');
//                            $("#readAll").unbind('click').click(function () {
//                                goPageByAjax(result.pageNo + 1,20);
//                            });
                            if (continueLoad) {
                                continueLoad = false
                                $("#readAll").unbind('click').click(function () {
                                    goPageByAjax(3,10);
                                });
                            } else {
                                $("#readAll").unbind('click');
                            }
                        } else {
                            $("#readAll").css('display','none');
                        }

//                        $('#topAllTable').after(result.portalPageHtml);
                    } else {
                        $('#topAll').append('<tr><td  colspan="6">暂无数据</td></tr>');
                    }
                }
        });
    }

    function goPageByAjax2(pageNo,pageSize) {
        //获取交易明细
        $.ajax({
            type: "POST",
            url: "interface/gainsInfo/getTopMonthByPage.shtml",
            data: {pageNo:pageNo,pageSize:pageSize},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (result) {
                var topMonthData = result.list;
//                $('#topMonth').html('');
//                $('#pager2').remove();
//                $('#topMonth').append('<tr><th>排名</th><th>选手</th><th>总收益</th><th>持仓比</th><th>总资产</th><th>操作</th></tr>');
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
//                        topMonthHtml += '<td >'+topMonthData[i].totalMoney +'</td>';
                        topMonthHtml += '<td><a class="red" href="/static/gains/strategy.jsp?account='+$.trim(topMonthData[i].account)+'">观赛</a></td>';

                        $('#topMonth').append(topMonthHtml);

                    }
                    if(result.totalCount > (result.pageNo * result.pageSize)) {
                        $("#readMonth").css('display','');
//                        $("#readMonth").unbind('click').click(function () {
//                            goPageByAjax2(result.pageNo + 1,20);
//                        });
                        if (continueLoadMonth) {
                            continueLoadMonth = false
                            $("#readMonth").unbind('click').click(function () {
                                goPageByAjax2(3,10);
                            });
                        } else {
                            $("#readMonth").unbind('click');
                        }
                    } else {
                        $("#readMonth").css('display','none');
                    }
//                    $('#topMonthTable').after(result.portalPageHtml2);
                } else {
                    $('#topMonth').append('<tr><td  colspan="6">暂无数据</td></tr>');
                }
            }
        });
    }
</script>
</html>