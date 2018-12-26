<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>天下股神实盘大赛</title>
    <%@include file="../head.jsp" %>
    <script  src="<%=basePath%>/js/bankCardAttribution.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
    <link href="${basePath}/css/gwGame.css?${_v}" rel="stylesheet"/>
    <script src="<%=basePath%>/js/pay/jquery-validate.js"></script>
</head>
<body>
<div class="pageWrapper2 bg-gray me style1" id="pay_main_div">
    <%@include file="../top.jsp" %>
    <ul class="page-nav">
        <li><a>我的账户</a></li>
        <li>></li>
        <li><span>购票中心</span></li>
    </ul>
    <div class="main-box">
        <div class="content bg-white">
            <div class="head-box">
                <img src="images/img_head.png"/>
            </div>
            <div class="head-cont-box" id="pay_vip_info">
                <h3><span id="nickName"></span><span id="level"></span><input type="hidden" id="level-data"/> </h3>
                <p class="day" id="endTime"></p>
                <p id="level_info"></p>
            </div>
        </div>
        <div class="content bg-white">
            <div class="select-box">
                <div class="one-area">
                    <div class="img-area img-a">
                        <span class="L"></span>
                        <span class="R"></span>
                    </div>
                    <p>可观看本平台公布的比赛排名前20名参赛选手T日实盘赛况（T日指比赛当日）</p>
                </div>
                <div class="one-area">
                    <div class="img-area img-b">
                        <span class="L"></span>
                        <span class="R"></span>
                    </div>
                    <p>可观看本平台公布的比赛排名前20名参赛选手T-1日实盘赛况（T日指比赛当日）</p>
                </div>
                <div class="one-area">
                    <div class="img-area img-c">
                        <span class="L"></span>
                        <span class="R"></span>
                    </div>
                    <p>可观看本平台公布的比赛排名前20名参赛选手T-2日实盘赛况（T日指比赛当日）</p>
                </div>
                <input type="hidden" id="pay_ticket"/>
            </div>
            <div class="pay-tips" style="color: #e33434;">
                注：1、比赛日当日大赛赛况更新两次，分别为13点和17点，购买A类票的客户可随时看到T日赛况。
                2、大赛提及所有观赛日和可观看比赛日时间均为沪深交易日，不包含周六日和法定节假日。资产和持仓均为T-1日，策略为T日。
            </div>
            <div class="select-box">
                <p class="title-style">选择方式：</p>
                <div class="select-cont" id="checkWay">
                    <a class="select-btn on"><i class="icon-on"></i>银行卡支付</a>
                    <a class="select-btn"><i></i>微信支付</a>
                </div>
            </div>
            <div class="bankPay">
                <table class="table1">
                    <tr>
                        <th>银行</th>
                        <th>业务类型</th>
                        <th>借贷记类型</th>
                        <th>单笔最高限额（元）</th>
                        <th>日累计限额（元）</th>
                    </tr>
                    <tr>
                        <td>邮储银行</td>
                        <td>快捷支付</td>
                        <td>借记卡</td>
                        <td>5000</td>
                        <td>5000</td>
                    </tr>
                    <tr>
                        <td>工商银行</td>
                        <td>快捷支付</td>
                        <td>借记卡</td>
                        <td>50000</td>
                        <td>50000</td>
                    </tr>
                    <tr>
                        <td>农业银行</td>
                        <td>快捷支付</td>
                        <td>借记卡</td>
                        <td>5000</td>
                        <td>5000</td>
                    </tr>
                    <tr>
                        <td>中国银行</td>
                        <td>快捷支付</td>
                        <td>借记卡</td>
                        <td>5000</td>
                        <td>10000</td>
                    </tr>
                    <tr>
                        <td>中国建设银行</td>
                        <td>快捷支付</td>
                        <td>借记卡</td>
                        <td>50000</td>
                        <td>100000</td>
                    </tr>
                    <tr>
                        <td>交通银行</td>
                        <td>快捷支付</td>
                        <td>借记卡</td>
                        <td>10000</td>
                        <td>10000</td>
                    </tr>
                    <tr>
                        <td>中信银行</td>
                        <td>快捷支付</td>
                        <td>借记卡</td>
                        <td>5000</td>
                        <td>5000</td>
                    </tr>
                    <tr>
                        <td>光大银行</td>
                        <td>快捷支付</td>
                        <td>借记卡</td>
                        <td>50000</td>
                        <td>50000</td>
                    </tr>
                    <tr>
                        <td>广发银行</td>
                        <td>快捷支付</td>
                        <td>借记卡</td>
                        <td>50000</td>
                        <td>100000</td>
                    </tr>
                    <tr>
                        <td>平安银行</td>
                        <td>快捷支付</td>
                        <td>借记卡</td>
                        <td>50000</td>
                        <td>50000</td>
                    </tr>
                    <tr>
                        <td>招商银行</td>
                        <td>快捷支付</td>
                        <td>借记卡</td>
                        <td>800</td>
                        <td>5000</td>
                    </tr>
                    <tr>
                        <td>兴业银行</td>
                        <td>快捷支付</td>
                        <td>借记卡</td>
                        <td>50000</td>
                        <td>50000</td>
                    </tr>
                    <tr>
                        <td>浦发银行</td>
                        <td>快捷支付</td>
                        <td>借记卡</td>
                        <td>50000</td>
                        <td>50000</td>
                    </tr>
                    <tr>
                        <td>浙商银行</td>
                        <td>快捷支付</td>
                        <td>借记卡</td>
                        <td>20000</td>
                        <td>20000</td>
                    </tr>
                    <tr>
                        <td>上海银行</td>
                        <td>快捷支付</td>
                        <td>借记卡</td>
                        <td>50000</td>
                        <td>100000</td>
                    </tr>
                    <tr>
                        <td>北京银行</td>
                        <td>快捷支付</td>
                        <td>借记卡</td>
                        <td>500</td>
                        <td>20000</td>
                    </tr>
                    <tr>
                        <td>民生银行</td>
                        <td>快捷支付</td>
                        <td>借记卡</td>
                        <td>600</td>
                        <td>20000</td>
                    </tr>
                </table>
            </div>
            <div class="select-box bankPay">
                <p class="title-style">支付方式：</p>
                <div class="select-cont" id="pay_list">
                </div>
            </div>
            <div class="select-box bankPay" id="pay_yzm">
                <p class="title-style">验证码：</p>
                <div class="select-cont">
                    <div class="input-numb">
                        <input type="text" class="width-60 smsCode" readonly="true" maxlength="1"/>
                        <input type="text" class="width-60 smsCode" readonly="true" maxlength="1"/>
                        <input type="text" class="width-60 smsCode" readonly="true" maxlength="1"/>
                        <input type="text" class="width-60 smsCode" readonly="true" maxlength="1"/>
                        <input type="text" class="width-60 smsCode" readonly="true" maxlength="1"/>
                        <input type="text" class="width-60 smsCode" readonly="true" maxlength="1"/>
                        <input type="hidden" id="smsCode"/>
                        <a class="yzm width-60" id="sendSmsCode" onclick="sendSmsCode();">获取验证码</a>
                    </div>
                    <p class="tip">请输入验证码</p>
                </div>
            </div>
            <div class="select-box" style="padding-left: 70px;"><input type="radio" value="1" id="readText" class="radio-style"/><p class="pay_read">阅读并同意<a href="javascript:;" id="readContentButton">观赛须知</a></p></div>
            <a class="btn-zf" id="pay_zf" onclick="pay();">确认支付</a>
            <a class="btn-zf" id="wxPayBtn" onclick="">确认支付</a>
        </div>
    </div>
    <%@include file="../bottom.jsp" %>
    <%@include file="../footer.jsp" %>
