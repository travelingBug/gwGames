<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018-9-19
  Time: 23:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>股王大赛</title>
    <%@include file="head.jsp" %>
    <style>
        .imgylclass{
            height: 100%;width:100%;border:0;
        }
    </style>
</head>
<body>
<div class="float-layer">
    <div class="content">
        <div class="fw-box">
            <a class="icon icon-close"></a>
            <div class="btns">
                <a class="btn btn-zxzx"></a>
                <a class="btn btn-cjwt"></a>
                <a class="btn btn-appxz"></a>
            </div>
        </div>
        <div class="zn-box">
            <a class="icon icon-close"></a>
            <div class="btns">
                <a class="btn btn-gszc"></a>
                <a class="btn btn-bmcs"></a>
            </div>
        </div>
    </div>
</div>
<div class="pageWrapper2">
    <%@include file="top.jsp" %>
    <div class="main-box">
        <div class="title"><div class="title-1"></div></div>
        <div class="content">
            <div class="floatL table-area">
                <h3>收益排行</h3>
                <table class="table1">
                    <tbody id="topAllByMoney">
                    <tr>
                        <th>排名</th>
                        <th>昵称</th>
                        <th>总资产</th>
                        <th>总收益</th>
                    </tr>

                    </tbody>
                </table>
            </div>
            <div class="list2" id="eventReport">

            </div>
        </div>
    </div>
    <div class="main-box border-none">
        <div class="content">
            <div class="mid-banner"></div>
        </div>
    </div>
    <div class="main-box">
        <div class="title"><div class="title-2"></div></div>
        <div class="content">
            <div class="tab1">
                <a class="on" id="all">总收益排行榜</a>
                <a id="month">月收益排行榜</a>
                <a class="link">查看更多</a>
            </div>
            <div class="table-area1" id="allShow">
                <h3><i class="icon icon-ranking"></i>首届股神大赛总收益排行</h3>
                <table class="table1">
                    <tbody  id="topAll">
                    <tr>
                        <th>排名</th>
                        <th>选手</th>
                        <th>总收益</th>
                        <th>持仓比</th>
                        <th>总资产</th>
                        <th>操作</th>
                    </tr>

                    </tbody>
                </table>
            </div>
            <div class="table-area1" style="display: none;" id="monthShow">
                <h3><i class="icon icon-ranking"></i>首届股神大赛月排行</h3>
                <table class="table1">
                    <tbody  id="topMonth">
                    <tr>
                        <th>排名</th>
                        <th>选手</th>
                        <th>总收益</th>
                        <th>持仓比</th>
                        <th>总资产</th>
                        <th>操作</th>
                    </tr>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="main-box bg-red">
        <img src="images/mid_bg.png"/>
        <div class="cont-area">
            <div class="title"><div class="title-3"></div></div>
            <div class="content">
                <div class="ld-box">
                    <i class="icon-tj"></i>
                    <p>专业机构推荐参赛选手</p>
                    <em></em>
                </div>
                <div class="ld-box">
                    <i class="icon-jd"></i>
                    <p>指定交易券商全程监督</p>
                    <em></em>
                </div>
                <div class="ld-box">
                    <i class="icon-gz"></i>
                    <p>公证机构公证</p>
                    <em></em>
                </div>
            </div>
        </div>
    </div>
    <div class="main-box border-none">
        <div class="title"><div class="title-4"></div></div>
        <div class="content">
            <div class="list3 floatL">
                <ul>
                    <li><a><i>1</i>我可以网络购物吗?</a></li>
                    <li><a><i>2</i>我可以网络购物吗?</a></li>
                    <li><a><i>3</i>我可以网络购物吗?</a></li>
                    <li><a><i>4</i>我可以网络购物吗?</a></li>
                    <li><a><i>5</i>我可以网络购物吗?</a></li>
                </ul>
            </div>
            <div class="list3 floatR">
                <ul>
                    <li><a><i>6</i>我可以网络购物吗?</a></li>
                    <li><a><i>7</i>我可以网络购物吗?</a></li>
                    <li><a><i>8</i>我可以网络购物吗?</a></li>
                    <li><a><i>9</i>我可以网络购物吗?</a></li>
                    <li><a><i>10</i>我可以网络购物吗?</a></li>
                </ul>
            </div>
        </div>
        <ul class="slider-dot">
            <li class="on"></li>
            <li></li>
            <li></li>
        </ul>
    </div>
    <%@include file="bottom.jsp" %>
    <%@include file="footer.jsp" %>
