<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>经销商列表</title>
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

				$("#dealer_edit_btn_submit").click(function(){
					var data = $("#dealer_edit_form").serialize();
                    $.post('${basePath}/dealer/editDealer.shtml',data,function(result){
                        if(result && result.level != 1){
                            return layer.msg(result.messageText,so.default),!0;
                        }else{
                            layer.msg('编辑成功！');
                            setTimeout(function(){
                                $('#dealerForm').submit();
                            },1000);
                        }
                    },'json');
				});

                $("#dealer_add_btn_submit").click(function(){
					var data = $("#form1").serialize();
                    $.post('${basePath}/dealer/addDealer.shtml',
							data,
							function(result){
                        if(result && result.level != 1){
                            return layer.msg(result.messageText,so.default),!0;
                        }else{
                            layer.msg('新增成功！');
                            setTimeout(function(){
                                $('#dealerForm').submit();
                            },1000);
                        }
                    },'json');
                });
			});

			function _edit(id, name, phone, address, type){
				$("#dealer_edit_id").val(id);
                $("#dealer_edit_name").val(name);
                $("#dealer_edit_phone").val(phone);
                $("#dealer_edit_address").val(address);
                $("#dealer_edit_type").val(type);
			}

			function _add(){
				$('#dealerAddModal .form-control').val("");
                $('#dealerAddModal').modal();
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

		</script>
	</head>
	<body data-target="#one" data-spy="scroll">
		
		<@_top.top 5/>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
			<div class="row">
				<@_left.dealer 1/>
				<div class="col-md-10">
					<h2>经销商列表</h2>
					<hr>
					<form method="post" action="${basePath}/dealer/list.shtml?parentId=0" id="dealerForm" class="form-inline">
						<div clss="well">
					      <div class="form-group">
					        <input type="text" class="form-control" style="width: 300px;" value="${findContent?default('')}" 
					        			name="findContent" id="findContent" placeholder="输入名称">
					      </div>
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
                            <th>账号</th>
							<th>名称</th>
							<th>手机号码</th>
                            <th>联系地址</th>
							<th>操作</th>
						</tr>
						<#if page?exists && page.list?size gt 0 >
							<#list page.list as it>
								<tr>
									<td><input value="${it.id}" check='box' type="checkbox" /></td>
									<td>${it.loginName}</td>
                                    <td>${it.name}</td>
                                    <td>${it.phone}</td>
                                    <td>${it.address}</td>
									<td>
										<@shiro.hasPermission name="/dealer/editDealer.shtml">
											<a href="javascript:_edit('${it.id}','${it.name}','${it.phone}','${it.address}','${it.type}');"><i class="fas fa-edit normal" title="编辑" data-toggle="modal" data-target="#dealerEditModal"></i></a>
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
								<td class="text-center danger" colspan="6">没有找到经销商</td>
							</tr>
						</#if>
					</table>
					<#if page?exists>
						<div class="pagination pull-right">
							${page.pageHtml}
						</div>
					</#if>
					</form>
					<!--新增modal-->
                    <div class="modal fade" id="dealerAddModal" tabindex="-1" role="dialog" aria-labelledby="dealerAddModalLabel">
                        <div class="modal-dialog" role="document" style="width:30%;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="dealerAddModalLabel">新增</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
										<form id="form1" action="${basePath}/dealer/addDealer.shtml" method="post">
											<input type="hidden" name="parentId" value="0"/>
											<input type="hidden" name="roleId" value="5"/>
											<label for="dealer_add_loginName">账号</label>
											<input type="text" name="loginName" class="form-control" id="dealer_add_loginName" placeholder="账号">
											<label for="dealer_add_name">名称</label>
											<input type="text" name="name" class="form-control" id="dealer_add_name" placeholder="名称">
											<label for="dealer_add_phone">手机号码</label>
											<input type="text" name="phone" class="form-control" id="dealer_add_phone" placeholder="手机号码">
											<label for="dealer_add_address">联系地址</label>
											<input type="text" name="address" class="form-control" id="dealer_add_address" placeholder="地址">
											<label for="dealer_add_type">返点类型</label>
											<select name="type" class="form-control">
												<option value="1">5%</option>
                                                <option value="2">10%</option>
                                                <option value="3">15%</option>
											</select>
                                        </form>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                                    <button type="button" id="dealer_add_btn_submit" class="btn btn-primary" data-dismiss="modal"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--编辑modal-->
                    <div class="modal fade" id="dealerEditModal" tabindex="-1" role="dialog" aria-labelledby="dealerEditModalLabel">
                        <div class="modal-dialog" role="document" style="width:30%;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="dealerEditModalLabel">编辑</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
										<form id="dealer_edit_form" action="${basePath}/dealer/editDealer.shtml" method="post">
										<input type="hidden" name="id" id="dealer_edit_id">
                                        <label for="dealer_name">名称</label>
                                        <input type="text" name="name" class="form-control" id="dealer_edit_name" placeholder="名称">
                                        <label for="dealer_add_phone">手机号码</label>
                                        <input type="text" name="phone" class="form-control" id="dealer_edit_phone" placeholder="手机号码">
                                        <label for="dealer_add_address">联系地址</label>
                                        <input type="text" name="address" class="form-control" id="dealer_edit_address" placeholder="地址">
                                        <label for="dealer_add_type">返点类型</label>
                                        <select name="type" class="form-control" id="dealer_edit_type">
                                            <option value="1">5%</option>
                                            <option value="2">10%</option>
                                            <option value="3">15%</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                                    <button type="button" id="dealer_edit_btn_submit" class="btn btn-primary" data-dismiss="modal"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                                </div>
                            </div>
                        </div>
                    </div>
				</div>
			</div><#--/row-->
		</div>
	</body>
</html>