<%@ page pageEncoding="utf-8"%>
<style>
    .top-box .content .logo1 {
        background:url(images/logo-xhbs.png) no-repeat;
        background-size: 70%;
        width: 421px;
        height: 49px;
        float: left;
        margin-left: -50px;
        margin-bottom: 20px;
        /*filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='http://60.205.189.94/images/logo.png',sizingMethod='scale');*/
    }
</style>
<div class="top-box">
    <div class="content">
        <%--<div class="logo1" id="topLogo1" style="cursor: pointer;"></div>--%>
        <div class="logo" id="topLogo" style="cursor: pointer;"></div>
        <div class="right-area" id="topHead">
            <%--<a class="link"><i class="icon icon-weibo"></i>官方微博</a>--%>

        </div>
    </div>
</div>
<div class="header">
    <div class="content">
        <ul class="list1" id="menu_list">
            <li><a href="/static/home.jsp">大赛首页</a></li>
            <li></li>
            <li><a href="/static/rule/rule.jsp">赛事规则</a></li>
            <li></li>
            <li><a href="/static/rule/bonus.jsp">奖项设置</a></li>
            <li></li>
            <li><a href="/static/eventReport/eventReport.jsp">赛事报道</a></li>
            <li></li>
            <li><a href="/static/rank/ranking.jsp">年度排行</a></li>
            <li></li>
            <li><a href="/static/rank/rankMonth.jsp">月度排行</a></li>
            <li></li>
            <%--<li><a href="/static/app/download.jsp">APP下载</a></li>--%>
            <li><a style="color: #e6e6e6;">APP下载</a></li>
            <li></li>
            <li><a href="/static/aboutme/aboutme.jsp">关于我们</a></li>
            <li></li>
            <li><a href="/static/vips/vips_center.jsp">我的特权</a></li>
        </ul>
    </div>
</div>
<script>
    $(function() {

        $('#topLogo').click(function () {
            window.location.href="/static/home.jsp";
        });
//        $('#topLogo1').click(function () {
//            window.location.href="/static/home.jsp";
//        });

        $('#menu_list').find('a').each(function () {
            if ($(this).attr('href') == window.location.pathname) {
             $(this).parent().attr("class",'on');
            }
        });

        if (sessionStorage.getItem("nickName") != null && sessionStorage.getItem("nickName") != '') {
            $('#topHead').append('<a style="font-size: 18px;color:#484848;font-family:"微软雅黑";" href="/static/vips/vips_center.jsp">欢迎您，'+sessionStorage.getItem("nickName")+'</a>');
            $('#topHead').append('&nbsp;&nbsp; <a  style="font-size: 18px;color:#484848;font-family:"微软雅黑";" id="loginOut">[注销]</a>');
            $('#topHead').append('&nbsp;&nbsp; <a  style="font-size: 18px;color:#484848;font-family:"微软雅黑";" id="changePass">[修改密码]</a>');
//            $('#navigation').css('display','none');
            $('#loginOut').click(function(){
                $.ajax({
                    type: "POST",
                    url: "interface/vips/loginOut.shtml",
                    data: {},
                    dataType: "json",
                    beforeSend: function(request) {
                        request.setRequestHeader("Authorization", getAuthorization());

                    },
                    success: function(data) {
                        putTokenToDef();
                        window.location.href="/static/home.jsp";
                    },
                    error: function(data) {
                        putTokenToDef();
                    }
                });
            });

            $('#changePass').click(function(){
                window.location.href="/static/vips/changePass.jsp";

//                $.ajax({
//                    type: "POST",
//                    url: "interface/vips/editVips.shtml",
//                    data: {},
//                    dataType: "json",
//                    beforeSend: function(request) {
//                        request.setRequestHeader("Authorization", getAuthorization());
//
//                    },
//                    success: function(data) {
//                        putTokenToDef();
//                        window.location.href="/static/vips/vips_center.jsp";
//                    },
//                    error: function(data) {
//                        putTokenToDef();
//                    }
//                });
            });

        } else {
            $('#topHead').append('<a style="font-size: 18px;color:#484848;font-family:"微软雅黑";" href="/static/vips/register.jsp?a=1"><i class="fas fa-user"></i>登录</a>');
            $('#topHead').append('&nbsp;&nbsp; ');
            $('#topHead').append('<a  style="font-size: 18px;color:#484848;font-family:"微软雅黑";" href="/static/vips/register.jsp?a=2"><i class="fas fa-user-plus"></i>注册</a>');
        }




    });

    String.prototype.startWith=function(s){
        if(s==null||s==""||this.length==0||s.length>this.length)
            return false;
        if(this.substr(0,s.length)==s)
            return true;
        else
            return false;
        return true;
    }

</script>