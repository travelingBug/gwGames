<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>天下股神实盘大赛</title>
    <%@include file="../head.jsp" %>
</head>
<body>
<%@include file="../float.jsp" %>
<div class="pageWrapper2 bg-gray me style1">
    <%@include file="../top.jsp" %>
    <%@include file="../banner_chlid.jsp" %>
    <ul class="page-nav">
        <li><a>我的特权</a></li>
        <li>></li>
        <li><span>用户详情</span></li>
    </ul>
    <div class="main-box">
        <div class="content bg-white">
            <div class="head-box">
                <img src="images/img_head.png"/>
            </div>
            <div class="head-cont-box" id="center-vip-info">
                <h3><span id="nickName"></span><span id="level"></span><input type="hidden" id="level-data"/> </h3>
                <p class="day" id="endTime"></p>
                <p id="level_info"></p>
                <div class="btns">
                    <a class="btn" id="payBtn">购票</a>
                    <%--<a class="btn disable">升级</a>--%>
                </div>
            </div>
        </div>

        <div class="content bg-white">
            <div class="tab1">
                <a class="on">购票记录</a>
            </div>
            <div class="table-area1" id="depositRecordDiv">
                <table class="table1" id="depositRecordTable">
                    <tbody id="depositRecord">
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
        goPage();

//        queryDepositRecordPage(1,"depositRecord");

//        goPageByAjax(1);

        $("#payBtn").click(function(){
            window.location.href="/static/vips/vips_pay.jsp";
        });
    });

    function goPage(){
        $.ajax({
            type: "POST",
            url: "interface/gainsInfo/validLevel.shtml",
            data: {},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (data) {
                queryVipsInfo();
            },
            error: function (data) {
                putTokenToDef();
                window.location.href = "/static/vips/register.jsp?a=1";

            }
        });
    }

    function queryVipsInfo(){
        $.ajax({
            type: "POST",
            url: "interface/vips/queryVipsInfo.shtml",
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (result) {
                $("#center-vip-info #nickName").text(result.nickName);

                var level = result.level;
                $("#level-data").val(level);
                if(level==1){
                    $("#center-vip-info #level").text('A类');
                    $("#center-vip-info #level_info").text("前20名选手早盘午盘实盘赛况");
                    $("#center-vip-info #level").addClass("tag");
                }else if(level==2){
                    $("#center-vip-info #level").text('B类');
                    $("#center-vip-info #level_info").text("前20名选手24小时实盘赛况");
                    $("#center-vip-info #level").addClass("tag");
                }else if(level==3){
                    $("#center-vip-info #level").text('C类');
                    $("#center-vip-info #level_info").text("前20名选手48小时实盘赛况");
                    $("#center-vip-info #level").addClass("tag");
                }else {
                    $("#center-vip-info #level").removeClass("tag");
                }
                if(result.endTimeStr!=null) {
                    $("#center-vip-info #endTime").text(result.endTimeStr);
                }
            }, error: function (result) {

            }

        });
    }

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

    function queryDepositRecordPage(pageNo,id) {
        //获取交易明细
        $.ajax({
            type: "POST",
            url: "interface/gainsInfo/getTopMonthHisByPage.shtml",
            data: {pageNo:pageNo},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (result) {
                var recordData = result.list;
                $('#tb'+id).html('');
                $('#pager'+id).remove();
                $('#tb'+id).append('<tr><th></th><th>购票等级</th><th>购票金额</th><th>购票时间</th></tr>');
                if (recordData != null && recordData.length > 0) {
                    for (var i = 0 ; i < recordData.length ; i++) {
                        var showTop= '<td>'+recordData[i].rank+'</td>';
                        var bg = "";
                        if (i%2 == 1) {
                            bg = "class='bg'";
                        }
                        var recordHtml = '<tr ' + bg + '>';
                        recordHtml += '<td>'+recordData[i].level +'</td>';
                        recordHtml += showTop;
                        recordHtml += '<td>'+recordData[i].amount +'</td>';
                        recordHtml += '<td>'+recordData[i].crt_time +'</td>';


                        $('#tb'+id).append(recordHtml);

                    }
                    $('#table'+id+'').after(getPager(id,result));
                } else {
                    $('#tb'+id).append('<tr><td  colspan="3">暂无数据</td></tr>');
                }
            }
        });
    }

    function getPager(id,result){
        var totalPage = Math.ceil((result.totalCount/result.pageSize));
        var pager = "<div class='pager' id='pager"+id+"'><ul class='floatR'>";
        pager +="<li><a  class='text' href='javascript:;' onclick='queryDepositRecordPage(1,\""+id+"\")'>首页</a></li>";
        if (result.pageNo > 1) {
            pager += "<li><a  class='icon' href='javascript:;'  onclick='queryDepositRecordPage(" + (result.pageNo - 1) + ",\""+id+"\")'>&lt;</a></li>";
        }
        for (var i = (result.pageNo-2<=0?1:result.pageNo-2),no = 1; i <= result.totalPage && no < 6 ; i++,no++) {
            if (result.pageNo == i) {
                pager += "<li><span class='numb on'>"+i+"</span></li>";
            }else{
                pager += "<li><a class='numb' href='javascript:;' onclick='queryDepositRecordPage("+i+",\""+id+"\")'>"+i+"</a></li>";
            }
        }
        if (result.pageNo < totalPage) {
            pager +="<li><a class='icon' href='javascript:;'  onclick='queryDepositRecordPage(" + (result.pageNo + 1) + ",\""+id+"\")'>&gt;</a></li>";
        }
        pager +="<li><a class='icon' href='javascript:;'  onclick='queryDepositRecordPage("+(totalPage)+",\""+id+"\")'>尾页</a></li>";
        pager +="</ul><span class='page-numb'>第"+result.pageNo+"页 / 共"+totalPage+"页</span></div>";

        return pager;
    }

</script>
</html>
