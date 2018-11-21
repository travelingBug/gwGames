<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>天下股神实盘大赛</title>
    <%@include file="../head.jsp" %>
    <style>
        .jb_img {
            width: 18px;
            height: 12px;
            margin-left: 10px;
            margin-top: 5px;
            position:absolute;
        }
    </style>
</head>
<body>
<%@include file="../float.jsp" %>
<div class="pageWrapper2 bg-gray me style1">
    <%@include file="../top.jsp" %>
    <%@include file="../banner_chlid.jsp" %>
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
            <div class="head-cont-box" id="pay_vip_info">
                <h3><span id="nickName"></span><span id="level"></span></h3>
                <p class="day" id="endTime"></p>
                <p id="level_info"></p>
            </div>
        </div>
        <div class="content bg-white">
            <div class="tab1" id="bdpm">
                <a class="on" name="zhcg">总收益排行榜</a>
                <a name="ydpm">月收益排行榜</a>
            </div>
            <div class="table-area1" id="zhcg">
                <h3><i class="icon icon-ranking"></i>总收益排行榜单</h3>
                <table class="table1">
                    <tbody id="topAll">
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

            <div class="table-area1" id="ydpm" style="display: none">
                <h3><i class="icon icon-ranking"></i>月收益排行榜单</h3>
                <table class="table1">
                    <tbody id="topMonth">
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
                   queryVipsInfo();
                   //排行榜
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
                                       trClass = '';
                                   }
                                   var newFlag = '';
                                   if (data[i].isNewFlag == 1) {
                                       newFlag = '<img src="/images/new.png" class="jb_img"/>';
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
                                   var html = '<tr class="'+trClass+'" id="trId'+i+'">';
                                   html += showTop;
                                   html += '<td>'+data[i].accountName+'</td>';
                                   html += '<td class="red">'+data[i].yieldRate+'%</td>';
                                   html += '<td>'+data[i].buyForALLRate+'%</td>';
                                   html += '<td>'+data[i].totalMoney+'</td>';
                                   html += '<td name="account" style="display: none">'+data[i].account+'</td>';
                                   html += '<td><a class="red" href="/static/gains/strategy_detail.jsp?account='+data[i].account+'">详细</a>'+newFlag+'</td>';
                                   html += '</tr>';
                                   $('#topAll').append(html);

                               }

                           }
                       },
                       error: function (data) {
                           window.location.href = "/static/vips/register.jsp?a=1";
                       }
                   });

                   //月收益排行榜
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
                                       trClass = '';
                                   }
                                   var newFlag = '';
                                   if (data[i].isNewFlag == 1) {
                                       newFlag = '<img src="/images/new.png" class="jb_img"/>';
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
                                   var html = '<tr class="'+trClass+'" id="trMonthId'+i+'">';
                                   html += showTop;
                                   html += '<td>'+data[i].accountName+'</td>';
                                   html += '<td class="red">'+data[i].yieldRate+'%</td>';
                                   html += '<td>'+data[i].buyForALLRate+'%</td>';
                                   html += '<td>'+data[i].totalMoney+'</td>';
                                   html += '<td name="account" style="display: none">'+data[i].account+'</td>';
                                   html += '<td><a class="red" href="/static/gains/strategy_detail.jsp?account='+data[i].account+'">详细</a>'+newFlag+'</td>';
                                   html += '</tr>';
                                   $('#topMonth').append(html);

                               }

                           }
                       },
                       error: function (data) {
                           window.location.href = "/static/vips/register.jsp";
                       }
                   });

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
                              $('#ydpm').css("background-image","url("+result.data+")");

                           }
                       },
                       error: function (result) {
                       }
                   });


               } else {
                   warnMsg(data.messageText);
                   setTimeout(function(){
                       window.location.href = "/static/vips/vips_pay.jsp";
                   }, 2500);
               }
            },
            error: function (data) {
                warnMsg('请登录后再观赛！');
                setTimeout(function(){
                    putTokenToDef();
                    window.location.href = "/static/vips/register.jsp?a=1";
                }, 2500);

            }
        });
        $('#bdpm').find('a').click(function(){
            if ($(this).attr('class') != 'on'){
                $('#bdpm').find('a').each(function(){
                    $(this).attr('class','');
                    $('#'+$(this).attr('name')).css('display','none');
                });
                $(this).attr('class','on');
                $('#'+$(this).attr('name')).css('display','');
            }

        });
        setTimeout(function(){
            $(document).unbind('keydown');
        }, 2500);

    });
    

    function queryVipsInfo(){
        $.ajax({
            type: "POST",
            url: "interface/vips/queryVipsInfo.shtml",
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (result) {
                $("#pay_vip_info #nickName").text(result.nickName);
                var level = result.level;
                $("#level-data").val(level);
                if(level==1){
                    $("#pay_vip_info #level").text('A类');
                    $("#pay_vip_info #level_info").text("前20名选手早盘午盘实盘赛况");
                    $("#pay_vip_info #level").addClass("tag");
                }else if(level==2){
                    $("#pay_vip_info #level").text('B类');
                    $("#pay_vip_info #level_info").text("前20名选手24小时前实盘赛况");
                    $("#pay_vip_info #level").addClass("tag");
                }else if(level==3){
                    $("#pay_vip_info #level").text('C类');
                    $("#pay_vip_info #level_info").text("前20名选手48小时前实盘赛况");
                    $("#pay_vip_info #level").addClass("tag");
                }else {
                    $("#pay_vip_info #level").removeClass("tag");
                }
                if(result.endTimeStr!=null) {
                    $("#pay_vip_info #endTime").text(result.endTimeStr);
                }

            }, error: function (result) {

            }

        });
    }
</script>
</html>
