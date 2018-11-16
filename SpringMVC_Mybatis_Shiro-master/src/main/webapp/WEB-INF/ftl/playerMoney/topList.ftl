<!DOCTYPE html>
<html lang="zh-cn">
	<head>
    <#include "../head.ftl" >
		<meta charset="utf-8" />
		<title>选手排行榜列表</title>
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<link href="${basePath}/js/common/bootstrap/3.3.5/css/bootstrap.min.css?${_v}" rel="stylesheet"/>
		<link href="${basePath}/css/common/base.css?${_v}" rel="stylesheet"/>
        <link href="${basePath}/css/gwGame.css?${_v}" rel="stylesheet"/>
		<script  src="${basePath}/js/common/layer/layer.js"></script>
		<script  src="${basePath}/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script  src="${basePath}/js/shiro.demo.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">

        <script >
			so.init(function(){
			    var topType = '${topType}';
			    if (topType == '1') {
			        $('#topType').val('1');
				}
			});


		</script>
	</head>
	<body data-target="#one" data-spy="scroll" id="contentDiv">
		
		<@_top.top 4/>
		<div class="container"  >
			<div class="row">
				<@_left.player 4/>
				<div class="col-md-10">
					<h2>选手排行榜</h2>
					<hr>
					<form method="post" action="${basePath}/playerMoney/topList.shtml" id="formId" class="form-inline">
                        <div class="col-sm-12">
                            <div class="form-group col-sm-4" form-inline>
                                <label for="title">排行榜类型</label>
                                <select name="topType" id="topType" class="form-control">
                                    <option value="0">总收益率排行榜</option>
                                    <option value="1">月收益率排行榜</option>
                                </select>
                            </div>
                            <div class="form-group col-sm-4" form-inline>
                                <label for="account">选手昵称</label>
                                <input type="text" class="form-control"  value="${accountName?default('')}"
                                       name="accountName" id="accountName" placeholder="选手昵称" />
							</div>
                            <div class="form-group col-sm-4">
                                <button type="submit" class="btn btn-primary">查询</button>
                            </div>
						</div>


					<table class="table table-bordered">
						<tr>
                            <th width="40">排名</th>
							<th width="100">昵称</th>
							<th width="100">资金账号</th>
                            <th width="100">总资产</th>
                            <th width="100">本金</th>
                            <th width="100">收益率</th>
                            <th width="100">持仓比</th>
						</tr>
						<#if page?exists && page?size gt 0 >
							<#list page as it>
								<tr>
                                    <td>${it.rank}</td>
									<td>${it.accountName!''}</td>
									<td>${it.account!''}</td>
									<td>${it.totalMoney!''}</td>
									<td>${it.capital!''}</td>
                                    <td>${it.yieldRate!''}</td>
                                    <td>${it.buyForALLRate!''}</td>
								</tr>
							</#list>
						<#else>
							<tr>
								<td class="text-center danger" colspan="7">暂未发现数据</td>
							</tr>
						</#if>
					</table>
					</form>


				</div>
			</div><#--/row-->
		</div>
			
	</body>
</html>