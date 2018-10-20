<%@ page pageEncoding="utf-8"%>
<div class="top-bar"></div>
<div class="top-box">
    <div class="content">
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
            <li><a href="/static/rank/ranking.jsp">年度排行榜</a></li>
            <li></li>
            <li><a href="/static/rank/rankMonth.jsp">月度排行榜</a></li>
            <li></li>
            <li><a>APP下载</a></li>
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
        $('#menu_list').find('a').each(function () {
            if ($(this).attr('href') == window.location.pathname) {
             $(this).parent().attr("class",'on');
            }
        });

        if (sessionStorage.getItem("nickName") != null && sessionStorage.getItem("nickName") != '') {
            $('#topHead').append('<a class="introduce" style="font-size: 18px;color:#484848" href="/static/vips/vips_center.jsp">欢迎您，'+sessionStorage.getItem("nickName")+'</a>');
            $('#topHead').append('<a class="introduce" style="font-size: 18px;color:#484848" id="loginOut">[注销]</a>');
            $('#navigation').css('display','none');
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
        } else {
            $('#topHead').append('<a class="introduce" style="font-size: 18px;color:#484848" href="/static/vips/register.jsp?a=1">[登录]</a>');
            $('#topHead').append('|');
            $('#topHead').append('<a class="introduce" style="font-size: 18px;color:#484848" href="/static/vips/register.jsp?a=2">[注册]</a>');
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