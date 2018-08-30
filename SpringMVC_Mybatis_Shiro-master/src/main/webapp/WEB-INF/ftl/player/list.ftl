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
			});
			<@shiro.hasPermission name="/player/auditById.shtml">
            //根据ID数组，删除
            function _audit(id, status){
                var text = status?'通过':'不通过';
                var index = layer.confirm("确定审核"+text+"这个用户？",function(){
                    var load = layer.load();
                    $.post('${basePath}/player/auditById.shtml',{auditFlag:status,id:id},function(result){
                        layer.close(load);
                        if(result && result.status != 200){
                            return layer.msg(result.message,so.default),!0;
                        }else{
                            layer.msg(text +'成功');
                            setTimeout(function(){
                                $('#playerForm').submit();
                            },1000);
                        }
                    },'json');
                    layer.close(index);
                });
            }
			</@shiro.hasPermission>

		</script>
	</head>
	<body data-target="#one" data-spy="scroll">
		
		<@_top.top 4/>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
			<div class="row">
				<@_left.player 1/>
				<div class="col-md-10">
					<h2>参赛人员列表</h2>
					<hr>
					<form method="post" action="" id="playerForm" class="form-inline">
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
										<@shiro.hasPermission name="/player/auditById.shtml">
											<#if it.auditFlag==0>
                                            	<a href="javascript:_audit('${it.id}','1');"><i class="fas fa-check-circle pass"></i></a>
											</#if>
										</@shiro.hasPermission>
										<@shiro.hasPermission name="/player/auditById.shtml">
											<#if it.auditFlag==0>
                                            	<a href="javascript:_audit('${it.id}','2');"><i class="fas fa-times-circle fail"></i></a>
											</#if>
										</@shiro.hasPermission>
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
				</div>
			</div><#--/row-->
		</div>
			
	</body>
</html>