</div>
</body>
</html>
<script>
    $(function() {
        //赛事报道
        $.ajax({
            type: "POST",
            url: "interface/eventreport/list.shtml",
            data: {pageSize: 3},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (data) {
                if (data != null && data.list != null && data.list.length > 0) {
                    var reportData = data.list;
                    for (var i = 0 ; i < reportData.length;i++ ) {

                        var html = '<div class="oneline" id="'+reportData[i].id+'" style="cursor:pointer;">';
                        var more = "";
                        if (i == 0) {
                            more = '<a href="/static/eventReport/eventReport.jsp">MORE</a>'
                        }
                        html += '<div class="img" style="width: 14%;height: 4%;"><img  class="imgylclass" src="'+reportData[i].cover+'"/></div>';
                        html += '<div class="text">';
                        html += '<div class="tit"><h3>'+reportData[i].title+'</h3>'+more+'</div>';
                        html += '<p>'+reportData[i].described+'</p>';
                        html += '</div></div>';
                        $('#eventReport').append(html);
                        $('#'+reportData[i].id ).click(function(){
                            window.location.href = "/static/eventReport/eventReportDetail.jsp?id="+$(this).attr("id");
                        });
                    }



                }
            },
            error: function (data) {
            }
        });


        $.ajax({
            type: "POST",
            url: "interface/gainsInfo/getTopAllByMoney.shtml",
            data: {size: 5},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (data) {
                if (data != null && data.length > 0) {
                    for (var i = 0 ; i < data.length;i++ ) {
                        var trClass = '';
                        if (data.length % 2 == 1) {
                            trClass = 'bg';
                        }
                        var showTop= '<td>'+(i+1)+'</td>';
                        if (i == 0) {
                            var showTop= '<td><em class="icon-one">'+(i+1)+'</em></td>';
                        }
                        if (i == 1) {
                            var showTop= '<td><em class="icon-two">'+(i+1)+'</em></td>';
                        }
                        if (i == 2) {
                            var showTop= '<td><em class="icon-three">'+(i+1)+'</em></td>';
                        }
                        var html = '<tr class="'+trClass+'">';
                        html += showTop;
                        html += '<td>'+data[i].accountName+'</td>';

                        html += '<td>'+data[i].totalMoney+'</td>';
                        html += '<td>'+data[i].yield+'</td>';
                        html += '</tr>';
                        $('#topAllByMoney').append(html);
                    }

                }
            },
            error: function (data) {
                window.location.href = "/static/vips/register.jsp";
            }
        });

        $.ajax({
            type: "POST",
            url: "interface/gainsInfo/getTopAll.shtml",
            data: {size: 10},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (data) {
                if (data != null && data.length > 0) {
                    for (var i = 0 ; i < data.length;i++ ) {
                        var trClass = '';
                        if (data.length % 2 == 1) {
                            trClass = 'bg';
                        }
                        var showTop= '<td>'+(i+1)+'</td>';
                        if (i == 0) {
                            var showTop= '<td><em class="icon-one">'+(i+1)+'</em></td>';
                        }
                        if (i == 1) {
                            var showTop= '<td><em class="icon-two">'+(i+1)+'</em></td>';
                        }
                        if (i == 2) {
                            var showTop= '<td><em class="icon-three">'+(i+1)+'</em></td>';
                        }
                        var html = '<tr class="'+trClass+'">';
                        html += showTop;
                        html += '<td>'+data[i].accountName+'</td>';
                        html += '<td class="red">'+data[i].yieldRate+'</td>';
                        html += '<td>'+data[i].buyForALLRate+'</td>';
                        html += '<td>'+data[i].totalMoney+'</td>';
                        html += '<td><a class="red" href="/static/gains/strategy.jsp?account='+$.trim(data[i].account)+'">观赛</a></td>';
                        html += '</tr>';
                        $('#topAll').append(html);
                    }

                }
            },
            error: function (data) {
                window.location.href = "/static/vips/register.jsp";
            }
        });

        $.ajax({
            type: "POST",
            url: "interface/gainsInfo/getTopMonth.shtml",
            data: {size: 10},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (data) {
                if (data != null && data.length > 0) {
                    for (var i = 0 ; i < data.length;i++ ) {
                        var trClass = '';
                        if (data.length % 2 == 1) {
                            trClass = 'bg';
                        }
                        var showTop= '<td>'+(i+1)+'</td>';
                        if (i == 0) {
                            var showTop= '<td><em class="icon-one">'+(i+1)+'</em></td>';
                        }
                        if (i == 1) {
                            var showTop= '<td><em class="icon-two">'+(i+1)+'</em></td>';
                        }
                        if (i == 2) {
                            var showTop= '<td><em class="icon-three">'+(i+1)+'</em></td>';
                        }
                        var html = '<tr class="'+trClass+'">';
                        html += showTop;
                        html += '<td>'+data[i].accountName+'</td>';
                        html += '<td class="red">'+data[i].yieldRate+'</td>';
                        html += '<td>'+data[i].buyForALLRate+'</td>';
                        html += '<td>'+data[i].totalMoney+'</td>';
                        html += '<td><a class="red"  href="/static/gains/strategy.jsp?account='+$.trim(data[i].account)+'">观赛</a></td>';
                        html += '</tr>';
                        $('#topMonth').append(html);
                    }

                }
            },
            error: function (data) {
                window.location.href = "/static/vips/register.jsp";
            }
        });

        $('#all').click(function(){
            $('#all').attr('class','on');
            $('#month').attr('class','');

            $('#allShow').css('display','block');
            $('#monthShow').css('display','none');
        });

        $('#month').click(function(){
            $('#month').attr('class','on');
            $('#all').attr('class','');

            $('#monthShow').css('display','block');
            $('#allShow').css('display','none');
        });


    });
</script>