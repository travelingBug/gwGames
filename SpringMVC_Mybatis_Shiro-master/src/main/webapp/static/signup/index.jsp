<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%--shiro 标签 --%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>股王大赛</title>
    <%@include file="../head.jsp" %>
</head>

<body>
<div class="overlay layer-big" id="gameBonusDiv" style="display: none;">
    <div class="overlay-bg"></div>
    <div class="float-div">
        <a class="icon icon-close" href="javascript:;" id="gameBonusClose"></a>
        <div style="width: 100%;height: 600px;text-align: center;overflow:scroll;"  >
            <img src="<%=basePath%>/images/awrads-img.png" width="80%" height="900px">
            <div style="background-color: #FDF2E1; width: 80%;margin-left: auto;margin-right: auto;">
                <div  style="font-family:'微软雅黑';width: 80%;text-align: center;font-size:14px;font-weight:bold;margin-left: auto; margin-right: auto;padding-top: 20px;padding-bottom: 20px;">根据比赛情况，主办方保留增加大赛总收益奖励金额以及大赛月度冠军奖奖励金额的权利，主办方对大赛奖项设置拥有最终解释权。</div>
            </div>
        </div>
    </div>
</div>


<div class="overlay layer-big" id="gameIntroductionDiv" style="display: none;">
    <div class="overlay-bg"></div>
    <div class="float-div">
        <a class="icon icon-close" href="javascript:;" id="gameIntroductionClose"></a>
        <div class="content">
            <div class="one-area">
                <h3 class="title">大赛宗旨</h3>
                <p>富甲杯——中华股神实盘大赛是由富甲文化主办的实盘炒股比赛。该大赛旨在挖掘民间炒股高手，为其提供一个展现自我风采、相互学习的大舞台。</p>
            </div>
            <div class="one-area">
                <h3 class="title">大赛赛制</h3>
                <p>分为总决赛和月赛，总决赛按照正式比赛期间的总收益统计排名，月赛按照自然月收益率排名。</p>
            </div>
            <div class="one-area">
                <h3 class="title">报名时间</h3>
                <p>赛前报名时间：2018年9月16日至2018年10月17日</br>赛中报名时间：2018年9月16日至2019年6月30日</br>大赛比赛时间：2018年10月17日至2019年6月30日</p>
            </div>
            <div class="one-area">
                <h3 class="title width-220">比赛账户仓位及交易品种限制</h3>
                <p>1、比赛A股账户不限制仓位，也不限制交易品种。</br>2、比赛成绩计算参赛选手参赛账户内的金融总资产（不包含该账户持有的新三板股票以及已经退市的股票）。</br>3、参赛账户如果因为资产增值符合融资融券条件，并且在券商处开通了融资融券业务，融资融券产生的股票收益不计入参赛成绩。</br>4、参赛账户如果因为资产增值符合开通沪港通条件，并且在券商处开通了沪港通业务，沪港通产生的股票收益不计入参赛成绩。</br>5、为保证公平公正，参赛选手的参赛账户如果因为新股申购产生的打新收益，产生的打新收益不计入参赛成绩。（直接在二级市场上买卖新股产生的收益正常计入比赛成绩）</p>
            </div>
            <div class="one-area">
                <h3 class="title">获奖条件</h3>
                <p>本次活动根据选手参赛账户的收益率等条件综合排名来决定最后的优胜者。参赛选手不仅需满足收益率排名要求，还必须满足以下每一个条件，才能获奖。</br>1、满足参赛资格，遵守大赛比赛规则</br>2、参赛选手参赛账户总收益E必须大于0，才能进行总决赛排名，获得总决赛相关奖项。赛选手参赛账户月收益En无论正负，都能进行月度比赛排名，获得月度比赛相关奖项（具体详见大赛规则相关章节）。</br>3、若比赛期间参赛账户转出或转入任意资金或者发生转托管或者撤销指定交易，视为自动退赛，不得参加大赛排名，也不能获奖。若发生以上操作，选手又想重新参加比赛，必须按照赛中报名规则重新计算总收益，以此为据进行比赛总排名。</p>
            </div>
            <div class="one-area">
                <h3 class="title">退赛规则</h3>
                <p>1、为保证选手权利，选手在比赛期间有权利对参赛账户转出或者转入任意金额资金或者撤销指定交易或者转托管操作实现退赛。</br>2、为保证大赛公平公正，参赛选手在比赛期间参赛账户转出或者转入任意金额资金或者撤销指定交易或者转托管，均视为自动退赛。不得参加本大赛任何奖项评比，也不得获取本大赛任何奖励。</p>
            </div>
            <div class="one-area">
                <h3 class="title">比赛须知</h3>
                <p>参赛者应以本人名义在指定券商开立的有效合格证券账户进行参赛，本次大赛为实盘竞赛，参加大赛的选手使用自有账户自有资金参赛，自负盈亏。盈利与亏损均与主办方、证券经纪商及其他第三方无关，选手一旦报名参赛，即视为知晓和同意本大赛所有规则。</p>
            </div>
        </div>
    </div>
