<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>代理商观众统计列表</title>
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
                        $.post('${basePath}/dealer/exportExcelDealerVip.shtml',data,function(result){
                            if(result && result.level != 1){
                                layer.alert(result.messageText, {
                                    icon: 0,
                                    skin: 'layui-layer-lan'
                                });
                            }else{
                                $("#contentDiv").unmask();
                                window.location.href = '${basePath}/download.shtml?fileOutName='+encodeURI(encodeURI(result.data[0]))+"&filePath="+result.data[1];
                                <#--$.post('${basePath}/download.shtml?fileOutName='+encodeURI(encodeURI(result.data[0]))+"&filePath="+result.data[1],{},function(result){-->
                                    <#--$("#contentDiv").unmask();-->
                                <#--});-->
                            }
                        },'json');
                });
			});





		</script>
	</head>
	<body data-target="#one" data-spy="scroll" id="contentDiv">
		
		<@_top.top 5/>
		<div class="container" >
			<div class="row">
				<@_left.dealer 2/>
				<div class="col-md-10">
					<h2>代理商观众统计列表</h2>
					<hr>
					<form method="post" action="${basePath}/dealer/countDealerList.shtml" id="countForm" class="form-inline">
                        <div class="col-sm-12" style="margin-top: 10px;margin-bottom: 20px;">
                            <div class="form-group  col-sm-4">
                                <span class=""> <#--pull-right -->
                                    <label for="bgnTime">代理商名称</label>
                                    <input type="text"  class="form-control" name="name" id="name" placeholder="代理商名称" value="${name?default('')}" />
                                </span>
                            </div>

                            <div class="form-group col-sm-4" form-inline>
                               <span class=""> <#--pull-right -->
                                   <label for="bgnTime">代理商组名</label>
                                    <input type="text"  class="form-control" name="groupName" id="groupName" placeholder="代理商组名" value="${groupName?default('')}" />
                                </span>
                            </div>


                        </div>
                        <div class="col-sm-12" style="margin-top: 10px;margin-bottom: 20px;">
                            <div class="form-group col-sm-8" form-inline>
                                <label for="bgnTime">时间</label>
                                <input type="text"  class="form-control" name="bgnTime" id="bgnTime" placeholder="开始时间" value="${bgnTime?default('')}" />
                                ~
                                <input type="text"  class="form-control" name="endTime" id="endTime" placeholder="结束时间" value="${endTime?default('')}"/>
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
                            <td colspan="11"><button type="button" id="exportButton" <#if !listData?exists || listData?size lte 0 >disabled="disabled"</#if> class="btn btn-primary">导出</button></td>
                        </tr>
						<tr>
                            <th width="40">序号</th>
                            <th width="80">代理商名称</th>
                            <th width="80">分组名称</th>
                            <th width="80">新增观众总人数</th>
							<th width="80">开通A类观众次数</th>
							<th width="80">开通A类观众金额</th>
							<th width="80">开通B类观众次数</th>
                            <th width="80">开通B类观众金额</th>
                            <th width="80">开通C类观众次数</th>
                            <th width="80">开通C类观众金额</th>
                            <th width="80">开通观众总金额</th>
						</tr>
						<#if listData?exists && listData?size gt 0 >
							<#list listData as it>
								<tr>
                                    <td> ${it_index+1}</td>
									<td>${it.name}</td>
                                    <td>${it.dGroup!''}</td>
                                    <td>${it.vipCount}</td>
                                    <td>${it.vipACount}</td>
                                    <td>${it.vipAMoneyCount?string.currency}</td>
                                    <td>${it.vipBCount}</td>
                                    <td>${it.vipBMoneyCount?string.currency}</td>
                                    <td>${it.vipCCount}</td>
                                    <td>${it.vipCMoneyCount?string.currency}</td>
									<td>${it.vipMoneyCount?string.currency}</td>
								</tr>
							</#list>
						<#else>
							<tr>
								<td class="text-center danger" colspan="11">没有找到代理商数据</td>
							</tr>
						</#if>
					</table>
					</form>

				</div>
			</div><#--/row-->
		</div>
	</body>
</html>