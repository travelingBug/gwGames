<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>${token.nickname} —个人中心</title>
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<link   rel="icon" href="https://open.sojson.com/favicon.ico" type="image/x-icon" />
		<link   rel="shortcut icon" href="https://open.sojson.com/favicon.ico" />
		<link href="${basePath}/js/common/bootstrap/3.3.5/css/bootstrap.min.css?${_v}" rel="stylesheet"/>
		<link href="${basePath}/css/common/base.css?${_v}" rel="stylesheet"/>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
		<script  src="http://open.sojson.com/common/jquery/jquery1.8.3.min.js"></script>
		<script  src="${basePath}/js/common/layer/layer.js"></script>
		<script  src="${basePath}/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	</head>
	<body data-target="#one" data-spy="scroll">
		<@_top.top 1/>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
			<div class="row">
				<@_left.user 1/>
				<div class="col-md-10">
					<h2>个人资料</h2>
					<hr>
					<table class="table table-bordered">
						<tr>
							<th>昵称</th>
							<td>${token.nickname?default('未设置')}</td>
						</tr>
						<tr>
							<th>Email/帐号</th>
							<td>${token.email?default('未设置')}</td>
						</tr>
						<tr>
							<th>创建时间</th>
							<td>${token.createTime?string('yyyy-MM-dd HH:mm')}</td>
						</tr>
						<tr>
							<th>最后登录时间</th>
							<td>${token.lastLoginTime?string('yyyy-MM-dd HH:mm')}</td>
						</tr>
						<
                        <tr>
                            <th>分享</th>
                            <td><i class="fas fa-link" onclick="_queryLink('${userId}');"></i></td>
                        </tr>
					</table>

                    <div class="modal fade" id="dealerLinkModal" tabindex="-1" role="dialog" aria-labelledby="dealerLinkModalLabel">
                        <div class="modal-dialog" role="document" style="width:30%;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="dealerLinkModalLabel">分享</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group" style="text-align: center;">
                                        <input type="text" readonly="readonly" value="www.baidu.com" id="link">
                                        <button class="btn btn-blue" id="copyBtn">复制链接</button>
									</div>
                                </div>
                            </div>
                        </div>
                    </div>
				</div>
			</div>
			<#--/row-->
		</div>
			
	</body>
</html>

<script>

    $(function(){

        const btn = document.querySelector('#copyBtn');
        btn.addEventListener('click',function() {
			const input = document.getElementById("link");
			input.select();
            try{
                if(document.execCommand('copy', false, null)){
                    //success info
                    console.log('复制成功');
                } else{
                    //fail info
                }
            } catch(err){
                //fail info
            }
		});

	});

	function _queryLink(userId){
        $.ajax({
            type: "POST",
            url: "interface/vips/validPhone.shtml",
            data: {userId: userId},
            dataType: "json",
            success: function (data) {
                if (data != null && data.length > 0) {
                    layer.alert('电话号码已被使用', {
                        icon: 0,
                        skin: 'layui-layer-lan'
                    });
                    canClick=false;
                    $('#sendVerfiCode').css('color','#5e5e5e');
                    $('#sendVerfiCode').attr("href", 'javascript:;');
                } else {
                    $('#sendVerfiCode').css('color','blue');
                    canClick=true;
                    telPhoneFlag=true;
                    canSubmit();

                }
            }
        });
	}
</script> 