</div>

<div class="overlay layer-big" id="gameRuleDiv" style="display: none;">
    <div class="overlay-bg"></div>
    <div class="float-div">
        <a class="icon icon-close" href="javascript:;" id="gameRuleClose"></a>
        <div class="content">
            <div class="one-area">
                <h3 class="title">大赛赛制</h3>
                <p>分为总决赛和月赛，总决赛按照正式比赛期间的总收益统计排名，月赛按照自然月收益率排名。</p>
            </div>
            <div class="one-area">
                <h3 class="title">奖项设置</h3>
                <p>总决赛：</br>本次大赛设冠军、亚军，季军各一名，优秀选手奖17名。</br>选手参赛账户总收益率E前20名，均获得主办方颁发的荣誉证书一本以及奖品。奖品具体如下：</br>大赛总冠军（第1名）奖品为：人民币现金300000元；</br>大赛总亚军（第2名）奖品为：人民币现金100000元；</br>大赛总季军（第3名）奖品为：人民币现金50000元；</br>大赛优秀20强（第4至10名）奖励：每人人民币现金10000元；</br>大赛优秀20强（第11至20名）奖励：每人人民币现金5000元；</p>
                <p>月度赛：</br>本次大赛每一自然月均设置冠军、亚军，季军各一名。每月月度收益率En前3名均获得主办方颁发的荣誉证书一本以及奖品。奖品具体如下：</br>每月月度冠军（第1名）奖品为：人民币现金10000元；</br>每月月度亚军（第2名）奖品为：人民币现金5000元；</br>每月月度季军（第3名）奖品为：人民币现金2500元；</br>根据比赛情况，主办方保留增加大赛总收益奖励金额以及大赛月度冠军奖奖励金额的权利，主办方对大赛奖项设置拥有最终解释权。</p>
            </div>
            <div class="one-area">
                <h3 class="title">参赛资格</h3>
                <p>选手参加富甲杯——中华股神实盘大赛，需同时满足以下条件，否则不符合参赛资格：</p>
                <p>1、年满18周岁中国公民，具备独立的民事责任承担能力。</br>2、选手在XXXX网站先注册报名。</br>3、参赛选手参加比赛账户需同时满足以下2个条件，才具备参赛资格：</br>（1）2018年8月1日至2019年6月30日期间，需在指定券商营业部新开一个股票账户，在2018年8月1日之前已有账户的不具有参赛资格。<br>（2）参赛账户内金融资产不得低于30万（可为现金也可为股票也可两者兼而有之）。</br>4、参赛选手需同意并授权主办方查阅统计参赛选手的参赛账户交易数据，以统计排名，参赛选手需及时提供相应交割单或者电子版交易记录截图给主办方，以保证大赛收益排名的真实和实效性，一旦选手参赛，即视为选手知晓并同意该条款。</br>5、参赛者保证具有符合法律规定的证券投资入市条件和证券投资资格，遵守国家法律法规、证券监管部门、证券交易所、券商及主办方的相关法律及风险控制规定，不得使用证券账户参与任何非法、违规交易。</p>
            </div>
            <div class="one-area">
                <h3 class="title">参赛流程</h3>
                <p>1、选手应首先登陆富甲咨询网站XXXX,进行注册。</br>2、参赛选手在指定券商营业部新开户（账户开立时间在2018年8月1日之后才能有效报名），必须取昵称</br>3、使账户满足不低于30万金融资产要求。</p>
            </div>
            <div class="one-area">
                <h3 class="title">比赛规则</h3>
                <p>1、主办方根据参赛选手参赛账户收益率进行排名，当且仅当收益率大于0的时候才参与排名（收益率的计算方法详见相关章节）</br>2、参赛选手一旦报名参赛，即视为全权授权主办方在XXXX网站或者相关媒体公布该账户股票的相关信息，公布信息具体可能包括总收益率、月收益率、周收益率和日收益率、排名、持仓、交易价格、交易品种、交易时间、交易数量、总资产、及仓位信息等。</br>3、比赛开始后报名的选手，成绩从符合参赛资格确认后的当日开始统计。参加比赛的选手参赛账户比赛期间转出或转入任意金额资金或撤销指定交易或转托管即视为自动退赛，选手将不再计入实盘赛成绩排名。因失误发生以上操作的选手，如想重新比赛请与主办方联系（联系电话和网址），重新参赛后以前所有成绩归零，重新计入实盘赛比赛排名。</br>4、比赛所需的交易资金、交易手续费、上网费、因参加比赛产生的其他费用及其它根据法律法规、指定交易商的相关交易规则产生的费用，全部由参赛选手本人自行承担。</br>5、参赛账户在参赛期间的A股交易佣金费率，按大赛指定券商的规定执行，本条款的最终解释权归大赛主办方所有。</br>6、本次大赛收益率精确到小数点后两位，如果选手收益率相同，以选手比赛期间支付的印花税、交易手续费之和多者为胜。</br>7、参赛者必须遵守交易所和指定券商的风险控制的相关规定。</br>8、参赛选手通过实盘赛所赢取的奖品，大赛组委会为选手代扣代缴个人所得税。</br>9、主办方有权根据实际情况对大赛流程、规则、奖项、说明等进行修改或取消，主办方对于大赛参赛资格的认定、大赛规则、大赛奖品拥有最终解释权。</br>10、参赛选手一旦报名参赛，即视为已经完全知晓本大赛所有规则并且完全同意并愿意遵守大赛规则。</p>
            </div>
            <div class="one-area">
                <h3 class="title width-220">赛中报名规则</h3>
                <p>1、比赛期间，允许继续报名参加比赛，参赛资格需和赛前报名阶段一致。</br>2、选手大赛总收益奖获奖条件同初始报名选手一致。</br>3、选手大赛月度收益奖获奖条件从参赛选手满足参赛资格之后当日收盘清算之后开始计算。</br>示例：假设选手2018年11月11号具备参赛资格，即可参加比赛，也可参加11月月度奖的排名。</p>
            </div>
            <div class="one-area">
                <h3 class="title width-220">大赛总收益奖计算方法</h3>
                <p>收益率E计算公式如下：</br>E=(H－H1)÷H1×100%</br>E：选手参赛账户总收益率</br>H：2019年6月30日（周日）比赛截止日参赛选手参赛A股账户所有金融资产之和（不包含该账户持有的新三板股票以及已经退市的股票）</br>H1：参赛选手符合参赛资格之后的当日收盘，参赛选手参赛A股账户所有金融资产之和（不包含该账户持有的新三板股票以及已经退市的股票）</p>
            </div>
            <div class="one-area">
                <h3 class="title width-220">大赛月度收益奖计算方法</h3>
                <p>收益率En计算公式如下：</br>En=(Hn－Hm) ÷Hm×100%</br>En：第n月选手参赛账户月度收益率</br>Hn：第n月最后一个交易日收盘清算之后参赛选手参赛A股账户所有金融资产之和（不包含该账户持有的新三板股票以及已经退市的股票）</br>Hm：第n-1月最后一个交易日收盘清算之后参赛选手参赛A股账户所有金融资产之和（不包含该账户持有的新三板股票以及已经退市的股票）</p>
                <p>特别说明：月度收益率第一名即可获得，无需账户整体收益为正。</br>例如：2018年10月31日，假设参赛选手账户金融总资产仅为20万（因为前1个月亏损了），到了2018年11月30日，参赛选手账户金融总资产为25万，那么En=(25—20) ÷20×100%=25%。如果25%能排名在前三，虽然账户总资产低于30万，也可以参加月度排名，获得月度收益奖。</p>
            </div>
            <div class="one-area">
                <h3 class="title width-220">比赛账户仓位及交易品种限制</h3>
                <p>1、比赛A股账户不限制仓位，也不限制交易品种。</br>2、比赛成绩计算参赛选手参赛账户内的金融总资产（不包含该账户持有的新三板股票以及已经退市的股票）。</br>3、参赛账户如果因为资产增值符合融资融券条件，并且在券商处开通了融资融券业务，融资融券产生的股票收益不计入参赛成绩。</br>4、参赛账户如果因为资产增值符合开通沪港通条件，并且在券商处开通了沪港通业务，沪港通产生的股票收益不计入参赛成绩。</br>5、为保证公平公正，参赛选手的参赛账户如果因为新股申购产生的打新收益，产生的打新收益不计入参赛成绩。（直接在二级市场上买卖新股产生的收益正常计入比赛成绩）</p>
            </div>
            <div class="one-area">
                <h3 class="title">获奖条件</h3>
                <p>本次活动根据选手参赛账户的收益率等条件综合排名来决定最后的优胜者。参赛选手不仅需满足收益率排名要求，还必须满足以下每一个条件，才能获奖。</br>1、满足参赛资格，遵守大赛比赛规则</br>2、参赛选手参赛账户总收益E必须大于0，才能进行总决赛排名，获得总决赛相关奖项。赛选手参赛账户月收益En无论正负，都能进行月度比赛排名，获得月度比赛相关奖项（具体详见大赛规则相关章节）。</br>3、若比赛期间参赛账户转出或转入任意资金或者发生转托管或者撤销指定交易，视为自动退赛，不得参加大赛排名，也不能获奖。若发生以上操作，选手又想重新参加比赛，必须按照赛中报名规则重新计算总收益，以此为据进行比赛总排名。</p>
            </div>
            <div class="one-area">
                <h3 class="title">退赛规则</h3>
                <p>1、为保证选手权利，选手在比赛期间有权利对参赛账户转出或者转入任意金额资金或者撤销指定交易或者转托管操作实现退赛。</br>2、为保证大赛公平公正，参赛选手在比赛期间参赛账户转出或者转入任意金额资金或者撤销指定交易或者转托管，均视为自动退赛。不得参加本大赛任何奖项评比，也不得获取本大赛任何奖励。</p>
            </div>
            <div class="one-area">
                <h3 class="title">比赛须知</h3>
                <p>参赛者应以本人名义在指定券商开立的有效合格证券账户进行参赛，本次大赛为实盘竞赛，参加大赛的选手使用自有账户自有资金参赛，自负盈亏。盈利与亏损均与主办方、证券经纪商及其他第三方无关，选手一旦报名参赛，即视为知晓和同意本大赛所有规则。</p>
            </div>
        </div>
    </div>
