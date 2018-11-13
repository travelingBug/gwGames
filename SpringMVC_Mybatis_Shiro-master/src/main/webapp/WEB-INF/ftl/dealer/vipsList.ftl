<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>观众列表</title>
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


                $("#vip_edit_btn_submit").click(function(){
                    var id = $("#vipId").val();
					var inviteCode = $("#employeeList").val();
					var data = {
						"id":id,
						"inviteCode":inviteCode
					}
                    $.post('${basePath}/dealer/editVipBelong.shtml',data,function(result){
                        if(result && result.level != 1){
                            return layer.msg(result.messageText,so.default),!0;
                        }else{
                            layer.msg('编辑成功！');
                            setTimeout(function(){
                                $('#formId').submit();
                            },1000);
                        }
                    },'json');
                });

			});

			function _editEmplyee(id,inviteCode){
				var data = {
					"inviteCode":inviteCode
				}
                $.post('${basePath}/dealer/queryEmployeeList.shtml',data,function(result){
                    if(result && result.level != 1){
                        return layer.msg("编辑归属员工失败。",so.default),!0;
                    }else{
                        $("#employeeList").empty();
						var employeeList = result.data;
						var selectHtml = "";
						for(var i=0; i<employeeList.length; i++){
							selectHtml += "<option value='"+employeeList[i].inviteNum+"'>"+employeeList[i].name+"</option>";
						}
						$("#employeeList").append(selectHtml);
						$("#vipId").val(id);
                        $('#editEmployeeModal').modal();
                    }
                },'json');
			}

		</script>
	</head>
	<body data-target="#one" data-spy="scroll">
		
		<@_top.top 7/>
		<div class="container" >
			<div class="row">
				<@_left.vips 1/>
				<div class="col-md-10">
					<h2>观众列表</h2>
					<hr>
					<form method="post" action="${basePath}/dealer/vipsList.shtml?parentId=${userId}" id="formId" class="form-inline">
						<div clss="well">
					      <div class="form-group">
					        <input type="text" class="form-control" style="width: 300px;" value="${findContent?default('')}"
					        			name="findContent" id="findContent" placeholder="输入昵称/手机号码">
					      </div>
					     <span class=""> <#--pull-right -->
				         	<button type="submit" class="btn btn-primary">查询</button>
				         </span>
				        </div>
					<hr>
					<table class="table table-bordered">
						<tr>
							<th><input type="checkbox" id="checkAll"/></th>
                            <th class="list_index">序号</th>
							<th>昵称</th>
							<th>观众级别</th>
                            <th>电话号码</th>
							<th>推荐码</th>
							<th>归属员工</th>
                            <th>归属代理商</th>
							<th>创建时间</th>
							<@shiro.hasAnyRoles name='888888,100004,100005,100006,200001,900001'>
							<th>操作</th>
							</@shiro.hasAnyRoles>
						</tr>
						<#if page?exists && page.list?size gt 0 >
							<#list page.list as it>
								<tr>
									<td><input value="${it.id}" check='box' type="checkbox" /></td>
                                    <td>${it_index+1}</td>
									<td>${it.nickName}</td>
                                    <td>${it.level}</td>
                                    <td>${it.phone}</td>
									<td>${it.inviteCode}</td>
									<td>${it.belong!""}</td>
									<td>${it.belong2!""}</td>
									<td>${it.crtTime?string("yyyy-MM-dd HH:mm:ss")}</td>
									<@shiro.hasAnyRoles name='888888,100004,100005,100006,200001,900001'>
									<td>
                                    	<a href="javascript:_editEmplyee('${it.id}','${it.inviteCode}');"><i class="fas fa-edit normal" title="编辑" data-toggle="modal" data-target="#dealerEditModal"></i></a>
                                    </td>
									</@shiro.hasAnyRoles>
								</tr>
							</#list>
						<#else>
							<tr>
								<td class="text-center danger" colspan="10">没有找到观众</td>
							</tr>
						</#if>
					</table>
					<#if page?exists>
                        <div class="pagination pull-left">
                            共${page.totalCount!"0"}条数据
                        </div>
						<div class="pagination pull-right">
							${page.pageHtml}
						</div>
					</#if>
					<#--</form>-->
				</div>

				<!--编辑归属员工modal-->
				<div class="modal fade" id="editEmployeeModal" tabindex="-1" role="dialog" aria-labelledby="editEmployeeModalLabel">
					<div class="modal-dialog" role="document" style="width:30%;">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
								<h4 class="modal-title" id="editEmployeeModalLabel">编辑归属员工</h4>
							</div>
							<div class="modal-body">
								<div class="form-group">
									<form id="vip_edit_form" action="${basePath}/dealer/editVipBelong.shtml" method="post">
										<input type="hidden" name="id" id="vipId">
										<label for="dealer_name">归属员工</label>
										<select name="inviteCode" id="employeeList" class="form-control">
										</select>
									</form>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
								<button type="button" id="vip_edit_btn_submit" class="btn btn-primary" data-dismiss="modal"><i class="fas fa-save normal"></i>&nbsp;保存</button>
							</div>
						</div>
					</div>
				</div>
			</div><#--/row-->
		</div>
	</body>
</html>