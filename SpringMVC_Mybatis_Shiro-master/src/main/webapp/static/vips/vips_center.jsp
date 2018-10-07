<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>股王大赛</title>
    <%@include file="../head.jsp" %>
</head>
<body>
<div class="pageWrapper2 bg-gray me style1">
    <%@include file="../top.jsp" %>
    <ul class="page-nav">
        <li><a>我的账户</a></li>
        <li>></li>
        <li><span>用户详情</span></li>
    </ul>
    <div class="main-box">
        <div class="content bg-white">
            <div class="head-box">
                <img src="images/img_head.png"/>
            </div>
            <div class="head-cont-box">
                <h3><span>ITS-GUSHEN</span></h3>
                <p><b>A</b>类会员剩余天数</p>
                <p class="red">20天</p>
                <div class="btns">
                    <a class="btn">续费</a>
                    <a class="btn disable">升级</a>
                </div>
            </div>
        </div>
        <div class="content bg-white">
            <div class="tab1">
                <a class="on">关注选手</a>
            </div>
            <div class="table-area1" id="topFollowDiv">
                <table class="table1" id="topFollowTable">
                    <tbody id="topFollow">
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

    });

    function goPageByAjax(pageNo) {
        //获取交易明细
        $.ajax({
            type: "POST",
            url: "interface/gainsInfo/getTopAllByAccount.shtml",
            data: {pageNo:pageNo},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (result) {
                var topAllData = result.list;
                $('#topFollow').html('');
                $('#pager').remove();
                $('#topFollow').append('<tr><th>排名</th><th>选手</th><th>总收益</th><th>持仓比</th><th>总资产</th><th>操作</th></tr>');
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
                        topAllHtml += '<td><a class="red" id="no_follow" onclick="cancelFollow();">取消关注</a>&nbsp;&nbsp;<a class="red" href="/static/gains/strategy.jsp?account='+$.trim(topAllData[i].account)+'">观赛</a></td>';

                        $('#topFollow').append(topAllHtml);

                    }
                    $('#topFollowTable').after(result.portalPageHtml);
                } else {
                    $('#topFollow').append('<tr><td colspan="7">暂无数据</td></tr>');
                }
            }, error: function (result) {
                putTokenToDef();
                window.location.href = "/static/vips/register.jsp";
            }

        });
    }

    var account = '15828029800';
    function cancelFollow(){
        $.ajax({
            type: "POST",
            url: "interface/gainsInfo/cancelFollow.shtml",
            data: {account:account},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (result) {
                if(result.level ==  1){
                    shortMsg(result.messageText);
                    noFollow();
                } else {
                    warnMsg(result.messageText);
                }
            },
            error: function (result) {
                errorMsg("取消关注失败，请稍后再试！");
            }
        });
    }

</script>
</html>
