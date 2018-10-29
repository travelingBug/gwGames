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
                        <@shiro.hasAnyRoles name='200001,200002'>
                        <tr>
                            <th>开户二维码/链接</th>
                            <td><i class="fas fa-link" onclick="_queryLink('${userId}');"></i></td>
                        </tr>
                        <tr>
                            <th>报名二维码/链接</th>
                            <td><i class="fas fa-link" _queryPlayerSignup('${userId}')></i></td>
                        </tr>
                        <tr>
                            <th>返佣金额</th>
                            <td><i class="fas fa-yen-sign"></i><span id="dealerMoney"></span></td>
                        </tr>
                        </@shiro.hasAnyRoles>
					</table>

                    <div class="modal fade" id="dealerLinkModal" tabindex="-1" role="dialog" aria-labelledby="dealerLinkModalLabel">
                        <div class="modal-dialog" role="document" style="width:30%;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="dealerLinkModalLabel">开户二维码/链接</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group" style="text-align: center;">
										<div>
											<img src="${qrCodeUrl}${userId}.jpg"/>
                                        </div>
                                        <input type="text" readonly="readonly" value="www.baidu.com" id="link">
                                        <button class="btn btn-blue" id="copyBtn">复制链接</button>
									</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade" id="playerLinkModal" tabindex="-1" role="dialog" aria-labelledby="playerLinkModalLabel">
                        <div class="modal-dialog" role="document" style="width:30%;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="playerLinkModalLabel">报名二维码/链接</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group" style="text-align: center;">
                                        <div>
                                            <img src="${qrCodeUrl}p${userId}.jpg"/>
                                        </div>
                                        <input type="text" readonly="readonly" value="www.baidu.com" id="link1">
                                        <button class="btn btn-blue" id="copyBtn1">复制链接</button>
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
        <@shiro.hasAnyRoles name='200001,200002'>
        _queryMoney('${userId}');
        </@shiro.hasAnyRoles>

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

        const btn1 = document.querySelector('#copyBtn1');
        btn1.addEventListener('click',function() {
            const input1 = document.getElementById("link1");
            input1.select();
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
            url: "${basePath}/dealer/queryLink.shtml",
            data: {userId: userId},
            dataType: "json",
            success: function (data) {
                if (data != null && data.level == 1) {
                    $("#link").val(data.data[0]);
					$("#dealerLinkModal").modal();
                } else {
                    layer.alert(data.messageText, {
                        icon: 0,
                        skin: 'layui-layer-lan'
                    });
                }
            }
        });
	}

    function _queryPlayerSignup(userId){
        $.ajax({
            type: "POST",
            url: "${basePath}/dealer/queryPlayerSignup.shtml",
            data: {userId: userId},
            dataType: "json",
            success: function (data) {
                if (data != null && data.level == 1) {
                    $("#link1").val(data.data[0]);
                    $("#playerLinkModal").modal();
                } else {
                    layer.alert(data.messageText, {
                        icon: 0,
                        skin: 'layui-layer-lan'
                    });
                }
            }
        });
    }

    function _queryMoney(userId){
        $.ajax({
            type: "POST",
            url: "${basePath}/dealer/queryMoney.shtml",
            data: {userId: userId},
            dataType: "json",
            success: function (data) {
                if (data != null) {
                    $("#dealerMoney").text(data);
                } else {
                    $("#dealerMoney").text(0);
                }
            }
        });
    }

</script> 