</div>

<div class="bg">
    <div class="pageWrapper">
        <div class="main-page">
            <div class="top-nav">
                <ul class="floatL">
                    <li><a href="javascript:;" id="gameIntroduction" >大赛简介</a></li>
                    <li><a href="javascript:;" id="gameRule">大赛规则</a></li>
                </ul>
                <ul class="floatR">
                    <li><a href="javascript:;" id="gameBonus">奖金设置</a></li>
                    <li><a href="javascript:;" style="color: #5e5e5e">赛事报道</a></li>
                </ul>
            </div>
            <div class="btn-bm">
                <a class="btn-bm-1" href="<%=basePath%>static/signup/signup.jsp"></a>
            </div>
        </div>
        <div class="footer">
            <div class="content">
            </div>
            <div class="text">
                <p>Copyright © 四川富甲文化有限公司 </p>
                <p>QQ：1930621578&nbsp;&nbsp;微信：18981713632/ZHGSvip&nbsp;&nbsp;邮箱：zhgwvip@126.com&nbsp;&nbsp;客服电话：028-87689938</p>
            </div>

        </div>
    </div>
</div>
</body>
</html>

<script>
    $('#gameIntroduction').click(function(){
        $('#gameIntroductionDiv').css('display','block');
    });

    $('#gameRule').click(function(){
        $('#gameRuleDiv').css('display','block');
    });

    $('#gameBonus').click(function(){
        $('#gameBonusDiv').css('display','block');
    });


    $('#gameRuleClose').click(function(){
        $('#gameRuleDiv').css('display','none');
    });
    $('#gameBonusClose').click(function(){
        $('#gameBonusDiv').css('display','none');
    });
    $('#gameIntroductionClose').click(function(){
        $('#gameIntroductionDiv').css('display','none');
    });

</script>
