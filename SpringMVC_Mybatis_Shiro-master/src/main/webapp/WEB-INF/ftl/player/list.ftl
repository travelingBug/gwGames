<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>参赛人员列表</title>
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<link   rel="icon" href="https://open.sojson.com/favicon.ico" type="image/x-icon" />
		<link   rel="shortcut icon" href="https://open.sojson.com/favicon.ico" />
		<link href="${basePath}/js/common/bootstrap/3.3.5/css/bootstrap.min.css?${_v}" rel="stylesheet"/>
		<link href="${basePath}/css/common/base.css?${_v}" rel="stylesheet"/>
        <link href="${basePath}/css/gwGame.css?${_v}" rel="stylesheet"/>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
		<script  src="http://open.sojson.com/common/jquery/jquery1.8.3.min.js"></script>
		<script  src="${basePath}/js/common/layer/layer.js"></script>
		<script  src="${basePath}/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script  src="${basePath}/js/shiro.demo.js"></script>
		<script >
			so.init(function(){
				//初始化全选。
				so.checkBoxInit('#checkAll','[check=box]');

				$("#player_btn_submit").click(function(){
					var id = $("#player_edit_id").val();
					var accountName = $("#player_accountName").val();
                    $.post('${basePath}/player/editPlayer.shtml',{accountName:accountName,id:id},function(result){
                        if(result && result.level != 1){
                            return layer.msg(result.messageText,so.default),!0;
                        }else{
                            layer.msg('编辑成功！');
                            setTimeout(function(){
                                $('#playerForm').submit();
                            },1000);
                        }
                    },'json');
				});
			});

			<@shiro.hasPermission name="/player/auditById.shtml">
            //根据ID数组，删除
            function _audit(id, status){
                var text = status==1?'通过':'不通过';
                var index = layer.confirm("确定"+text+"当前选手？",function(){
                    var load = layer.load();
                    $.post('${basePath}/player/auditById.shtml',{auditFlag:status,id:id},function(result){
                        layer.close(load);
                        if(result && result.level != 1){
                            return layer.msg(result.messageText,so.default),!0;
                        }else{
                            layer.msg('审核成功！');
                            setTimeout(function(){
                                $('#playerForm').submit();
                            },1000);
                        }
                    },'json');
                    layer.close(index);
                });
            }
			</@shiro.hasPermission>

			function _edit(id, name){
				$("#player_edit_id").val(id);
                $("#player_accountName").val(name);
			}

		</script>
	</head>
	<body data-target="#one" data-spy="scroll">
		
		<@_top.top 4/>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
			<div class="row">
				<@_left.player 1/>
				<div class="col-md-10">
					<h2>选手列表</h2>
					<hr>
					<form method="post" action="${basePath}/player/list.shtml" id="playerForm" class="form-inline">
						<div clss="well">
					      <div class="form-group">
					        <input type="text" class="form-control" style="width: 300px;" value="${findContent?default('')}" 
					        			name="findContent" id="findContent" placeholder="输入昵称 / 帐号">
					      </div>
					     <span class=""> <#--pull-right -->
				         	<button type="submit" class="btn btn-primary">查询</button>
				         </span>    
				        </div>
					<hr>
					<table class="table table-bordered">
						<tr>
							<th><input type="checkbox" id="checkAll"/></th>
							<th>昵称</th>
							<th>姓名</th>
							<th>身份证</th>
							<th>手机号</th>
							<th>审核状态</th>
							<th>操作</th>
						</tr>
						<#if page?exists && page.list?size gt 0 >
							<#list page.list as it>
								<tr>
									<td><input value="${it.id}" check='box' type="checkbox" /></td>
									<td>${it.accountName}</td>
									<td>${it.name}</td>
									<td>${it.idCard}</td>
									<td>${it.telPhone}</td>
									<td>
										<#if it.auditFlag==0>
											待审核
										<#elseif it.auditFlag==1>
											通过
										<#elseif it.auditFlag==2>
											未通过
										</#if>
									</td>
									<td>
										<@shiro.hasPermission name="/player/auditById.shtml">
											<#if it.auditFlag==0>
                                            	<a href="javascript:_audit('${it.id}','1');"><i class="fas fa-check-circle pass" title="通过"></i></a>
											</#if>
										</@shiro.hasPermission>
										<@shiro.hasPermission name="/player/auditById.shtml">
											<#if it.auditFlag==0>
                                            	<a href="javascript:_audit('${it.id}','2');"><i class="fas fa-times-circle fail" title="不通过"></i></a>
											</#if>
										</@shiro.hasPermission>
                                        <a href="javascript:_edit('${it.id}', '${it.accountName}');"><i class="fas fa-edit normal" title="编辑" data-toggle="modal" data-target="#playerEditModal"></i></a>
									</td>
								</tr>
							</#list>
						<#else>
							<tr>
								<td class="text-center danger" colspan="6">没有找到参赛人员</td>
							</tr>
						</#if>
					</table>
					<#if page?exists>
						<div class="pagination pull-right">
							${page.pageHtml}
						</div>
					</#if>
					</form>
                    <div class="modal fade" id="playerEditModal" tabindex="-1" role="dialog" aria-labelledby="playerEditModalLabel">
                        <div class="modal-dialog" role="document" style="width:30%;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="playerEditModalLabel">编辑</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
										<input type="hidden" name="id" id="player_edit_id">
                                        <label for="player_accountName">昵称</label>
                                        <input type="text" name="accountName" class="form-control" id="player_accountName" placeholder="昵称">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                                    <button type="button" id="player_btn_submit" class="btn btn-primary" data-dismiss="modal"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                                </div>
                            </div>
                        </div>
                    </div>
				</div>
			</div><#--/row-->
		</div>
			
	</body>
</html>