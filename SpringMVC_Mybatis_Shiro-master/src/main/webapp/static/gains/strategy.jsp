<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>天下股神实盘大赛</title>
    <%@include file="../head.jsp" %>
</head>
<body>
<div class="pageWrapper2 bg-gray me style1">
    <%@include file="../top.jsp" %>
    <%@include file="../banner.jsp" %>
    <ul class="page-nav">
        <li><a>比赛排名</a></li>
        <li>></li>
        <li><span>用户详情</span></li>
    </ul>
    <div class="main-box">
        <div class="content bg-white">
            <div class="head-box">
                <img src="images/img_head.png"/>
            </div>
            <div class="head-cont-box">
                <h3><span id="accountName"></span><a class="tag border-style1" id="has_follow">关注</a><a class="tag_has border-style1" id="no_follow" style="display: none;">已关注</a></h3>
                <div class="text-area">
                    <div class="L">
                        <p class="numb" id="totalMoney"></p>
                        <p class="title">总资产</p>
                    </div>
                    <div class="R">
                        <p class="numb" id="balanceMoney"></p>
                        <p class="title">资金余额</p>
                    </div>
                </div>
                <p id="businessTime"></p>
            </div>
        </div>
        <div class="content bg-white" id="zhcg">
            <div class="tab1">
                <a class="on">账户持股</a>
            </div>
            <div class="table-area1">
                <table class="table1">
                    <tbody id="strategy">
                    <tr>
                        <th>证券代码</th>
                        <th>证券简称</th>
                        <th>当前持股</th>
                    </tr>

                    </tbody>
                </table>
            </div>
        </div>
        <div class="content bg-white" id="drjymx">
            <div class="tab1">
                <a class="on">当日交易明细</a>
            </div>
            <div class="table-area1">
                <table class="table1" id="transactionInfoTable">
                    <tbody id="transactionInfo">


                    </tbody>
                </table>

            </div>
        </div>
        <%@include file="../bottom.jsp" %>
    </div>
    <%@include file="../footer.jsp" %>
