<%@ page pageEncoding="utf-8"%>




<div class="float-layer">
    <div class="content">
        <div class="fw-box">
            <a class="icon icon-close" id="closeQQ"></a>
            <div class="btns">
                <a class="btn btn-zxzx" href="tencent://message/?uin=1930621578&Site=http://60.205.189.94&Menu=yes"></a>
                <a class="btn btn-appxz"></a>
                <a class="btn btn-gywm" href="/static/aboutme/aboutme.jsp"></a>
            </div>
        </div>
        <div class="zn-box"   style="display:none;">
            <a class="icon icon-close" id="closeDoor"></a>
            <div class="btns">
                <a class="btn btn-gszc" href="/static/vips/register.jsp"></a>
                <a class="btn btn-bmcs"  href="/static/signup/signup.jsp"></a>
            </div>
        </div>
    </div>
</div>
<script>
    $(function() {


        $('#closeDoor').click(function () {
            $('#closeDoor').parent().css('display','none');
        });
        $('#closeQQ').click(function () {
            $('#closeQQ').parent().css('display','none');
        });

    });
</script>