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

				<#--$("#gainsInfo_btn_submit").click(function(){-->
					<#--var id = $("#gainsInfo_edit_id").val();-->
					<#--var accountName = $("#player_accountName").val();-->
                    <#--$.post('${basePath}/player/editPlayer.shtml',{accountName:accountName,id:id},function(result){-->
                        <#--if(result && result.level != 1){-->
                            <#--return layer.msg(result.messageText,so.default),!0;-->
                        <#--}else{-->
                            <#--layer.msg('编辑成功！');-->
                            <#--setTimeout(function(){-->
                                <#--$('#playerForm').submit();-->
                            <#--},1000);-->
                        <#--}-->
                    <#--},'json');-->
				<#--});-->
			});

            <#--//根据ID数组，删除-->
            <#--function _audit(id, status){-->
                <#--var text = status==1?'通过':'不通过';-->
                <#--var index = layer.confirm("确定"+text+"当前选手？",function(){-->
                    <#--var load = layer.load();-->
                    <#--$.post('${basePath}/player/auditById.shtml',{auditFlag:status,id:id},function(result){-->
                        <#--layer.close(load);-->
                        <#--if(result && result.level != 1){-->
                            <#--return layer.msg(result.messageText,so.default),!0;-->
                        <#--}else{-->
                            <#--layer.msg('审核成功！');-->
                            <#--setTimeout(function(){-->
                                <#--$('#playerForm').submit();-->
                            <#--},1000);-->
                        <#--}-->
                    <#--},'json');-->
                    <#--layer.close(index);-->
                <#--});-->
            <#--}-->

			function _update(id){
				$("#gainsInfo_edit_id").val(id);
			}

		</script>
	</head>
	<body data-target="#one" data-spy="scroll">
		
		<@_top.top 4/>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
			<div class="row">
				<@_left.player 1/>
				<div class="col-md-10">
					<h2>参赛选手数据表</h2>
					<hr>
					<form method="post" action="${basePath}/gainsInfo/list.shtml" id="playerForm" class="form-inline">
						<div clss="well">
					      <div class="form-group">
					        身份证：<input type="text" class="form-control" style="width: 300px;" value="${idCard?default('')}"
					        			name="idCard" id="idCard" placeholder="输入身份证号" />
							<input type="text" class="form-control" style="width: 300px;" value="${sharesCode?default('')}"
                                     name="sharesCode" id="sharesCode" placeholder="输入股票代码" />
                          </div>
                            <div class="form-group">
                                <input type="text" class="form-control" style="width: 300px;" value="${sharesName?default('')}"
                                       name="sharesName" id="sharesName" placeholder="输入股票名称" />
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
                            <th>交易时间</th>
							<th>股票代码</th>
							<th>股票名称</th>
							<th>买卖标致</th>
                            <th>成交量</th>
                            <th>成交价格</th>
                            <th>总资产</th>
                            <th>操作</th>
						</tr>
						<#if page?exists && page.list?size gt 0 >
							<#list page.list as it>
								<tr>
									<td><input value="${it.id}" check='box' type="checkbox" /></td>
									<td>${it.accountName}</td>
									<td>${it.name}</td>
									<td>${it.idCard}</td>
									<td>${it.businessTimeStr}</td>
                                    <td>${it.sharesCode}</td>
                                    <td>${it.sharesName}</td>
									<td>
										<#if it.businessFlag==0>
											买入
										<#elseif it.businessFlag==1>
											卖出
										</#if>
									</td>
                                    <td>${it.volume}</td>
                                    <td>${it.price}</td>
                                    <td>${it.totalMoney}</td>
									<td>
										<#--<@shiro.hasPermission name="/gainsInfo/updateById.shtml">-->
											<a href="javascript:_update('${it.id}');"><i class="fas fa-edit normal" title="编辑"></i></a>
										<#--</@shiro.hasPermission>-->
										<#--<@shiro.hasPermission name="/gainsInfo/delById.shtml">-->
                                            	<#--<a href="javascript:_del('${it.id}');"><i class="glyphicon glyphicon-remove" title="不通过"></i></a>-->
										<#--</@shiro.hasPermission>-->
									</td>
								</tr>
							</#list>
						<#else>
							<tr>
								<td class="text-center danger" colspan="6">暂未发现数据</td>
							</tr>
						</#if>
					</table>
					<#if page?exists>
						<div class="pagination pull-right">
							${page.pageHtml}
						</div>
					</#if>
					</form>
                    <div class="modal fade" id="gainsInfoEditModal" tabindex="-1" role="dialog" aria-labelledby="gainsInfoEditModalLabel">
                        <div class="modal-dialog" role="document" style="width:30%;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="gainsInfoEditModalLabel">编辑</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
										<input type="hidden" name="id" id="gainsInfo_edit_id">
                                        <label for="player_accountName">昵称</label>
                                        <input type="text" name="accountName" class="form-control" id="player_accountName" placeholder="昵称" readonly="readonly">

                                        <label for="player_accountName">姓名</label>
                                        <input type="text" name="name" class="form-control" id="player_name" placeholder="姓名" readonly="readonly">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                                    <button type="button" id="gainsInfo_btn_submit" class="btn btn-primary" data-dismiss="modal"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                                </div>
                            </div>
                        </div>
                    </div>
				</div>
			</div><#--/row-->
		</div>
			
	</body>
</html>