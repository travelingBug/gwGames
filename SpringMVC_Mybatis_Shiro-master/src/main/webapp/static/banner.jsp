<div class="slider-box">
    <ul class="slider-dot"  id="choseLi">
    </ul>
    <ul class="slider-content">
        <li>
            <div class="banner"  id="homeBanner">
                <div class="bottom-link">
                    <div class="content" >
                        <div class="links" id="navigation">
                            <a class="link floatL"><i class="icon icon-bmcs" href="/static/signup/index.jsp"></i>报名参赛</a>
                            <a class="link floatR"><i class="icon icon-gszc" href="/static/vips/register.jsp?a=2"></i>观赛注册</a>
                        </div>
                    </div>
                </div>
            </div>
        </li>
    </ul>
</div>
<script>
    $(function() {


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
                            if (!(url.startWith('http://') || url.startWith('https://'))) {
                                url = 'http://'+url;
                            }
                            window.location.href = url;
                        });
                    }

                    var banner = data.data.banner;
                    if (banner != null && banner.length > 0) {
                        for (var i = 0 ; i < banner.length ; i++) {
                            var className = "";
                            var display = 'style="display:none;"';
                            if (i == 0) {
                                className = 'class="on"';
                                display = "";
                            }
                            $('#choseLi').append('<li '+className+' name="banner_'+i+'"></li>');
                            $('#homeBanner').prepend('<img id="banner_'+i+'_img" src="'+banner[i].imgPath+'" ' + display+ '/>');
                            $('#banner_'+i+'_img').click(function () {
                                var url = banner[0].url;
                                if (!(url.startWith('http://') || url.startWith('https://'))) {
                                    url = 'http://'+url;
                                }
                                window.location.href = url;
                            });
                        }
                        setInterval("changImg()","4000");
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
</script>