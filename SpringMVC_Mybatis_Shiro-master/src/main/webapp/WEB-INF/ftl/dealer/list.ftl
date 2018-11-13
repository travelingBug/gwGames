<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>代理商列表</title>
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
                    if($("#dealer_edit_phone").hasClass("has-error")){
                        layer.msg('验证错误！');
                        return false;
                    }
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

                $("#dealer_add_btn_submit").click(function(){
					var data = $("#form1").serialize();
                    var loginName = $("#dealer_add_loginName").val();
                    var name = $("#dealer_add_name").val();
                    var phone = $("#dealer_add_phone").val();
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
					if($("#dealer_add_phone").hasClass("has-error")){
                        layer.msg('验证错误！');
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

                $("#dealer_card_add_btn").click(function(){
                    var userId = $("#dealer_card_add_userId").val();
                    var cardNo = $("#dealer_card_add_cardNo").val();
                    var bankName = $("#dealer_card_add_bankName").val();
                    var cardName = $("#dealer_card_add_name").val();
                    var phone = $("#dealer_card_add_phone").val();
                    var dealerId = $("#dealer_add_id").val();
                    var data = {
                        "modUser":userId,
                        "cardNo":cardNo,
                        "cardName":cardName,
                        "bankName":bankName,
                        "phone":phone,
                        "dealerId":dealerId
                    }
                    $.post('${basePath}/dealer/addDealerBankCard.shtml',
                            data,
                            function(result){
                                if(result && result.level != 1){
                                    return layer.msg(result.messageText,so.default),!0;
                                }else{
                                    layer.msg('绑定银行卡成功！');
                                    setTimeout(function(){
                                        $('#formId').submit();
                                    },1000);
                                }
                            },'json');
                });

                $("#dealer_card_edit_btn").click(function(){
                    var userId = $("#dealer_card_edit_userId").val();
                    var cardNo = $("#dealer_card_edit_cardNo").val();
                    var bankName = $("#dealer_card_edit_bankName").val();
                    var cardName = $("#dealer_card_edit_name").val();
                    var phone = $("#dealer_card_edit_phone").val();
                    var dealerId = $("#dealer_edit_id").val();
                    var data = {
                        "modUser":userId,
                        "cardNo":cardNo,
                        "cardName":cardName,
                        "bankName":bankName,
                        "phone":phone,
                        "dealerId":dealerId
                    }
                    $.post('${basePath}/dealer/editDealerBankCard.shtml',
                            data,
                            function(result){
                                if(result && result.level != 1){
                                    return layer.msg(result.messageText,so.default),!0;
                                }else{
                                    layer.msg('编辑银行卡成功！');
                                    setTimeout(function(){
                                        $('#formId').submit();
                                    },1000);
                                }
                            },'json');
                });
			});

			function valiPhone(obj){
                var phone = obj.value;
				var data = {
					"phone":phone
				}
                $.post('${basePath}/dealer/valiPhone.shtml',data,function(result){
                    if(result && result.level != 1){
                        $(obj).addClass("has-error");
                        $(obj).parent(".form-group").removeClass("has-success");
                        $(obj).parent(".form-group").addClass("has-error");
                        $(obj).siblings(".form-control-feedback").removeClass("glyphicon-ok");
						$(obj).siblings(".form-control-feedback").addClass("glyphicon-remove");
                    }else{
                        $(obj).removeClass("has-error");
                        $(obj).parent(".form-group").removeClass("has-error");
                        $(obj).parent(".form-group").addClass("has-success");
                        $(obj).siblings(".form-control-feedback").removeClass("glyphicon-remove");
                        $(obj).siblings(".form-control-feedback").addClass("glyphicon-ok");
					}
                },'json');
			}

            function valiSeatNum(obj){
                var seatNum = obj.value;
                var data = {
                    "seatNum":seatNum
                }
                $.post('${basePath}/dealer/valiSeatNum.shtml',data,function(result){
                    if(result && result.level != 1){
                        $(obj).addClass("has-error");
                        $(obj).parent(".form-group").removeClass("has-success");
                        $(obj).parent(".form-group").addClass("has-error");
                        $(obj).siblings(".form-control-feedback").removeClass("glyphicon-ok");
                        $(obj).siblings(".form-control-feedback").addClass("glyphicon-remove");
                    }else{
                        $(obj).removeClass("has-error");
                        $(obj).parent(".form-group").removeClass("has-error");
                        $(obj).parent(".form-group").addClass("has-success");
                        $(obj).siblings(".form-control-feedback").removeClass("glyphicon-remove");
                        $(obj).siblings(".form-control-feedback").addClass("glyphicon-ok");
                    }
                },'json');
            }

			function _edit(id, name, phone, address, type, dGroup, state){
				$("#dealer_edit_id").val(id);
                $("#dealer_edit_name").val(name);
                $("#dealer_edit_phone").val(phone);
                $("#dealer_edit_address").val(address);
                $("#dealer_edit_type").val(type);
                $("#dealer_edit_group").val(dGroup);
                $("#dealer_edit_group").val(dGroup);
                $("#dealer_edit_state").val(state);
			}

			function _add(){
                $.post('${basePath}/dealer/querySeatNum.shtml',null,function(result){
                    if(result && result.level == 1){
                        $("#dealer_add_seatNum").val(result.data);
                    }
                },'json');

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

            function _bankCard(id, userId){
                var data = {
                    "id":id
                }
                $.post('${basePath}/dealer/queryBankCard.shtml',data,function(result){
                    if(result && result.level == 1){
                        $("#dealer_card_edit_userId").val(userId);
                        $("#dealer_edit_id").val(id);
                        $("#dealer_card_edit_cardNo").val(result.data.cardNo);
                        $("#dealer_card_edit_bankName").val(result.data.bankName);
                        $("#dealer_card_edit_name").val(result.data.cardName);
                        $("#dealer_card_edit_phone").val(result.data.phone);
                        $('#dealerEditCardModal').modal();
                    }else{
                        $("#dealer_card_add_userId").val(userId);
                        $("#dealer_add_id").val(id);
                        $('#dealerCardModal').modal();
                    }
                },'json');
            }

		</script>
	</head>
	<body data-target="#one" data-spy="scroll">
		
		<@_top.top 5/>
		<div class="container" >
			<div class="row">
				<@_left.dealer 1/>
				<div class="col-md-10">
					<h2>代理商列表</h2>
					<hr>
					<form method="post" id="formId" action="${basePath}/dealer/list.shtml?parentId=0" id="formId" class="form-inline">
						<div clss="well">
					      <div class="form-group">
					        <input type="text" class="form-control" style="width: 300px;" value="${findContent?default('')}" 
					        			name="findContent" id="findContent" placeholder="输入名称/手机号码">
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
                            <th class="list_index">序号</th>
                            <th>登录账号</th>
							<th>名称</th>
							<th>手机号码</th>
                            <th>联系地址</th>
                            <th>席位号</th>
                            <th>邀请码</th>
                            <th>分组名称</th>
							<th>创建时间</th>
							<th>操作</th>
						</tr>
						<#if page?exists && page.list?size gt 0 >
							<#list page.list as it>
								<tr>
									<td><input value="${it.id}" check='box' type="checkbox" /></td>
                                    <td>${it_index+1}</td>
									<td>${it.loginName!""}</td>
                                    <td>${it.name!""}</td>
                                    <td>${it.phone}</td>
                                    <td>${it.address}</td>
                                    <td>${it.seatNum}</td>
                                    <td>${it.inviteNum}</td>
                                    <td>${it.dGroup!""}</td>
									<td>${it.crtTime?string("yyyy-MM-dd HH:mm:ss")}</td>
									<td>
										<@shiro.hasPermission name="/dealer/editDealer.shtml">
											<a href="javascript:_edit('${it.id}','${it.name}','${it.phone}','${it.address}','${it.type}','${it.dGroup!""}','${it.state!""}');"><i class="fas fa-edit normal" title="编辑" data-toggle="modal" data-target="#dealerEditModal"></i></a>
										</@shiro.hasPermission>
                                        <@shiro.hasPermission name="/dealer/addDealerBankCard.shtml">
                                        <a href="javascript:_bankCard('${it.id}','${userId}');"><i class="far fa-credit-card" title="绑定银行卡" data-toggle="modal"></i></a>
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
								<td class="text-center danger" colspan="10">没有找到代理商</td>
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
											<label for="dealer_add_loginName">登录账号</label>
											<input type="text" name="loginName" class="form-control" id="dealer_add_loginName" placeholder="账号">
											<label for="dealer_add_name">名称</label>
											<input type="text" name="name" class="form-control" id="dealer_add_name" placeholder="名称">
											<div class="form-group has-feedback">
												<label for="dealer_add_phone">手机号码</label>
												<input type="text" name="phone" class="form-control" onblur="valiPhone(this);" id="dealer_add_phone" placeholder="手机号码">
                                                <span class="glyphicon form-control-feedback"></span>
											</div>
                                            <div class="form-group has-feedback">
                                                <label for="dealer_add_seatNum">坐席号</label>
                                                <input type="text" name="seatNum" class="form-control" onkeyup="var v=this.value||'';v=v.replace(/[^\d]/g,'');this.value=v.substr(0,3);" maxlength="4"
													   onblur="valiSeatNum(this);" id="dealer_add_seatNum" placeholder="坐席号">
                                                <span class="glyphicon form-control-feedback"></span>
                                            </div>
											<label for="dealer_add_address">联系地址</label>
											<input type="text" name="address" class="form-control" id="dealer_add_address" placeholder="地址">
											<label for="dealer_add_type">返佣比例</label>
                                            <div class="input-group">
                                                <input type="text" name="type" id="dealer_add_type" class="form-control" placeholder="返佣比例" aria-describedby="basic-addon2">
                                                <span class="input-group-addon" id="basic-addon2">%</span>
                                            </div>
                                            <label for="dealer_add_group">分组名称</label>
                                            <input type="text" name="dGroup" class="form-control" maxlength="20" id="dealer_add_group" placeholder="分组名称">
                                            <label for="state">是否显示报名链接</label>
                                            <select name="state" id="dealer_add_state" class="form-control">
                                                <option value="0" selected="selected">否</option>
                                                <option value="1">是</option>
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
										<div class="form-group has-feedback">
											<label for="dealer_add_phone">手机号码</label>
											<input type="text" name="phone" class="form-control" onblur="valiPhone(this);" id="dealer_edit_phone" placeholder="手机号码">
											<span class="glyphicon form-control-feedback"></span>
										</div>
                                        <label for="dealer_add_address">联系地址</label>
                                        <input type="text" name="address" class="form-control" id="dealer_edit_address" placeholder="地址">
                                        <@shiro.hasAnyRoles name='888888,900001'>
                                        <label for="dealer_edit_type">返佣比例</label>
                                        <div class="input-group">
                                            <input type="text" name="type"  id="dealer_edit_type" class="form-control" placeholder="返佣比例" aria-describedby="basic-addon2">
                                            <span class="input-group-addon" id="basic-addon2">%</span>
                                        </div>
                                        </@shiro.hasAnyRoles>
                                        <label for="dealer_edit_group">分组名称</label>
                                        <input type="text" name="dGroup" class="form-control" maxlength="20" id="dealer_edit_group" placeholder="分组名称">
                                        <label for="state">是否显示报名链接</label>
                                        <select name="state" id="dealer_edit_state" class="form-control">
                                            <option value="0">否</option>
                                            <option value="1">是</option>
                                        </select>
                                        </form>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                                    <button type="button" id="dealer_edit_btn_submit" class="btn btn-primary" data-dismiss="modal"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--绑定银行卡modal-->
                    <div class="modal fade" id="dealerCardModal" tabindex="-1" role="dialog" aria-labelledby="dealerCardModalLabel">
                        <div class="modal-dialog" role="document" style="width:30%;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="dealerCardModalLabel">绑定银行卡</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <form id="dealer_card_add_form" action="${basePath}/dealer/addDealerBankCard.shtml" method="post">
                                            <input type="hidden" name="modUser" id="dealer_card_add_userId">
                                            <input type="hidden" id="dealer_add_id">
                                            <label for="dealer_card_add_cardNo">银行卡号</label>
                                            <input type="text" name="cardNo" class="form-control" id="dealer_card_add_cardNo" placeholder="银行卡号">
                                            <label for="dealer_card_add_bankName">开户行名称</label>
                                            <input type="text" name="bankName" class="form-control" id="dealer_card_add_bankName" placeholder="开户行名称">
                                            <label for="dealer_card_add_name">开户人名称</label>
                                            <input type="text" name="cardName" class="form-control" maxlength="20" id="dealer_card_add_name" placeholder="开户人名称">
                                            <label for="dealer_card_add_phone">开户电话</label>
                                            <input type="text" name="phone" class="form-control" maxlength="20" id="dealer_card_add_phone" placeholder="开户电话">
                                        </form>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                                    <button type="button" id="dealer_card_add_btn" class="btn btn-primary" data-dismiss="modal"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--编辑银行卡modal-->
                    <div class="modal fade" id="dealerEditCardModal" tabindex="-1" role="dialog" aria-labelledby="dealerEditCardModalLabel">
                        <div class="modal-dialog" role="document" style="width:30%;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="dealerEditCardModalLabel">绑定银行卡</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <form id="dealer_card_edit_form" action="${basePath}/dealer/editDealerBankCard.shtml" method="post">
                                            <input type="hidden" id="dealer_edit_id">
                                            <input type="hidden" name="modUser" id="dealer_card_edit_userId">
                                            <label for="dealer_card_edit_cardNo">银行卡号</label>
                                            <input type="text" name="cardNo" class="form-control" id="dealer_card_edit_cardNo" placeholder="银行卡号">
                                            <label for="dealer_card_edit_bankName">开户行名称</label>
                                            <input type="text" name="bankName" class="form-control" id="dealer_card_edit_bankName" placeholder="开户行名称">
                                            <label for="dealer_card_edit_name">开户人名称</label>
                                            <input type="text" name="cardName" class="form-control" maxlength="20" id="dealer_card_edit_name" placeholder="开户人名称">
                                            <label for="dealer_card_edit_phone">开户电话</label>
                                            <input type="text" name="phone" class="form-control" maxlength="20" id="dealer_card_edit_phone" placeholder="开户电话">
                                        </form>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                                    <button type="button" id="dealer_card_edit_btn" class="btn btn-primary" data-dismiss="modal"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                                </div>
                            </div>
                        </div>
                    </div>

				</div>
			</div><#--/row-->
		</div>
	</body>
</html>