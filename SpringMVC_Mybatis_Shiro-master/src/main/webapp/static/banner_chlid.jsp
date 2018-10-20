<%@ page pageEncoding="utf-8"%>
<div class="slider-box">
    <ul class="slider-dot"  id="choseLi">
    </ul>
    <ul class="slider-content">
        <li>
            <div class="banner"  id="homeBanner">
                <img  src="images/banner-child.png"/>
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
                            if (url != null && url != ''){
                                if (!(url.startWith('http://') || url.startWith('https://'))) {
                                    url = 'http://'+url;
                                }
                                window.location.href = url;
                            }
                        });
                    }

                }
            },
            error: function (data) {
            }
        });


    });



</script>