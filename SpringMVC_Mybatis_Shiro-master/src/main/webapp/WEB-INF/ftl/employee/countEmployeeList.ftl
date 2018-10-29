<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>员工会员统计</title>
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
                laydate({
                    elem: '#bgnTime',
                    istime:true,
                    format:'YYYY-MM-DD hh:mm:ss'
                });
                laydate({
                    elem: '#endTime',
                    istime:true,
                    format:'YYYY-MM-DD hh:mm:ss'
                });
				//初始化全选。
				so.checkBoxInit('#checkAll','[check=box]');


                $('#exportButton').click(function(){
                    $("#contentDiv").mask("Excel生中成，请稍后...");
                    var data = $("#countForm").serialize();
                    $.post('${basePath}/dealer/exportEmployee.shtml',data,function(result){
                        if(result && result.level != 1){
                            layer.alert(result.messageText, {
                                icon: 0,
                                skin: 'layui-layer-lan'
                            });
                        }else{
                            $("#contentDiv").unmask();
                            window.location.href = '${basePath}/download.shtml?fileOutName='+encodeURI(encodeURI(result.data[0]))+"&filePath="+result.data[1];
                        }
                    },'json');
                });
			});





		</script>
	</head>
	<body data-target="#one" data-spy="scroll">
		
		<@_top.top 6/>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
			<div class="row">
				<@_left.employee 2/>
				<div class="col-md-10">
					<h2>员工会员统计</h2>
					<hr>
					<form method="post" action="${basePath}/dealer/countEmployeeList.shtml" id="countForm" class="form-inline">
                        <div class="col-sm-12"  style="margin-top: 10px;margin-bottom: 20px;">
                            <div class="form-group col-sm-8" form-inline>
                                <label for="bgnTime">购买时间</label>
                                <input type="text"  class="form-control" name="bgnTime" id="bgnTime" placeholder="开始时间" value="${bgnTime?default('')}" />

                                <input type="text"  class="form-control" name="endTime" id="endTime" placeholder="结束时间" value="${endTime?default('')}" />
                            </div>
                            <div class="form-group  col-sm-4">
                                <span class=""> <#--pull-right -->
                                    <button type="submit" class="btn btn-primary">查询</button>
                                </span>
                            </div>
                        </div>
					<hr>
					<table class="table table-bordered">
                        <tr>
                            <td colspan="8"><button type="button" id="exportButton" <#if !listData?exists || listData?size lte 0 >disabled="disabled"</#if> class="btn btn-primary">导出</button></td>
                        </tr>
						<tr>
                            <th>员工名称</th>
							<th>新增A类会员人数</th>
							<th>新增A类会员金额</th>
							<th>新增B类会员人数</th>
                            <th>新增B类会员金额</th>
                            <th>新增C类会员人数</th>
                            <th>新增C类会员金额</th>
                            <th>新增会员总金额</th>
						</tr>
						<#if listData?exists && listData?size gt 0 >
							<#list listData as it>
								<tr>
									<td>${it.name!''}</td>
                                    <td>${it.vipACount}</td>
                                    <td>${it.vipAMoneyCount}</td>
                                    <td>${it.vipBCount}</td>
                                    <td>${it.vipBMoneyCount}</td>
                                    <td>${it.vipCCount}</td>
                                    <td>${it.vipCMoneyCount}</td>
									<td>${it.vipMoneyCount}</td>
								</tr>
							</#list>
						<#else>
							<tr>
								<td class="text-center danger" colspan="8">没有找到员工数据</td>
							</tr>
						</#if>
					</table>
					</form>

				</div>
			</div><#--/row-->
		</div>
	</body>
</html>