<%@ page pageEncoding="utf-8"%>
<%--shiro 标签 --%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path = request.getContextPath(); String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; %>
<%@ page   import= "com.sojson.common.IConstant"%>
<%
    String key = IConstant.key;
    String defSessionId = IConstant.defSessionId;
%>
<base href="<%=basePath%>">

<link href="<%=basePath%>/css/all.css" rel="stylesheet" type="text/css" />
<script baseUrl="<%=basePath%>" src="<%=basePath%>/js/common/jquery/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/encrypt/aes.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/encrypt/mode-ecb.js"></script>
<script  src="<%=basePath%>/js/common/layer/layer.js"></script>
<%--<script type="text/javascript" src="<%=basePath%>/js/utils/extend.js"></script>--%>
<script>
    sessionStorage.setItem("key", '<%=key %>');
    sessionStorage.setItem("defSessionId", '<%=defSessionId %>');
    function encrypt(word) {
                var key = CryptoJS.enc.Utf8.parse(sessionStorage.getItem("key"));
                var srcs = CryptoJS.enc.Utf8.parse(word);
                var encrypted = CryptoJS.AES.encrypt(srcs, key, {mode:CryptoJS.mode.ECB,padding: CryptoJS.pad.Pkcs7});
                return encrypted.toString();
            }

     function decrypt(word) {
                var key = CryptoJS.enc.Utf8.parse(sessionStorage.getItem("key"));
                var decrypt = CryptoJS.AES.decrypt(word, key, {mode:CryptoJS.mode.ECB,padding: CryptoJS.pad.Pkcs7});
                return CryptoJS.enc.Utf8.stringify(decrypt).toString();
            }


            function ajaxPost(url,data,success,error){
                if (!success) {
                    success = function (data) {
                        if (data.level == 1) {
                            layer.alert(data.messageText, {
                                icon: 1,
                                skin: 'layui-layer-lan'
                            });
                        } else {
                            layer.alert(data.messageText, {
                                icon: 0,
                                skin: 'layui-layer-lan'
                            });
                        }
                    }
                }
                if (!error) {
                    error = function(){
                        layer.alert('系统错误，请联系管理员！', {
                            icon: 2,
                            skin: 'layui-layer-lan'
                        });
                    }
                }

                $.ajax({
                    type: "POST",
                    url: url,
                    data: data,
                    dataType: "json",
                    beforeSend: function (request) {
                        request.setRequestHeader("Authorization", "1");
                    },
                    success: success,
                    error: error
                });
            }

            function getSessionId(){
                var sessionId = sessionStorage.getItem("sessionId");
                if (!sessionId || sessionId == null || sessionId == '') {
                    sessionId = sessionStorage.getItem("defSessionId");
                }
                return sessionId;
            }

            function getAuthorization(){
                var sessionId = getSessionId();
                var date = new Date().Format("yyyy-MM-dd HH:mm:ss");
                return encrypt(sessionId + "," + date);
            }






    // 对Date的扩展，将 Date 转化为指定格式的String
    // 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
    // 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
    Date.prototype.Format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "H+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }
//    jQuery.extend({
//        "Encrypt": function (word) {
//            var key = CryptoJS.enc.Utf8.parse("tJjwxDz4WF0Sf9JT");
//            var srcs = CryptoJS.enc.Utf8.parse(word);
//            var encrypted = CryptoJS.AES.encrypt(srcs, key, {mode:CryptoJS.mode.ECB,padding: CryptoJS.pad.Pkcs7});
//            return encrypted.toString();
//        },
//        "Decrypt": function (word) {
//            var key = CryptoJS.enc.Utf8.parse("tJjwxDz4WF0Sf9JT");
//            var decrypt = CryptoJS.AES.decrypt(word, key, {mode:CryptoJS.mode.ECB,padding: CryptoJS.pad.Pkcs7});
//            return CryptoJS.enc.Utf8.stringify(decrypt).toString();
//        }
//    });

//    $.Encrypt = function (word) {
//            var key = CryptoJS.enc.Utf8.parse("tJjwxDz4WF0Sf9JT");
//            var srcs = CryptoJS.enc.Utf8.parse(word);
//            var encrypted = CryptoJS.AES.encrypt(srcs, key, {mode:CryptoJS.mode.ECB,padding: CryptoJS.pad.Pkcs7});
//            return encrypted.toString();
//        }
</script>