</div>

<div class="overlay layer-small recharge" id="pay_bank_div">
    <div class="overlay-bg"></div>
    <div class="float-div">
        <a class="icon icon-close" id="pay_icon_close"></a>
        <h3 class="title">快捷支付</h3>
        <div class="content">
            <table class="table2" id="pay_table">
                <tbody>
                <form action="#" method="post" id="addBankForm">
                <tr>
                    <th>付款银行：</th>
                    <td><span id="pay_bank" name="bankName"></span></td>
                </tr>
                <tr>
                    <th>银行卡号：</th>
                    <td>
                        <input  class="input width-240" id="pay_bank_no" name="cardNo"/>
                        <input id="cardCode" type="hidden" name="cardCode"/>
                        <span class="icon-vali"></span>
                    </td>
                </tr>
                <tr>
                    <th>姓     名：</th>
                    <td>
                        <input class="input width-240" id="pay_name" name="cardName"/>
                        <span class="icon-vali"></span>
                    </td>
                </tr>
                <tr>
                    <th>证件号码：</th>
                    <td>
                        <input class="input width-240" id="pay_cardno" name="idNo"/>
                        <span class="icon-vali"></span>
                    </td>
                </tr>
                <tr>
                    <th>手机号码：</th>
                    <td>
                        <input class="input width-240" id="pay_phone" name="bankPhone"/>
                        <span class="icon-vali"></span>
                    </td>
                </tr>
                <%--<tr>--%>
                    <%--<th class="i-block">支付密码：</th>--%>
                    <%--<td>--%>
                        <%--<div id="payPassword_container" class="alieditContainer clearfix" data-busy="0">--%>
                            <%--<div class="i-block" data-error="i_error">--%>
                                <%--<div class="i-block six-password">--%>
                                    <%--<input class="i-text sixDigitPassword" id="payPassword_rsainput" type="password" autocomplete="off" required="required" value="" name="payPassword_rsainput" data-role="sixDigitPassword" tabindex="" maxlength="6" minlength="6" aria-required="true">--%>
                                    <%--<div tabindex="0" class="sixDigitPassword-box" style="width: 180px;">--%>
                                    <%--<i style="width: 29px; border-color: transparent;" class=""><b style="visibility: hidden;"></b></i>--%>
                                    <%--<i style="width: 29px;"><b style="visibility: hidden;"></b></i>--%>
                                    <%--<i style="width: 29px;"><b style="visibility: hidden;"></b></i>--%>
                                    <%--<i style="width: 29px;"><b style="visibility: hidden;"></b></i>--%>
                                    <%--<i style="width: 29px;"><b style="visibility: hidden;"></b></i>--%>
                                    <%--<i style="width: 29px;"><b style="visibility: hidden;"></b></i>--%>
                                    <%--<span style="width: 29px; left: 0px; visibility: hidden;" id="cardwrap" data-role="cardwrap"></span>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                                <%--<a class="yzm width-60" id="sendCardSmsCode" onclick="sendCardValidate();">获取验证码</a>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</td>--%>
                <%--</tr>--%>
                <tr>
                    <th></th>
                    <td><a class="btn-register" onclick="addBank();" id="pay_add_btn">同意开通</a></td>
                </tr>
                </form>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="overlay layer-small recharge" id="pay_first_div">
    <div class="overlay-bg"></div>
    <div class="float-div">
        <a class="icon icon-close" id="pay_first_close"></a>
        <h3 class="title">开通快捷支付</h3>
        <div class="content">
            <table class="table2" id="pay_first_table">
                <tbody>
                <form action="#" method="post" id="payFirstForm">
                    <tr>
                        <th class="i-block">开通验证码：</th>
                        <td>
                            <div id="payPassword_container" class="alieditContainer clearfix" data-busy="0">
                                <div class="i-block" data-error="i_error">
                                    <div class="i-block six-password">
                                    <input class="i-text sixDigitPassword" id="payPassword_rsainput" type="password" autocomplete="off" required="required" value="" name="payPassword_rsainput" data-role="sixDigitPassword" tabindex="" maxlength="6" minlength="6" aria-required="true">
                                        <div tabindex="0" class="sixDigitPassword-box" style="width: 180px;">
                                        <i style="width: 29px; border-color: transparent;" class=""><b style="visibility: hidden;"></b></i>
                                        <i style="width: 29px;"><b style="visibility: hidden;"></b></i>
                                        <i style="width: 29px;"><b style="visibility: hidden;"></b></i>
                                        <i style="width: 29px;"><b style="visibility: hidden;"></b></i>
                                        <i style="width: 29px;"><b style="visibility: hidden;"></b></i>
                                        <i style="width: 29px;"><b style="visibility: hidden;"></b></i>
                                        <span style="width: 29px; left: 0px; visibility: hidden;" id="cardwrap" data-role="cardwrap"></span>
                                        </div>
                                    </div>
                                    <span class="icon-vali"></span>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th></th>
                        <td><a class="btn-register" onclick="submitFirst();" id="pay_first_btn">确定</a></td>
                    </tr>
                </form>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="overlay layer-big pay_readCon" id="readerContent" style="display: none;">
    <div class="overlay-bg"></div>
    <div class="float-div">
        <h3 class="title1">购票须知</h3>
        <div class="content">
            <div class="one-area">
                <h3 class="title" style="width: 100%">注册观众：</h3>
                <p>
                    1.注册观众必须填写推荐票务代理服务中心推荐码注册（由票务代理中心所属二维码扫描或超级链接点击进入注册页面的邀请码会自动填写）。
                </p>
                <p>
                    2.观众注册必须绑定手机进行手机短信验证。
                </p>
            </div>
            <div class="one-area">
                <h3 class="title" style="width: 100%">观众购票：</h3>
                <p>1.观众注册后选择方便的观赛平台（网站、微信公众号、微信小程序及App），点击观赛，即可选择相应门票进行线上购买，观众权益购票后即时生效。</p>
                <p>2.门票分为A类票（月费5000元）、B类票（月费2000元）、C类票（月费500元）三类，一次购票可享受22个比赛日（比赛日即为沪深两市交易日）对应观众权利。</p>
                <p>3.月票为22个比赛日倒计时，遇沪深两市停盘日即为非比赛日，倒计时暂停！</p>
                <p>4.门票升级：</p>
                <p>观众购C类或B类票后要升级为B类或A类月票，其原票残值核算为升级月票的比赛日加入到升级后月票的比赛日内！（观赛时间即为22个比赛日+原残值核算后比赛日）</p>
                <p>例如：C类票观众看了十个比赛日后升级为A类票，其核算完后他的A类票可观看的比赛日为：23个比赛日</p>
                <p>公式：原票残值= 原月票价值÷22天 ×（22天 - 已观比赛日）升级后比赛日天数（小数点后四舍五入）=原票残值÷（升级月票价值÷22天）</p>
            </div>
            <div class="one-area">
                <h3 class="title" style="width: 100%">观众权益一览表：</h3>
                <table class="pay_read_table" border="1" cellspacing="0">
                    <tr>
                        <th style="width:15%;">服务或权利</th>
                        <th style="width:20%;">A类门票</th>
                        <th style="width:20%;">B类门票</th>
                        <th style="width:20%;">C类门票</th>
                        <th>未购票观众</th>
                    </tr>
                    <tr>
                        <td>行业新闻</td>
                        <td>YES</td>
                        <td>YES</td>
                        <td>YES</td>
                        <td>YES</td>
                    </tr>
                    <tr>
                        <td>场内资讯</td>
                        <td>YES</td>
                        <td>YES</td>
                        <td>YES</td>
                        <td>YES</td>
                    </tr>
                    <tr>
                        <td>花絮报道</td>
                        <td>YES</td>
                        <td>YES</td>
                        <td>YES</td>
                        <td>YES</td>
                    </tr>
                    <tr>
                        <td>大赛总榜排名查询</td>
                        <td>YES</td>
                        <td>YES</td>
                        <td>YES</td>
                        <td>YES</td>
                    </tr>
                    <tr>
                        <td>大赛月榜排名查询</td>
                        <td>YES</td>
                        <td>YES</td>
                        <td>YES</td>
                        <td>YES</td>
                    </tr>
                    <tr>
                        <td>前二十名持仓及持仓变动</td>
                        <td>可观看本平台公布的比赛前20名选手T日实盘赛况；（T日指比赛当日）</td>
                        <td>可观看本平台公布的比赛前20名选手T-1日实盘赛况；（T日指比赛当日）</td>
                        <td>可观看本平台公布的比赛前20名选手T-2日实盘赛况；（T日指比赛当日）</td>
                        <td>NO</td>
                    </tr>
                </table>
                <p style="color: #e33434;">注：1、比赛日当日大赛赛况更新两次，分别为13点和17点，购买A类票的客户可随时看到T日赛况。2、大赛提及所有观赛日和可观看比赛日时间均为沪深交易日，不包含周六日和法定节假日。资产和持仓均为T-1日，策略为T日。</p>
                <p>观赛举例说明：2018年11月15日（T日）A类票可观看11月15日（T日）赛况。B类票仅能看2018年11月14日（T-1日）赛况。C类票仅能看2018年11月13日（T-2日）赛况。</p>
            </div>
            <div class="one-area">
                <p>购票即视为已经完全知晓购买大赛观赛门票所有权益，和所购门票可以观赛的时间规则，该操作是本人完全同意并自愿购买使用。</p>
            </div>
        </div>
        <div class="btn" id="closeReadContent"><a href="javascript:;" id="hasRead">同意购票须知</a></div>
    </div>
