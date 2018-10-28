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
    <!-- download start -->
    <div class="download-main">
        <div class="download-main-one">
            <div class="main-one">
                <div class="download-main-info">
                    <div class="main-left">
                        <img class="info-title" src="images/font.png" alt="文字">
                        <div class="info-left">
                            <img src="images/qr-code.png" alt="二维码">
                            <p>扫描二维码下载</p>
                        </div>
                        <div class="info-right">
                            <div class="download-icon download-android">
                                <img src="images/android-1.png" alt="Android">
                                <span>安卓端下载</span>
                            </div>
                            <div class="download-icon download-ios active">
                                <img src="images/ios-2.png" alt="Android">
                                <span>IOS端下载</span>
                            </div>
                        </div>
                        <!-- 清除浮动 -->
                        <div class="clearfix"></div>
                    </div>
                    <div class="down-logo">
                        <img src="images/iPhone.png">
                    </div>
                </div>
            </div>
        </div>
        <div class="download-main-two">
            <div class="main-contact contact-qq">
                <img src="images/Group 4.png" alt="">
            </div>
            <div class="main-contact contact-phone">
                <img src="images/Group 3.png" alt="">
            </div>
        </div>
    </div>
    <!-- download end -->

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
                            topAllHtml += '<td >'+topAllData[i].totalMoney +'</td>';
                            topAllHtml += '<td><a class="red" href="/static/gains/strategy.jsp?account='+$.trim(topAllData[i].account)+'">观赛</a></td>';

                            $('#topAll').append(topAllHtml);

                        }
                        if(result.totalCount > (result.pageNo * result.pageSize)) {
                            $("#readAll").css('display','');
                            $("#readAll").unbind('click').click(function () {
                                goPageByAjax(result.pageNo + 1);
                            });
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
                        topMonthHtml += '<td >'+topMonthData[i].totalMoney +'</td>';
                        topMonthHtml += '<td><a class="red" href="/static/gains/strategy.jsp?account='+$.trim(topMonthData[i].account)+'">观赛</a></td>';

                        $('#topMonth').append(topMonthHtml);

                    }
                    if(result.totalCount > (result.pageNo * result.pageSize)) {
                        $("#readMonth").css('display','');
                        $("#readMonth").unbind('click').click(function () {
                            goPageByAjax2(result.pageNo + 1);
                        });
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