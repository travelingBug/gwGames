<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>员工列表</title>
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

				$("#employee_edit_btn_submit").click(function(){
					var data = $("#employee_edit_form").serialize();
                    $.post('${basePath}/dealer/editDealer.shtml',data,function(result){
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

                $("#employee_add_btn_submit").click(function(){
					var data = $("#form1").serialize();
					var loginName = $("#employee_add_loginName").val();
					var name = $("#employee_add_name").val();
					var phone = $("#employee_add_phone").val();
					if(loginName==""){
                        layer.msg("登录账号不能为空",so.default);
						return false;
					}
                    if(name==""){
                        layer.msg("姓名不能为空",so.default);
                        return false;
                    }
                    if(phone==""){
                        layer.msg("手机号码不能为空",so.default);
                        return false;
                    }

                    $.post('${basePath}/dealer/addDealer.shtml',
							data,
							function(result){
                        if(result && result.level != 1){
                            return layer.msg(result.messageText,so.default),!0;
                        }else{
                            layer.msg('新增成功！');
                            setTimeout(function(){
                                $('#formId').submit();
                            },1000);
                        }
                    },'json');
                });

				<@shiro.hasAnyRoles name='888888,100004,100005,100006'>
                    queryDealer(1);
				</@shiro.hasAnyRoles>

			});

			function _edit(id, name, phone, address, dGroup){
				$("#employee_edit_id").val(id);
                $("#employee_edit_name").val(name);
                $("#employee_edit_phone").val(phone);
                $("#employee_edit_address").val(address);
                $("#employee_edit_group").val(dGroup);

			}

			function _add(){
				$('#employeeAddModal .form-control').val("");
                queryDealer(2);
                $('#employeeAddModal').modal();
			}

			<@shiro.hasPermission name="/dealer/forbidUserById.shtml">
            /*
            *激活 | 禁止用户登录
            */
            function forbidUserById(status,id){
                var text = status?'激活':'禁止';
                var index = layer.confirm("确定"+text+"这个用户？",function(){
                    var load = layer.load();
                    $.post('${basePath}/dealer/forbidUserById.shtml',{status:status,id:id},function(result){
                        layer.close(load);
                        if(result && result.status != 200){
                            return layer.msg(result.message,so.default),!0;
                        }else{
                            layer.msg(text +'成功');
                            setTimeout(function(){
                                $('#formId').submit();
                            },1000);
                        }
                    },'json');
                    layer.close(index);
                });
            }
			</@shiro.hasPermission>

			var val3 = '${parentId!""}';
			function queryDealer(a){
                $.post('${basePath}/dealer/queryDealerList.shtml',null,function(result){
                    if(result && result.level != 1){

                    }else{
                        var dealerList = result.data;
                        var selectHtml = "<option value=''>全部</option>";
                        for (var i = 0; i < dealerList.length; i++) {
                            selectHtml += "<option value='" + dealerList[i].userId + "'>" + dealerList[i].name + "</option>";
                        }
						if(a==1) {
                            $("#dealerList").empty();
                            $("#dealerList").append(selectHtml);
							$("#dealerList").val(val3);
                        }else if(a==2){
                            $("#dealerAddList").empty();
                            $("#dealerAddList").append(selectHtml);
						}
                    }
                },'json');
			}

		</script>
	</head>
	<body data-target="#one" data-spy="scroll">
		
		<@_top.top 6/>
		<div class="container" >
			<div class="row">
				<@_left.employee 1/>
				<div class="col-md-10">
					<h2>员工列表</h2>
					<hr>
					<form method="post" action="${basePath}/dealer/employeeList.shtml?parentId=${userId}" id="formId" class="form-inline">
						<div clss="well">
					      <div class="form-group">
					        <input type="text" class="form-control" style="width: 300px;" value="${findContent?default('')}" 
					        			name="findContent" id="findContent" placeholder="输入名称">
					      </div>
							<div class="form-group">
								<input type="text" class="form-control" style="width: 100px;" value="${dGroup?default('')}"
									   name="dGroup" id="dGroup" placeholder="分组名称">
							</div>
							<@shiro.hasAnyRoles name='888888,100004,100005,100006'>
							<div class="form-group">
                                <select name="dealerId" id="dealerList" class="form-control">
                                </select>
							</div>
							</@shiro.hasAnyRoles>
					     <span class=""> <#--pull-right -->
				         	<button type="submit" class="btn btn-primary">查询</button>
							 <@shiro.hasPermission name="/dealer/addDealer.shtml">
								 <a class="btn btn-success" onclick="_add();">新增</a>
							 </@shiro.hasPermission>
				         </span>
				        </div>
					<hr>
					<table class="table table-bordered">
						<tr>
							<th><input type="checkbox" id="checkAll"/></th>
                            <th class="list_index">序号</th>
                            <th>登录账号</th>
							<th>名称</th>
							<th>手机号码</th>
                            <th>联系地址</th>
							<th>推荐码</th>
                            <th>分组名称</th>
							<th>创建时间</th>
							<th>操作</th>
						</tr>
						<#if page?exists && page.list?size gt 0 >
							<#list page.list as it>
								<tr>
									<td><input value="${it.id}" check='box' type="checkbox" /></td>
                                    <td>${it_index+1}</td>
									<td>${it.loginName}</td>
                                    <td>${it.name}</td>
                                    <td>${it.phone}</td>
                                    <td>${it.address}</td>
                                    <td>${it.inviteNum}</td>
                                    <td>${it.dGroup!""}</td>
                                    <td>${it.crtTime?string("yyyy-MM-dd HH:mm:ss")}</td>
									<td>
										<@shiro.hasPermission name="/dealer/editDealer.shtml">
											<a href="javascript:;" onclick="_edit('${it.id}','${it.name}','${it.phone}','${it.address!""}','${it.dGroup!""}');"><i class="fas fa-edit normal" title="编辑" data-toggle="modal" data-target="#employeeEditModal"></i></a>
										</@shiro.hasPermission>
										<@shiro.hasPermission name="/dealer/forbidUserById.shtml">
											${(it.status=='1')?string('<i class="glyphicon glyphicon-eye-close"></i>&nbsp;','<i class="glyphicon glyphicon-eye-open"></i>&nbsp;')}
                                            <a href="javascript:forbidUserById(${(it.status=='1')?string(0,1)},${it.userId})">
												${(it.status=='1')?string('禁止登录','激活登录')}
                                            </a>
										</@shiro.hasPermission>
									</td>
								</tr>
							</#list>
						<#else>
							<tr>
								<td class="text-center danger" colspan="10">没有找到员工</td>
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
					</form>
					<!--新增modal-->
                    <div class="modal fade" id="employeeAddModal" tabindex="-1" role="dialog" aria-labelledby="employeeAddModalLabel">
                        <div class="modal-dialog" role="document" style="width:30%;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="employeeAddModalLabel">新增</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
										<form id="form1" action="${basePath}/dealer/addDealer.shtml" method="post">
											<@shiro.hasAnyRoles name='200001'>
											<input type="hidden" name="parentId" value="${userId}"/>
											</@shiro.hasAnyRoles>
											<input type="hidden" name="roleId" value="6"/>
											<label for="employee_add_loginName">登录账号</label>
											<input type="text" name="loginName" class="form-control" required id="employee_add_loginName" placeholder="账号">
											<label for="employee_add_name">名称</label>
											<input type="text" name="name" class="form-control" required id="employee_add_name" placeholder="名称">
											<label for="employee_add_phone">手机号码</label>
											<input type="text" name="phone" class="form-control" required id="employee_add_phone" placeholder="手机号码">
											<label for="employee_add_address">联系地址</label>
											<input type="text" name="address" class="form-control" required id="employee_add_address" placeholder="地址">
                                            <label for="employee_add_group">分组名称</label>
                                            <input type="text" name="dGroup" class="form-control" required maxlength="20" id="employee_add_group" placeholder="分组名称">
											<@shiro.hasAnyRoles name='888888,100004,100005,100006'>
											<label for="dealerAddList">代理商</label>
											<select name="parentId" id="dealerAddList" class="form-control">
											</select>
											</@shiro.hasAnyRoles>
                                        </form>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                                    <button type="button" id="employee_add_btn_submit" class="btn btn-primary" data-dismiss="modal"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--编辑modal-->
                    <div class="modal fade" id="employeeEditModal" tabindex="-1" role="dialog" aria-labelledby="employeeEditModalLabel">
                        <div class="modal-dialog" role="document" style="width:30%;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="employeeEditModalLabel">编辑</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
										<form id="employee_edit_form" action="${basePath}/dealer/editDealer.shtml" method="post">
										<input type="hidden" name="id" id="employee_edit_id">
                                        <label for="employee_name">名称</label>
                                        <input type="text" name="name" class="form-control" id="employee_edit_name" placeholder="名称">
                                        <label for="employee_add_phone">手机号码</label>
                                        <input type="text" name="phone" class="form-control" id="employee_edit_phone" placeholder="手机号码">
                                        <label for="employee_add_address">联系地址</label>
                                        <input type="text" name="address" class="form-control" id="employee_edit_address" placeholder="地址">
										<label for="employee_edit_group">分组名称</label>
										<input type="text" name="dGroup" class="form-control" maxlength="20" id="employee_edit_group" placeholder="分组名称">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                                    <button type="button" id="employee_edit_btn_submit" class="btn btn-primary" data-dismiss="modal"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                                </div>
                            </div>
                        </div>
                    </div>
				</div>
			</div><#--/row-->
		</div>
			
	</body>
</html>