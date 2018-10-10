<%@ page pageEncoding="utf-8"%>
<div class="top-bar"></div>
<div class="top-box">
    <div class="content">
        <div class="logo"></div>
        <div class="right-area" id="topHead">
            <a class="link"><i class="icon icon-weibo"></i>官方微博</a>

        </div>
    </div>
</div>
<div class="header">
    <div class="content">
        <ul class="list1" id="menu_list">
            <li><a href="/static/home.jsp">大赛首页</a></li>
            <li>|</li>
            <li><a href="/static/rule/rule.jsp">赛事规则</a></li>
            <li>|</li>
            <li><a href="/static/rule/bonus.jsp">奖项设置</a></li>
            <li>|</li>
            <li><a href="/static/eventReport/eventReport.jsp">赛事报道</a></li>
            <li>|</li>
            <li><a href="/static/rank/ranking.jsp">比赛排名</a></li>
            <li>|</li>
            <li><a href="/static/rank/rankMonth.jsp">月度冠军</a></li>
            <li>|</li>
            <li><a>APP下载</a></li>
            <li>|</li>
            <li><a>我的账户</a></li>
        </ul>
    </div>
</div>
<div class="slider-box">
    <ul class="slider-dot">
        <li class="on"></li>
        <li></li>
        <li></li>
    </ul>
    <ul class="slider-content">
        <li>
            <div class="banner">
                <img src="images/banner_home_01.png"/>
                <div class="bottom-link">
                    <div class="content">
                        <div class="links" id="navigation">
                            <a class="link floatL"><i class="icon icon-bmcs" href="/static/signup/index.jsp"></i>报名参赛</a>
                            <a class="link floatR"><i class="icon icon-gszc" href="/static/vips/register.jsp"></i>观赛注册</a>
                        </div>
                    </div>
                </div>
            </div>
        </li>
    </ul>
</div>
<script>
    $(function() {
        $('#menu_list').find('a').each(function () {
            if ($(this).attr('href') == window.location.pathname) {
             $(this).parent().attr("class",'on');
            }
        });

        if (sessionStorage.getItem("nickName") != null && sessionStorage.getItem("nickName") != '') {
            $('#topHead').append('<a class="link" >'+sessionStorage.getItem("nickName")+'</a>');
            $('#topHead').append('<a class="link" id="loginOut">[注销]</a>');
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
            $('#topHead').append('<a class="link" href="/static/vips/register.jsp">[登录]</a>');
        }
    });

</script>