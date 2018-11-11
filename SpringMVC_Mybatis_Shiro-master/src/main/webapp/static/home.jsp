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
    <title>天下股神实盘大赛</title>
    <%@include file="head.jsp" %>
    <style>
        .imgylclass{
            height: 100%;width:100%;border:0;
        }
        .more{
            position: absolute;
            line-height: 20px;
            background:#e1c9a6;
            color: #8f6e40;
        }
        .more:hover {
            background: #edd7b8;
        }

    </style>
</head>
<body>
<!--—————————————————————————————— 新增弹出框部分 ——————————————————————————————-->



<div class="projectile-frame" style="margin: 22% 2%" id="closeMidDoor">
    <div class="content">
        <div class="pf-box">
            <a class="icon icon-close" id="closeMidPopu"></a>
        </div>
        <div class="ch-box">
            <div class="btns">
                <a class="btn btn-fzxzx" href="tencent://message/?uin=1930621578&Site=http://60.205.189.94&Menu=yes"></a>
                <a class="btn btn-fcsrk" href="/static/gains/strategy.jsp"></a>
            </div>
        </div>
    </div>
</div>




<!--——————————————————————————————    end    ——————————————————————————————-->
<%@include file="float.jsp" %>
<div class="pageWrapper2">
    <%@include file="top.jsp" %>
    <%@include file="banner.jsp" %>
    <div class="main-box">
        <div class="title"><div class="title-1"></div></div>
        <div class="content">
            <div class="floatL table-area">
                <h3>收益率排行</h3>
                <table class="table1">
                    <tbody id="topAllByMoney">
                    <tr>
                        <th>排名</th>
                        <th>昵称</th>
                        <th>持仓比</th>
                        <th>收益率</th>
                        <th>操作</th>
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
            <div class="mid-banner" id="advert_home" style="cursor: pointer;"></div>
        </div>
    </div>
    <div class="main-box">
        <div class="title"><div class="title-2"></div></div>
        <div class="content">
            <div class="tab1">
                <a class="on" id="all">总收益排行榜</a>
                <a id="month">月收益排行榜</a>
                <a class="link" href="/static/rank/ranking.jsp">查看更多</a>
            </div>
            <div class="table-area1" id="allShow">
                <h3><i class="icon icon-ranking"></i>首届股神大赛总收益率排行</h3>
                <table class="table1">
                    <tbody  id="topAll">
                    <tr>
                        <th>排名</th>
                        <th>选手</th>
                        <th>总收益</th>
                        <th>持仓比</th>
                        <%--<th>总资产</th>--%>
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
                        <%--<th>总资产</th>--%>
                        <th>操作</th>
                    </tr>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="main-box bg-red">
        <img id="img1920" src="images/mid_bg.png"/>
        <div class="cont-area">
            <div class="title"><div class="title-3"></div></div>
            <div class="content">
            </div>
        </div>
    </div>
    <div class="main-box border-none"  style="display: none;">
        <div class="title"><div class="title-4"></div></div>
        <div class="content" id="problemDiv">
            <div class="list3 floatL">
                <ul  id="problemL">
                </ul>
            </div>
            <div class="list3 floatR">
                <ul  id="problemR">
                </ul>
            </div>

        </div>

    </div>
    <%@include file="bottom.jsp" %>
    <%@include file="footer.jsp" %>
</div>
</body>
</html>
<script>
    $(function() {
        if (screen.width >= 1800)
        {
            $('#img1920').attr('src','images/mid_bg_1920.png');
        }
        $('#closeMidPopu').click(function () {
            $('#closeMidDoor').css('display','none');
        });
        $.ajax({
            type: "POST",
            url: "interface/homeconfig/getHomeAdvert.shtml",
            data: {},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (data) {
                if (data.level == 1) {
                    var advert = data.data;
                    if (advert != null && advert.length > 0) {
                        $('#advert_home').css("background-image","url("+advert[0].imgPath+")");
                        $('#advert_home').click(function () {
                            var url = advert[0].url;
                            if (!(url.startWith('http://') || url.startWith('https://'))) {
                                url = 'http://'+url;
                            }
                            window.location.href = url;
                        });
                    }
                }
            },
            error: function (data) {
            }
        });


        //常见问题
        $.ajax({
            type: "POST",
            url: "interface/problem/list.shtml",
            data: {pageSize: 10},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (data) {
                if (data != null && data.list != null && data.list.length > 0) {
                    var problemData = data.list;
                    for (var i = 0 ; i < problemData.length;i++ ) {

                        var html = '<li><a href="/static/problem/problemDetail.jsp?id='+problemData[i].id+'"><i>'+(i+1)+'</i>'+problemData[i].problem+'</a></li>';
                        if (i%2 == 0) {
                            $('#problemL').append(html);
                        } else {
                            $('#problemR').append(html);
                        }
                    }
                }
                $('#problemDiv').after('<div style="width:98%;text-align: center;cursor:pointer;" id="problemMore"><a class="more">MORE</a></div>')
                $('#problemMore').click(function(){
                    window.location.href = "/static/problem/problem.jsp";
                });
            },
            error: function (data) {
            }
        });


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
            url: "interface/gainsInfo/getTopAll.shtml",
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

                        html += '<td>'+data[i].buyForALLRate+'%</td>';
                        html += '<td>'+data[i].yieldRate+'%</td>';
                        html += '<td><a class="red" href="/static/gains/strategy.jsp?account='+$.trim(data[i].account)+'">观赛</a></td>';
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
            data: {size: 20},
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
                        html += '<td class="red">'+data[i].yieldRate+'%</td>';
                        html += '<td>'+data[i].buyForALLRate+'%</td>';
//                        html += '<td>'+data[i].totalMoney+'</td>';
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
            data: {size: 20},
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
                        html += '<td class="red">'+data[i].yieldRate+'%</td>';
                        html += '<td>'+data[i].buyForALLRate+'%</td>';
//                        html += '<td>'+data[i].totalMoney+'</td>';
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