</div>
</body>
<script>
    $(function() {

        queryVipsCards();

        getBankCardInfo();

        validata();

        set4space();

        $("#pay_icon_close").click(function(){
            $("#pay_bank_div").hide();
        });

        $("#pay_first_close").click(function(){
            $("#pay_first_div").hide();
        });

        switchTicket();

        focusNextInput();

        queryVipsInfo();

        canSendCardSmsCode();

        $("#pay_list").delegate(".one", "click", function(){
            $(this).siblings().removeClass("on");
            $(this).addClass("on");
            $(this).siblings().find("input[type='radio']").removeAttr("checked");
            $(this).find("input[type='radio']").attr("checked","checked");
        });

        $('#readContentButton').click(function(){
            $('#readerContent').css('display','block');
            $('body,html').animate({
                scrollTop: 1350
            }, 1350);
            bindClose();
        });

        $("#readText").change(function(){
            if($(this).is(":checked")){
                reader = true;
            }
            canPay();
            canPay2();
        });

        checkPayWay();
    });

    var smsCodeFlag = false;
    var payFlag = false;
    var p1 = false;
    var cardSmsCodeFlag = false;
    var reader = false;
    var checkFee = false;

    function canSendSmsCode() {
        valiParams();
        if (smsCodeFlag) {
            $('#sendSmsCode').removeAttr('disabled');
            $('#sendSmsCode').attr('class', 'yzm');
        } else {
            $('#sendSmsCode').attr('disabled', 'disabled');
            $('#sendSmsCode').attr('class', 'yzm-disable');
        }
    }

    function canSendCardSmsCode() {
        if (cardSmsCodeFlag) {
            $('#pay_first_btn').removeAttr('disabled');
            $('#pay_first_btn').attr('class', 'btn-register');
        } else {
            $('#pay_first_btn').attr('disabled', 'disabled');
            $('#pay_first_btn').attr('class', 'btn-register-disable');
        }
    }

    function canPay() {
        valiPay();
        if (payFlag && smsCodeFlag && p1 && reader) {
            $('#pay_zf').removeAttr('disabled');
            $('#pay_zf').attr('class', 'btn-zf');
        } else {
            $('#pay_zf').attr('disabled', 'disabled');
            $('#pay_zf').attr('class', 'btn-zf-disable');
        }
    }
    /**
     * 打开添加银行
     */
    function openAddBank(){
        var ticket = $("#pay_ticket").val();
//        if(ticket==""){
//            layer.alert("请选择观赛券", {
//                icon: 0,
//                skin: 'layui-layer-lan'
//            });
//            return false;
//        }else {
            $("#pay_table .icon-vali").empty();
            $("#pay_bank").text("");
            $("#pay_bank_no").val("");
            $("#cardCode").val("");
            $("#pay_name").val("");
            $("#pay_cardno").val("");

            $("#pay_bank_div").show();

            $('body,html').animate({
                scrollTop: 700
            }, 500);
//        }
    }

    /**
     * 取得银行卡信息
     */
    function getBankCardInfo(){
        $("#pay_bank_no").blur(function(){

           var cardNo = Trim($("#pay_bank_no").val(),"g");
           console.log(Trim(cardNo,"g"));
           var bankInfo = bankCardAttribution(cardNo);
           console.log(bankInfo);

            if(bankInfo!='error') {
                if(bankInfo.cardTypeName!='信用卡') {
                    $("#pay_bank").text(bankInfo.bankName);
                    $("#cardCode").val(bankInfo.bankCode);
                    setTip($(this),"",1);
                }else{
                    setTip($(this),"不支持信用卡",0);
                }
            }else{
                setTip($(this),"错误的银行卡号",0);
            }
        });
    }

    /**
     * 设置4位空格
     */
    function set4space(){
        $('#pay_bank_no').on('keyup', function(e) {

            var c=$(this);
            if(/[^\d]/.test(c.val())){//替换非数字字符
                var temp_amount=c.val().replace(/[^\d]/g,'');
                $(this).val(temp_amount);
            }

            var value=$(this).val().replace(/\s/g,'').replace(/(\d{4})(?=\d)/g,"$1 ");
            $(this).val(value)

        })
    }

    /**
     * 去掉空格
     * @param str
     * @param is_global
     * @returns {XML|void|*|string}
     * @constructor
     */
    function Trim(str,is_global){

        var result;

        result = str.replace(/(^\s+)|(\s+$)/g,"");

        if(is_global.toLowerCase()=="g"){

            result = result.replace(/\s/g,"");

        }

        return result;

    }

    function validata(){
        $("#pay_name").blur(function(){
            var name = Trim($("#pay_name").val(),"g");
            var realname = /^([\u4e00-\u9fa5]{2,8}|[a-zA-Z]{2,16})$/g;

            if(realname.test(name)){
                setTip($(this),"",1);
            }else{
                setTip($(this),"请输入正确的姓名",0);
            }
        });

        $("#pay_cardno").blur(function(){
            var cardno = Trim($("#pay_cardno").val(),"g");
            var isIDCard1 = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;//(15位)
            var isIDCard2 = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;//(18位)

            if(isIDCard1.test(cardno) || isIDCard2.test(cardno)){
                setTip($(this),"",1);
            }else{
                setTip($(this),"请输入正确的身份证",0);
            }

        });
    }

    function addBank(){

//        if(cardSmsCodeFlag) {
            if ($("#pay_table").find(".fail").length <= 0) {
                var payBank = $("#pay_bank").text();
                var cardNo = Trim($("#pay_bank_no").val(), "g");
                var cardCode = Trim($("#cardCode").val(), "g");
                var payName = Trim($("#pay_name").val(), "g");
                var idNo = Trim($("#pay_cardno").val(), "g");
                var bankPhone = $("#pay_phone").val();
                var bankInfo = {
                    "bankName": payBank,
                    "cardNo": cardNo,
                    "cardCode": cardCode,
                    "cardName": payName,
                    "idNo": idNo,
                    "bankPhone": bankPhone
                }

                $.ajax({
                    type: "POST",
                    url: "interface/vipsBankCard/addBankCard.shtml",
                    data: bankInfo,
                    dataType: "json",
                    beforeSend: function (request) {
                        request.setRequestHeader("Authorization", getAuthorization());
                    },
                    success: function (result) {
                        $("#pay_bank_div").hide();
                        layer.alert(result.messageText, {
                            icon: 0,
                            skin: 'layui-layer-lan'
                        });
                        queryVipsCards();
                    }, error: function (result) {

                    }

                });
            }
//        }

    }

    function delBank(cardNo){
        $.ajax({
            type: "GET",
            url: "interface/vipsBankCard/delBankCard.shtml",
            data: {"cardNo":cardNo},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (result) {
                $("#pay_bank_div").hide();
                layer.alert(result.messageText, {
                    icon: 0,
                    skin: 'layui-layer-lan'
                });
                queryVipsCards();
            }, error: function (result) {

            }

        });
    }

    /**
     *
     * @param obj 对象
     * @param msg 提示信息
     * @param s 1-正确 0-错误
     */
    function setTip(obj,msg,s){
        $(obj).siblings(".icon-vali").empty();
        if(s){
            $(obj).siblings(".icon-vali").append("<i class='fas fa-check-circle pass'></i>");
        }else{
            $(obj).siblings(".icon-vali").append("<i class='fas fa-times-circle fail' title='"+msg+"'></i>");
        }
    }

    /**
     * 查询银行卡列表
     */
    function queryVipsCards(){
        $.ajax({
            type: "POST",
            url: "interface/vipsBankCard/list.shtml",
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (result) {
                setCardsData(result);
            }, error: function (result) {

            }

        });
    }

    /**
     * 设置数据
     * @param data
     */
    function setCardsData(data){
        $("#pay_list").empty();
        var html = "";
        for(var i=0; i<data.length; i++) {
            var cardNo = data[i].cardNo;
            cardNo = cardNo.replace(/^.+(.{4})$/g, "******$1");
            html += '<div class="one" data-card="'+data[i].cardNo+'"><p class="radio-style"><input type="radio"/></p>' +
                    '<p class="tit">'+data[i].bankName+'</p><p>'+cardNo+'</p><p>储蓄卡|快捷</p>' +
                    '<p id="icon-bank-del"><i class="far fa-trash-alt del" title="删除" onclick="delBank(\''+data[i].cardNo+'\')"></i></p></div>';
        }
        $("#pay_list").append(html);
        $("#pay_list .one:last-child").addClass("on");
        $("#pay_list .one:last-child").find("input[type='radio']").attr("checked","checked");
        var length = $("#pay_list .one").length;
        if(length<5){
            $("#pay_list").append('<a class="add-btn" id="pay_add_bank" onclick="openAddBank();">添加快捷/网银付款</a>');
        }

        canSendSmsCode();

        canPay();
        canPay2();

    }

    function switchTicket(){
        $(".one-area").click(function(){
            var index = $(".one-area").index(this);
            var levelData = $("#level-data").val();
            var fee = 0;
            if(index==0){
                if(levelData==1) {
                    return false;
                }
                fee = "1";
            }else if(index==1){
                if(levelData<=2 && levelData>0){
                    return false;
                }
                fee = "2";
            }else if(index==2){
                if(levelData<=3 && levelData>0){
                    return false;
                }
                fee = "3";
            }
            $("#pay_ticket").val(fee);

            $(".one-area i").remove();
            $(this).addClass("on");
            $(this).siblings().removeClass("on");
            $(this).prepend('<i class="icon-on"></i>');

            canSendSmsCode();
            canPay2();
        });
    }

    function switchCard(){
//        $("#pay_list").each(function(){
            $(this).delegate(".one", "click", function(){
                $(this).sibling("one").removeClass("on");
                $(this).addClass("on");
            });
//        });
    }

    function focusNextInput(){
        $("#pay_yzm").find(':text').on('keyup', function(e) {

            var c=$(this);
            if(/[^\d]/.test(c.val())){//替换非数字字符
                var temp_amount=c.val().replace(/[^\d{1}]/g,'');
                $(this).val(temp_amount);
            }

//            if(e.keyCode>=48&&e.keyCode<=57){
                /*输入0-9*/
                changeDiv();

            if(e.keyCode=="8") {
                /*退格回删事件*/
                returnDiv();

            }


            payFlag = valiPay();
            if(payFlag){
                var str = "";
                $("#pay_yzm").find(':text').each(function(n){
                    if($(this).val()!=""){
                        str += $(this).val();
                    }
                });
                $("#smsCode").val(str);
                canPay();
            }
        });
    }

    function sendSmsCode(){
        valiParams();
        if(!smsCodeFlag || $('#sendSmsCode').text()!="获取验证码"){
            return false;
        }

        var fee = $("#pay_ticket").val();
        var cardNo = $("#pay_list .on").attr("data-card");
        var data = {
            "fee":fee,
            "smsCode":"",
            "cardNo":cardNo,
            "step":"p1"
        }
        $.ajax({
            type: "POST",
            url: "interface/vipsBankCard/addOrder.shtml",
            dataType: "json",
            data: data,
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (result) {
                if(result.level==1) {
                    if (result.data == "bind") {
                        openFirstyzm();
                    }else {
                        layer.alert(result.messageText, {icon: 0,skin: 'layui-layer-lan'});
                        sessionStorage.setItem("orderNo", result.data);
                        p1 = true;
                    }
                }
            }, error: function (result) {

            }
        });

        $('#sendSmsCode').css({'color':'#5e5e5e','border':'1px solid #5e5e5e'});
        $('#sendSmsCode').attr("href", 'javascript:;');
        settime();
    }

    function pay(){
        if($('#pay_zf').attr('disabled')){
            return false;
        }

        var fee = $("#pay_ticket").val();
        var smsCode = $("#smsCode").val();
        var cardNo = $("#pay_list .on").attr("data-card");
        var orderNo = sessionStorage.getItem("orderNo");
        var data = {
            "fee":fee,
            "smsCode":smsCode,
            "cardNo":cardNo,
            "step":"p2",
            "orderNo": orderNo
        }
        $.ajax({
            type: "POST",
            url: "interface/vipsBankCard/addOrder.shtml",
            dataType: "json",
            data: data,
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
                $('#pay_zf').attr('disabled', 'disabled');
                $('#pay_zf').attr('class', 'btn-zf-disable');
                $('#pay_zf').text('支付中');
            },
            success: function (result) {
                $('#pay_zf').removeAttr('disabled');
                $('#pay_zf').attr('class', 'btn-zf');
                $('#pay_zf').text('确认支付');
                if(result.level==1) {
                    layer.alert(result.messageText, {
                        icon: 0,
                        skin: 'layui-layer-lan'
                    });
                    if (result.messageText == "支付成功") {
//                    queryVipsInfo();
                        window.location.href = "/static/gains/strategy.jsp";
                    }
                }else{
                    layer.alert(result.messageText, {
                        icon: 0,
                        skin: 'layui-layer-lan'
                    });
                }

            }, error: function (result) {
                $('#pay_zf').removeAttr('disabled');
                $('#pay_zf').attr('class', 'btn-zf');
                $('#pay_zf').text('确认支付');
            }

        });
    }

    function valiPay(){
        var num=0;
        $("#pay_yzm").find(':text').each(function(n){
            if($(this).val()==""){
                num++;
            }
        });
        if(num>0){
            return false;
        }else{
            return true;
        }
    }

    function valiParams(){
        var length = $("#pay_list .one").length;
        if(length<0) {
            return false;
        }

        var fee = $("#pay_ticket").val();
        if(fee==0 || fee==""){
            return false;
        }

        smsCodeFlag = true;
    }

    //倒计时
    var countdown = 60;
    var canClick = false;
    var isCountDown = false;
    function settime() {

        if (countdown == 0) {
            $('#sendSmsCode').html('获取验证码');
            $('#sendSmsCode').css({'color':'#e33434','border':'1px solid #e33434'});
            countdown = 60;
            canClick=true;
            isCountDown = false;
            return;
        } else {
            $('#sendSmsCode').html("获取验证码(" + countdown + "s)");
//            smsCodeFlag = false;
            countdown--;
        }
        setTimeout(function() {
                    settime() }
                ,1000)
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
                $("#pay_vip_info #nickName").text(result.nickName);
                var level = result.level;
                $("#level-data").val(level);
                if(level==1){
                    $("#pay_vip_info #level").text('A类');
                    $("#pay_vip_info #level_info").text("前20名选手早盘午盘实盘赛况");
                    $("#pay_vip_info #level").addClass("tag");
                }else if(level==2){
                    $("#pay_vip_info #level").text('B类');
                    $("#pay_vip_info #level_info").text("前20名选手24小时实盘赛况");
                    $("#pay_vip_info #level").addClass("tag");
                }else if(level==3){
                    $("#pay_vip_info #level").text('C类');
                    $("#pay_vip_info #level_info").text("前20名选手48小时实盘赛况");
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

    /**
     * 设置默认选中
     **/
    var paw = $(".smsCode");
    var pawCount=paw.length;
    /*设置第一个输入框默认选中*/
    $(paw[0]).addClass("yzm-highLight");
    paw[0].readOnly=false;
//    paw[0].focus();

    /*定义自动选中下一个输入框事件*/
    var changeDiv = function(){
        for(var i=0;i<pawCount;i++){
            if(paw[i].value.length=="1"){
                if((i+1)<pawCount) {
                    /*处理当前输入框*/
                paw[i].blur();
                $(paw[i]).removeClass("yzm-highLight");
//                paw[i].readOnly = true;

                    /*处理下一个输入框*/
                $(paw[i + 1]).addClass("yzm-highLight");
                paw[i + 1].focus();
                paw[i + 1].readOnly = false;
                }
            }
        }
    };

    /*回删时选中上一个输入框事件*/
    var returnDiv = function(){
        for(var i=0;i<pawCount;i++){
            console.log(i);
            if(paw[i].value.length=="0"){
                if(i>=0) {
                    /*处理当前输入框*/
                    console.log(i);
                    paw[i].blur();
                    $(paw[i]).removeClass("yzm-highLight");
                    paw[i].readOnly = true;

                    /*处理上一个输入框*/
                    $(paw[i - 1]).addClass("yzm-highLight");
                    paw[i - 1].focus();
                    paw[i - 1].readOnly = false;
                    paw[i - 1].value = "";
                    break;
                }
            }
        }
    };


    var payPassword = $("#payPassword_container"),
            _this = payPassword.find('i'),
            k=0,j=0,
            password = '' ,
            _cardwrap = $('#cardwrap');
    //点击隐藏的input密码框,在6个显示的密码框的第一个框显示光标
    payPassword.on('focus',"input[name='payPassword_rsainput']",function(){

        var _this = payPassword.find('i');
        if(payPassword.attr('data-busy') === '0'){
            //在第一个密码框中添加光标样式
            _this.eq(k).addClass("active");
            _cardwrap.css('visibility','visible');
            payPassword.attr('data-busy','1');
        }

    });
    //change时去除输入框的高亮，用户再次输入密码时需再次点击
    payPassword.on('change',"input[name='payPassword_rsainput']",function(){
        _cardwrap.css('visibility','hidden');
        _this.eq(k).removeClass("active");
        payPassword.attr('data-busy','0');
    }).on('blur',"input[name='payPassword_rsainput']",function(){

        _cardwrap.css('visibility','hidden');
        _this.eq(k).removeClass("active");
        payPassword.attr('data-busy','0');

    });

    //使用keyup事件，绑定键盘上的数字按键和backspace按键
    payPassword.on('keyup',"input[name='payPassword_rsainput']",function(e){

        var  e = (e) ? e : window.event;

        //键盘上的数字键按下才可以输入
        if(e.keyCode == 8 || (e.keyCode >= 48 && e.keyCode <= 57) || (e.keyCode >= 96 && e.keyCode <= 105)){
            k = this.value.length;//输入框里面的密码长度
            l = _this.size();//6

            for(;l--;){

                //输入到第几个密码框，第几个密码框就显示高亮和光标（在输入框内有2个数字密码，第三个密码框要显示高亮和光标，之前的显示黑点后面的显示空白，输入和删除都一样）
                if(l === k){
                    _this.eq(l).addClass("active");
                    _this.eq(l).find('b').css('visibility','hidden');

                }else{
                    _this.eq(l).removeClass("active");
                    _this.eq(l).find('b').css('visibility', l < k ? 'visible' : 'hidden');

                }

                if(k === 6){
                    j = 5;
                }else{
                    j = k;
                }
                $('#cardwrap').css('left',j*30+'px');

            }
            if(k==6){
                cardSmsCodeFlag = true;
                canSendCardSmsCode();
                setTip($(".six-password"),"",1);
                console.log(payPassword);
            }else{
                setTip($(".six-password"),"错误的银行卡号",0);
            }
        }else{
            //输入其他字符，直接清空
            var _val = this.value;
            this.value = _val.replace(/\D/g,'');
        }
    });
//
//    function sendCardValidate(){
//        if ($("#pay_table").find(".fail").length <= 0) {
//            var payBank = $("#pay_bank").text();
//            var cardNo = Trim($("#pay_bank_no").val(), "g");
//            var cardCode = Trim($("#cardCode").val(), "g");
//            var payName = Trim($("#pay_name").val(), "g");
//            var idNo = Trim($("#pay_cardno").val(), "g");
//            var bankPhone = $("#pay_phone").val();
//            payBank==""?layer.alert("请输入银行卡号", {icon: 0,skin: 'layui-layer-lan'}):
//                    cardNo==""?layer.alert("请输入银行卡号", {icon: 0,skin: 'layui-layer-lan'}):
//                            cardCode==""?layer.alert("请输入银行卡号", {icon: 0,skin: 'layui-layer-lan'}):
//                                    payName==""?layer.alert("请输入姓名", {icon: 0,skin: 'layui-layer-lan'}):
//                                            idNo==""?layer.alert("请输入身份证", {icon: 0,skin: 'layui-layer-lan'}):
//                                                    idNo==""?layer.alert("请输入身份证", {icon: 0,skin: 'layui-layer-lan'}):
//                                                            bankPhone==""?layer.alert("请输入开户电话", {icon: 0,skin: 'layui-layer-lan'}):sendCardSmsCode();
//            return false;
//        }else{
//            layer.alert("请修改错误信息", {icon: 0,skin: 'layui-layer-lan'})
//        }
//    }
//
//    //倒计时
//    var countdown1 = 60;
//    var canClick1 = false;
//    var isCountDown1 = false;
//    function sendCardSmsCode(){
//        var fee = $("#pay_ticket").val();
//        var cardNo = Trim($("#pay_bank_no").val(), "g");
//        var cardCode = Trim($("#cardCode").val(), "g");
//        var payName = Trim($("#pay_name").val(), "g");
//        var idNo = Trim($("#pay_cardno").val(), "g");
//        var bankPhone = $("#pay_phone").val();
//        var payBank = $("#pay_bank").text();
//        var data = {
//            "fee":fee,
//            "smsCode":"",
//            "cardNo":cardNo,
//            "step":"p1",
//            "cardCode":cardCode,
//            "cardName":payName,
//            "idNo":idNo,
//            "bankName":payBank,
//            "bankPhone":bankPhone
//        }
//        $.ajax({
//            type: "POST",
//            url: "interface/vipsBankCard/sendBankSmsCode.shtml",
//            dataType: "json",
//            data: data,
//            beforeSend: function (request) {
//                request.setRequestHeader("Authorization", getAuthorization());
//            },
//            success: function (result) {
//                if(result.level!=1){
//
//                }
//            }, error: function (result) {
//
//            }
//        });
//
//        $('#sendCardSmsCode').css('color','#5e5e5e');
//        $('#sendCardSmsCode').attr("href", 'javascript:;');
//        settime1();
//    }
//
//    function settime1() {
//        if (countdown1 == 0) {
//            $('#sendCardSmsCode').text('获取验证码');
//            countdown1 = 60;
//            canClick1 = true;
//            isCountDown1 = false;
//            return;
//        } else {
//            $('#sendCardSmsCode').html("获取验证码(" + countdown1 + "s)");
//            countdown1--;
//        }
//        setTimeout(function() {
//                    settime1() }
//                ,1000)
//    }

    /**
     * 打开开通快捷支付验证码
     */
    function openFirstyzm(){
        $("#pay_first_table .icon-vali").empty();

        $("#pay_first_div").show();

        $('body,html').animate({
            scrollTop: 700
        }, 500);
//        }
    }

    function submitFirst(){
        if(cardSmsCodeFlag) {
            var fee = $("#pay_ticket").val();
            var cardNo = $("#pay_list .on").attr("data-card");
            var cardSmsCode = $("#payPassword_rsainput").val();
            var data = {
                "fee":fee,
                "smsCode":cardSmsCode,
                "cardNo":cardNo,
                "step":"p1"
            }
            $.ajax({
                type: "POST",
                url: "interface/vipsBankCard/addOrder.shtml",
                dataType: "json",
                data: data,
                beforeSend: function (request) {
                    request.setRequestHeader("Authorization", getAuthorization());
                    $('#pay_first_btn').attr('disabled', 'disabled');
                    $('#pay_first_btn').attr('class', 'btn-register-disable');
                    $('#pay_first_btn').text('验证中');
                },
                success: function (result) {
                    $('#pay_first_btn').removeAttr('disabled');
                    $('#pay_first_btn').attr('class', 'btn-register');
                    $('#pay_first_btn').text('确定');
                    if (result.level == 1) {
                        if (result.data != "bind") {
                            sessionStorage.setItem("orderNo", result.data);
                            p1 = true;
                            $("#pay_first_div").hide();
                        }else{
                            layer.alert("开通快捷支付验证码错误", {icon: 0,skin: 'layui-layer-lan'});
                        }
                    }else{
                        if (result.data == "bind") {
                            layer.alert("开通快捷支付验证码错误", {icon: 0,skin: 'layui-layer-lan'});
                        }else{
                            layer.alert(result.messageText, {icon: 0,skin: 'layui-layer-lan'});
                        }
                    }
                }, error: function (result) {
                    $('#pay_first_btn').removeAttr('disabled');
                    $('#pay_first_btn').attr('class', 'btn-register');
                    $('#pay_first_btn').text('确定');
                }
            });
        }
    }

    var closeCount=10;
    function bindClose(){
        $('#closeReadContent').unbind("click");
        if (closeCount == 0) {
            $('#hasRead').html("同意观赛须知");
            $('#hasRead').css('color','#dca54b');
            closeCount = 10;
            $('#closeReadContent').click(function(){
                $("#readText").click();
                $('#readerContent').css('display','none');
                $('body,html').animate({
                    scrollTop: 1350
                }, 1350);
            });
            return;
        } else {
            $('#hasRead').css('color','#5e5e5e');
            $('#hasRead').html("同意观赛须知(" + closeCount + "s)");
            closeCount--;
        }
        setTimeout(function() {
                    bindClose() }
                ,1000)
    }

    function checkPayWay(){
        $("#checkWay a").each(function(){
            $(this).click(function(){
                $(this).addClass("on");
                $(this).find("i").addClass("icon-on");
                $(this).siblings().removeClass("on");
                $(this).siblings().find("i").removeClass("icon-on");

                var index = $("#checkWay a").index(this);
                if(index==1){
                    $(".bankPay").hide();
                    $("#pay_zf").hide();
                    $("#wxPayBtn").show();
                }else{
                    $(".bankPay").show();
                    $("#pay_zf").show();
                    $("#wxPayBtn").hide();
                }
            });
        });
    }

    function canPay2() {
        var fee = $("#pay_ticket").val();

        if (fee != 0 && fee != "" && reader) {
            $('#wxPayBtn').removeAttr('disabled');
            $('#wxPayBtn').attr('class', 'btn-zf');

            $("#wxPayBtn").attr("onclick","clickPay2();");
        } else {
            $('#wxPayBtn').attr('disabled', 'disabled');
            $('#wxPayBtn').attr('class', 'btn-zf-disable');

            $("#wxPayBtn").removeAttr("onclick");
        }
    }

    function clickPay2(){
        var fee = $("#pay_ticket").val();

        getUpay(fee);
    }

    function getUpay(fee){
        var order = {
            "t":"1",
            "fee":fee
        }
        $.ajax({
            type: "POST",
            url: "interface/vipsBankCard/uPay.shtml",
            data: order,
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (result) {
                if(result.level==1) {
                    window.location.href = result.data;
                }else{
                    layer.alert(result.messageText, {icon: 0,skin: 'layui-layer-lan'});
                }
            }, error: function (result) {

            }

        });
    }

</script>
</html>
