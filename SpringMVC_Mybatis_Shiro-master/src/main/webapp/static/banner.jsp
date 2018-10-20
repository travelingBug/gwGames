<%@ page pageEncoding="utf-8"%>
<div class="slider-box">
    <ul class="slider-dot"  id="choseLi">
    </ul>
    <ul class="slider-content">
        <li>
            <div class="banner"  id="homeBanner">
                <%--<div class="bottom-link">--%>
                    <%--<div class="content" >--%>
                        <%--<div class="links" id="navigation">--%>
                            <%--<a class="link floatL"  id="toBm"><i class="icon icon-bmcs" ></i>报名参赛</a>--%>
                            <%--<a class="link floatR"  id="toStrategy"><i class="icon icon-gszc" ></i>观赛入口</a>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
            </div>
        </li>
    </ul>
</div>
<!--—————————————————————————— 参赛报名条 ————————————————————————-->
<div class="banner_bottom">
    <div class="bottom_center" style="padding-top:15px;">
        <img src="images/bottom_center-01.png"/>
        <img src="images/bmcs.png" class="img_bmcs" id="toBm" style="cursor: pointer;"/>
        <img src="images/gszc.png" class="img_gszc" id="toStrategy" style="cursor: pointer;"/>

    </div>
</div>

<!-----------------------------  end ----------------------------->
<script>
    $(function() {

        $('#toBm').click(function () {
            window.location.href="/static/signup/signup.jsp";
        });
        $('#toStrategy').click(function () {
            window.location.href="/static/gains/strategy.jsp";
        });
        //banner和广告位设置
        $.ajax({
            type: "POST",
            url: "interface/homeconfig/getData.shtml",
            data: {},
            dataType: "json",
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", getAuthorization());
            },
            success: function (data) {
                if (data.level == 1) {
                    var advert = data.data.advert;
                    if (advert != null && advert.length > 0) {
                        $('#advert_bottom').css("background-image","url("+advert[0].imgPath+")");
                        $('#advert_bottom').click(function () {
                            var url = advert[0].url;
                            if (url != null && url != ''){
                                if (!(url.startWith('http://') || url.startWith('https://'))) {
                                    url = 'http://'+url;
                                }
                                window.location.href = url;
                            }
                        });
                    }

                    var banner = data.data.banner;
                    if (banner != null && banner.length > 0) {
                        for (var i = 0 ; i < banner.length ; i++) {
                            var className = "";
                            var display = 'style="display:none;cursor: pointer;"';
                            if (i == 0) {
                                className = 'class="on"';
                                display = 'style="cursor: pointer;"';
                            }
                            $('#choseLi').append('<li '+className+' name="banner_'+i+'" id="banner_'+i+'"></li>');
                            $('#homeBanner').append('<img id="banner_'+i+'_img" src="'+banner[i].imgPath+'" ' + display+ '/>');
                            $("#banner_"+i).click(function(){
                                if($(this).attr('class') != 'on') {
                                    $('#choseLi').find('li').each(function(v){
                                            $(this).attr('class','');
                                            $('#'+$(this).attr('name')+'_img').css('display','none');
                                    });
                                    $(this).attr('class','on');
                                    $('#'+$(this).attr('name')+'_img').css('display','');
                                }

                            });
                            changBanner('#banner_'+i+'_img',banner[i].url);
//                            var bannerUrl = banner[i].url;
//                            $('#banner_'+i+'_img').click(function () {
//                                var url = bannerUrl;
//                                if (url != null && url != '') {
//                                    if (!(url.startWith('http://') || url.startWith('https://'))) {
//                                        url = 'http://' + url;
//                                    }
//                                    window.location.href = url;
//                                }
//                            });
                        }
//                        $('#homeBanner').slidesjs({
//                            play: {
//                                active: true,
//                                auto: true,
//                                interval: 2000,
//                                swap: true
//                            }
//                        });
                        setInterval("changImg()","3000");
                    }
                }
            },
            error: function (data) {
            }
        });


        document.onmouseover = function(e){
            var el = e.srcElement || e.target;
            if( el.id.startWith('banner_')){
                changeImgFlag = false;
            } else {
                changeImgFlag = true;
            }
        }
    });

    var changeImgFlag = true;
    function changImg(){
        var liLen = $('#choseLi').find('li').length;
        if (liLen && liLen > 0 && changeImgFlag) {
            $('#choseLi').find('li').each(function(x){
                if ($(this).attr('class') == 'on') {
                    //判断是否为最后一个元素
                    if ($(this).attr('name') == 'banner_'+(liLen -1)){ //最后一个元素。则条到第一个
                        $('#choseLi').find('li').each(function(v){
                            if (v ==0) {
                                $(this).attr('class','on');
                                $('#'+$(this).attr('name')+'_img').css('display','');
                            } else {
                                $(this).attr('class','');
                                $('#'+$(this).attr('name')+'_img').css('display','none');
                            }

                        });
                    } else {
                        $(this).attr('class','');
                        $('#'+$(this).attr('name')+'_img').css('display','none');

                        $(this).next().attr('class','on');
                        $('#'+$(this).next().attr('name')+'_img').css('display','');
                    }
                    return false;
                }
            });
        }
    }

    function changBanner(bannerId,url){
        $(bannerId).click(function () {
            if (url != null && url != '') {
                if (!(url.startWith('http://') || url.startWith('https://'))) {
                    url = 'http://' + url;
                }
                window.location.href = url;
            }
        });
    }

</script>