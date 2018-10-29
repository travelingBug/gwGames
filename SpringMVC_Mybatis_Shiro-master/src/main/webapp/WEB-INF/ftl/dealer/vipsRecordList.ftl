<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>购票明细</title>
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
		<script>
			so.init(function(){
				//初始化全选。
				so.checkBoxInit('#checkAll','[check=box]');
			});

		</script>
	</head>
	<body data-target="#one" data-spy="scroll">
		
		<@_top.top 7/>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
			<div class="row">
				<@_left.vips 2/>
				<div class="col-md-10">
					<h2>购票明细</h2>
					<hr>
					<form method="post" action="${basePath}/dealer/vipsRecordList.shtml?userId=${userId}" id="formId" class="form-inline">
						<div clss="well">
					      <div class="form-group">
					        <#--<input type="text" class="form-control" style="width: 300px;" value="${findContent?default('')}"-->
					        			<#--name="findContent" id="findContent" placeholder="输入昵称">-->
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
							<th>购买月票类型</th>
                            <th>金额</th>
                            <th>购买时间</th>
						</tr>
						<#if page?exists && page.list?size gt 0 >
							<#list page.list as it>
								<tr>
									<td><input value="${it.id}" check='box' type="checkbox" /></td>
									<td>${it.nickname}</td>
									<td>
										<#if it.level==0>
                                            未充值会员
										<#elseif it.level==1>
                                            A类会员
										<#elseif it.level==2>
                                            B类会员
										<#elseif it.level==3>
                                            C类会员
										</#if>
									</td>
                                    <td>${it.amount}</td>
									<td>${it.crtTime?string("yyyy-MM-dd HH:mm:ss")}</td>
								</tr>
							</#list>
						<#else>
							<tr>
								<td class="text-center danger" colspan="5">没有找到购票明细</td>
							</tr>
						</#if>
					</table>
					<#if page?exists>
						<div class="pagination pull-right">
							${page.pageHtml}
						</div>
					</#if>
					<#--</form>-->
				</div>
			</div><#--/row-->
		</div>
	</body>
</html>