</div>
</body>
<script>
    var account = '${param.account}';
    $(function() {

        $(document).keydown(function(event){
            //屏蔽F5刷新键
            if(event.keyCode==116){
                return false;
            }
        });

        $.ajax({
            type: "POST",
            url: "interface/gainsInfo/validLevel.shtml",
            data: {},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (data) {
               if(data.level ==  1){

                   //获取用户信息
                   $.ajax({
                       type: "POST",
                       url: "interface/gainsInfo/getPlayerMoney4Account.shtml",
                       data: {account:account},
                       dataType: "json",
                       beforeSend: function (request) {
                           request.setRequestHeader("Authorization", getAuthorization());
                       },
                       success: function (result) {
                           if(result.level ==  1){
                               var accountData = result.data;
                               $('#accountName').html(accountData.accountName);
                               $('#balanceMoney').html(accountData.balanceMoney);
                               $('#totalMoney').html(accountData.totalMoney);
                               $('#businessTime').html('数据日期：'+accountData.businessTimeStr);
                               //判断是否关注
                               if (accountData.isFollow == 1){
                                   hasFollow();
                               }
                           } else {
                               warnMsg('请购券后进行观赛！');
                               window.location.href = result.data;
                           }
                       },
                       error: function (result) {
                           putTokenToDef();
                           window.location.href = "/static/vips/register.jsp";
                       }
                   });

                   //获取策略信息
                   $.ajax({
                       type: "POST",
                       url: "interface/gainsInfo/getStrategy.shtml",
                       data: {account:account},
                       dataType: "json",
                       beforeSend: function (request) {
                           request.setRequestHeader("Authorization", getAuthorization());
                       },
                       success: function (result) {
                           if(result.level ==  1){
                               var strategyData = result.data;
                               for (var i = 0 ; i < strategyData.length ; i++) {
                                    var strategyHtml = '<tr><td class="yellow">';
                                   strategyHtml += strategyData[i].sharesCode +'</td><td class="yellow">';
                                   strategyHtml += strategyData[i].sharesName +'</td><td>';
                                   strategyHtml += strategyData[i].volume +'</td></tr>';
                                   $('#strategy').append(strategyHtml);

                               }
                           } else {
                               warnMsg('请购券后进行观赛！');
                               window.location.href = result.data;
                           }
                       },
                       error: function (result) {
                           putTokenToDef();
                           window.location.href = "/static/vips/register.jsp";
                       }
                   });
                   goPageByAjax(1);


                   /**
                    * 防伪标记
                    */
                   $.ajax({
                       type: "POST",
                       url: "interface/gainsInfo/getMarking.shtml",
                       data: {},
                       dataType: "json",
                       beforeSend: function (request) {
                           request.setRequestHeader("Authorization", getAuthorization());
                       },
                       success: function (result) {
                           if(result.level ==  1){
                              $('#zhcg').css("background-image","url("+result.data+")");
                              $('#drjymx').css("background-image","url("+result.data+")");

                           }
                       },
                       error: function (result) {
                       }
                   });



               } else {
                   warnMsg(data.messageText);
                   setTimeout(function(){
                       window.location.href = "/static/home.jsp";
                   }, 1000);
               }
            },
            error: function (data) {
                warnMsg('请登录后再观赛！');
                setTimeout(function(){
                    putTokenToDef();
                    window.location.href = "/static/vips/register.jsp";
                }, 1000);

            }
        });

        $('#has_follow').click(function(){
            $.ajax({
                type: "POST",
                url: "interface/gainsInfo/addfollow.shtml",
                data: {account:account},
                dataType: "json",
                beforeSend: function (request) {
                    request.setRequestHeader("Authorization", getAuthorization());
                },
                success: function (result) {
                    if(result.level ==  1){
                        shortMsg(result.messageText);
                        hasFollow();
                    } else {
                        warnMsg(result.messageText);
                    }
                },
                error: function (result) {
                    errorMsg("关注失败，请稍后再试！");
                }
            });
        });

        $('#no_follow').click(function(){
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
        });

        setTimeout(function(){
            $(document).unbind('keydown');
        }, 2500);

    });
    
    function goPageByAjax(pageNo) {
        //获取交易明细
        $.ajax({
            type: "POST",
            url: "interface/gainsInfo/getTransactionInfo.shtml",
            data: {account:account,pageNo:pageNo},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (result) {
                if(result.level ==  1){
                    var transactionInfoData = result.data.list;
                    $('#transactionInfo').html('');
                    $('.pager').remove();
                    $('#transactionInfo').append('<tr><th>交易时间</th><th>证券代码</th><th>证券简称</th><th>成交均价（元）</th><th>成交量</th><th>成交金额（元）</th><th>业务名称</th></tr>');
                    if (transactionInfoData != null && transactionInfoData.length > 0) {
                        for (var i = 0 ; i < transactionInfoData.length ; i++) {
                            var bg = "";
                            if (i%2 == 1) {
                                bg = "class='bg'";
                            }
                            var transactionInfoHtml = '<tr ' + bg + '><td>';
                            transactionInfoHtml += transactionInfoData[i].businessTimeStr +'</td>';
                            transactionInfoHtml += '<td class="yellow">'+transactionInfoData[i].sharesCode +'</td>';
                            transactionInfoHtml += '<td class="yellow">'+transactionInfoData[i].sharesName +'</td>';
                            transactionInfoHtml += '<td >'+transactionInfoData[i].price +'</td>';
                            transactionInfoHtml += '<td >'+transactionInfoData[i].volume +'</td>';
                            transactionInfoHtml += '<td >'+transactionInfoData[i].amount +'</td>';
                            transactionInfoHtml += '<td>'+ getBusinessFlagStr(transactionInfoData[i].businessFlag) +'</td></tr>';

                            $('#transactionInfo').append(transactionInfoHtml);

                        }
                        $('#transactionInfoTable').after(result.data.portalPageHtml);
                    } else {
                        $('#transactionInfo').append('<tr><td  colspan="7">暂无交易数据</td></tr>');
                    }
                } else {
                    warnMsg('请购券后进行观赛！');
                    window.location.href = result.data;
                }
            },
            error: function (result) {
                putTokenToDef();
                window.location.href = "/static/vips/register.jsp";
            }
        });
    }

    function hasFollow(){
        $('#has_follow').css('display','none');
        $('#no_follow').css('display','');
    }

    function noFollow(){
        $('#no_follow').css('display','none');
        $('#has_follow').css('display','');
    }



</script>
</html>
