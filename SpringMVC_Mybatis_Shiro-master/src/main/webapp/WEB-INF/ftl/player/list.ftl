<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>选手列表</title>
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

                <@shiro.hasAnyRoles name='888888,100004'>
                $("#uploadPlayerBtn").unbind("click").bind("click", function() {
                    $("#uploadPlayerFile").click();
                });
                bindFile();

                $("#player_add_submit").click(function(){
                    var data = $("#play_add_form").serialize();
                    $.post('${basePath}/player/addPlayer.shtml',data,function(result){
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
                </@shiro.hasAnyRoles>

				$("#player_btn_submit").click(function(){
					var data = $("#play_edit_form").serialize();
                    $.post('${basePath}/player/editPlayer.shtml',data,function(result){
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

				<@shiro.hasPermission name="/player/auditById.shtml">
                $("#player_audit_submit").click(function(){
                    var data = $("#play_audit_form").serialize();
					var auditer = $("#auditer").val();
					data += "&auditer="+auditer;
                    $.post('${basePath}/player/auditById.shtml',data,function(result){
                        if(result && result.level != 1){
                            return layer.msg(result.messageText,so.default),!0;
                        }else{
                            layer.msg('审核成功！');
                            setTimeout(function(){
                                $('#formId').submit();
                            },1000);
                        }
                    },'json');
                });

				$("#player_wechat_submit").click(function(){
					var data = $("#play_wechat_form").serialize();
					$.post('${basePath}/player/auditById.shtml',data,function(result){
						if(result && result.level != 1){
							return layer.msg(result.messageText,so.default),!0;
						}else{
							layer.msg('微信添加成功！');
							setTimeout(function(){
								$('#formId').submit();
							},1000);
						}
					},'json');
				});
				</@shiro.hasPermission>

				$("#i_refresh").click(function(){
					$("#formId")[0].reset();
                    $('#formId').submit();
				});
			});


            //根据ID数组，删除
            function _audit(id, status){
                var text = status==1?'通过':'不通过';
                var index = layer.confirm("确定"+text+"当前选手？",function(){
                    $("#player_audit_id").val(id);
                    $("#player_audit_status").val(status);
                    layer.close(index);

					$("#playerAuditModal").modal();
                });
            }

            //根据ID数组，删除
            function _addwechat(id, status){
                    $("#player_wechat_id").val(id);
                    $("#player_wechat_status").val(status);

                    $("#playerWechatModal").modal();
            }

			function _edit(id, name, account, bz ,capital){
				$("#player_edit_id").val(id);
                $("#player_accountName").val(name);
				$("#player_account").val(account);
				$("#player_bz").val(bz);
                $("#player_capital").val(capital);
			}

            function _details(accountName, account, name, idCard, phone, crtTime, auditer, auditTime, wechat, belong, bz, capital){
                $("#player_details_accountName").val(accountName);
                $("#player_details_name").val(name);
                $("#player_details_account").val(account);
                $("#player_details_idNo").val(idCard);
                $("#player_details_phone").val(phone);
                $("#player_details_date").val(crtTime);
                $("#player_details_auditer").val(auditer);
                $("#player_details_auditDate").val(auditTime);

                $("#player_details_wechat").val(wechat);
                $("#player_details_belong").val(belong);
                $("#player_details_bz").val(bz);

                $("#player_details_capital").val(capital);
            }

            <@shiro.hasAnyRoles name='888888,100004'>
            function replaceFile(){
                $('#uploadPlayerFile').remove();
                $("#uploadPlayerBtn").after('<input type="file" name="file" style="width:0px;height:0px;display: none;" id="uploadPlayerFile" />');
                bindFile();
            }

            function bindFile(){
                $("#uploadPlayerFile").bind("change", function() {

                    var uploadEventFile = $("#uploadPlayerFile").val();
                    if (uploadEventFile == '') {
                        msg("请择excel,再上传");
                        return;
                    } else if (uploadEventFile.lastIndexOf(".xls") < 0 || uploadEventFile.lastIndexOf(".xlsx") < 0) {//可判断以.xls和.xlsx结尾的excel
                        msg("只能上传Excel文件");
                        return;
                    } else {
                        $("#contentDiv").mask("文件上传中，请稍后...");
                        var formData = new FormData();
                        formData.append('file', $('#uploadPlayerFile')[0].files[0]);
                        $.ajax({
                            url : '${basePath}/player/import.shtml',
                            type : 'post',
                            data : formData,
                            dataType : "json",
                            success : function(result) {
                                $("#contentDiv").unmask();

                                var msg = result.messageText;
                                if (result.data && result.data.length == 2) {
                                    msg = msg + "<a href='${basePath}/download.shtml?fileOutName="+encodeURI(encodeURI(result.data[0]))+"&filePath="+result.data[1]+"'>点击下载错误信息</a>";
                                }
                                layer.alert(msg, {
                                    icon: 0,
                                    skin: 'layui-layer-lan',
                                    end:function(){
                                        $('#formId').submit();
                                    }

                                });
                                replaceFile();

                            },
                            error : function(result) {
                                $("#contentDiv").unmask();
                                layer.alert(result.messageText, {
                                    icon: 0,
                                    skin: 'layui-layer-lan'
                                });
                                replaceFile();
                            },
                            cache : false,
                            contentType : false,
                            processData : false
                        });
                    }
                });
            }

            function _add(){
                $("#play_add_form")[0].reset();
                $("#playerAddModal").modal();
            }

            function _delete(id){
                var data = {
                    "id":id,
                    "delFlag":1
                }
                $.post('${basePath}/player/editPlayer.shtml',data,function(result){
                    if(result && result.level != 1){
                        return layer.msg(result.messageText,so.default),!0;
                    }else{
                        layer.msg('删除成功！');
                        setTimeout(function(){
                            $('#formId').submit();
                        },1000);
                    }
                },'json');
            }
            </@shiro.hasAnyRoles>

		</script>
	</head>
	<body data-target="#one" data-spy="scroll" id="contentDiv">
		
		<@_top.top 4/>
		<div class="container" >
			<div class="row">
				<@_left.player 1/>
				<div class="col-md-10">
					<h2>选手列表</h2>
					<hr>
					<form method="post" action="${basePath}/player/list.shtml" id="formId" class="form-inline">
						<div clss="well">
					      <div class="form-group">
					        <input type="text" class="form-control" style="width: 300px;" value="${findContent?default('')}" 
					        			name="findContent" id="findContent" placeholder="输入昵称 / 帐号">
							<select name="auditFlag" class="form-control">
                                <option value="">全部</option>
                                <option value="0">待审核</option>
                                <option value="1">通过未加微信</option>
                                <option value="3">通过已加微信</option>
                                <option value="2">不通过</option>
							</select>
					      </div>
					     <span> <#--pull-right -->
				         	<button type="submit" class="btn btn-primary">查询</button>
                            <@shiro.hasAnyRoles name='888888,100004'>
                             <button type="button" id="addPlayerBtn" onclick="_add();" class="btn btn-primary">新增</button>
							 <form enctype="multipart/form-data" id="excelForm"   method="post" >
								<button class="btn btn-success" id="uploadPlayerBtn"  type="button" >
									导入
								</button>
								<input type="file" name="file" style="width:0px;height:0px;display: none;" id="uploadPlayerFile" />
                    		</form>
                             <a href="${basePath}/file/player.xlsx">模板下载</a>
                            </@shiro.hasAnyRoles>
				         </span>
						  <div id="div_refresh">
                              <i class="fas fa-redo-alt" id="i_refresh" title="刷新"></i>
						  </div>
				        </div>
					<hr>
					<table class="table table-bordered">
						<tr>
							<#--<th><input type="checkbox" id="checkAll"/></th>-->
                            <th class="col-sm-1 list_index">序号</th>
							<th class="col-sm-1">昵称</th>
							<th class="col-sm-1 list_phone">姓名</th>
							<th class="col-sm-1">资金账号</th>
							<#--<th class="col-sm-1">身份证</th>-->
							<th class="col-sm-1 list_phone">手机号</th>
							<th class="col-sm-1">报名时间</th>
							<th class="col-sm-1">备注</th>
							<th class="col-sm-1">审核状态</th>
							<th class="col-sm-1">审核人</th>
							<th class="col-sm-1">审核时间</th>
							<#--<th class="col-sm-1">微信号码</th>-->
							<th class="col-sm-1">归属</th>
							<th class="col-sm-1">操作</th>
						</tr>
						<#if page?exists && page.list?size gt 0 >
							<#list page.list as it>
								<tr>
									<#--<td><input value="${it.id}" check='box' type="checkbox" /></td>-->
                                    <td>${it_index+1}</td>
									<td>${it.accountName}</td>
									<td>${it.name}</td>
									<td>${it.account}</td>
									<#--<td>${it.idCard}</td>-->
									<td>${it.telPhone}</td>
									<td>${it.crtTime?string("yyyy-MM-dd HH:mm:ss")}</td>
									<td>${it.bz}</td>
									<td>
										<#if it.auditFlag==0>
											待审核
										<#elseif it.auditFlag==1>
											通过未加微信
										<#elseif it.auditFlag==3>
                                            通过已加微信
										<#elseif it.auditFlag==2>
											未通过
										</#if>
									</td>
									<td>${it.auditer!""}</td>
									<td>${it.auditTime!""}</td>
									<#--<td>${it.wechat!""}</td>-->
									<td>${it.belong!""}</td>
									<td>
										<@shiro.hasPermission name="/player/auditById.shtml">
											<#if it.auditFlag==0>
                                            	<a href="javascript:_audit('${it.id}','1');"><i class="fas fa-check-circle pass" title="通过"></i></a>
											</#if>
										</@shiro.hasPermission>
										<@shiro.hasPermission name="/player/auditById.shtml">
											<#if it.auditFlag==0>
                                            	<a href="javascript:_audit('${it.id}','2');"><i class="fas fa-times-circle fail" title="不通过"></i></a>
											</#if>
										</@shiro.hasPermission>
                                        <a href="javascript:_edit('${it.id}', '${it.accountName}','${it.account}','${it.bz}','${it.capital!"0"}');"><i class="fas fa-edit normal" title="编辑" data-toggle="modal" data-target="#playerEditModal"></i></a>
                                        <a href="javascript:_details('${it.accountName}','${it.account}','${it.name}','${it.idCard}','${it.telPhone}','${it.crtTime?string("yyyy-MM-dd HH:mm:ss")}','${it.auditer!""}','${it.auditTime!""}','${it.wechat!""}','${it.belong!""}','${it.bz}','${it.capital!"0"}');"><i class="far fa-file-alt normal" title="详情" data-toggle="modal" data-target="#playerDetailsModal"></i></a>
                                        <@shiro.hasAnyRoles name='888888,100004'>
                                            <a href="javascript:_delete('${it.id}');"><i class="fas fa-user-times normal" title="删除"></i></a>
                                        </@shiro.hasAnyRoles>
										<#if it.auditFlag==1>
                                            <a href="javascript:_addwechat('${it.id}','3');"><i class="fab fa-weixin pass" title="微信"></i></a>
										</#if>
									</td>
								</tr>
							</#list>
						<#else>
							<tr>
								<td class="text-center danger" colspan="11">没有找到参赛选手</td>
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
                    <div class="modal fade" id="playerAddModal" tabindex="-1" role="dialog" aria-labelledby="playerAddModalLabel">
                        <div class="modal-dialog" role="document" style="width:30%;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="playerAddModal">新增</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <form id="play_add_form" action="#" method="post">
                                            <label for="player_add_accountName">昵称</label>
                                            <input type="text" name="accountName" required class="form-control" id="player_add_accountName" placeholder="昵称">
                                            <label for="player_add_name">姓名</label>
                                            <input type="text" name="name" class="form-control" required id="player_add_name" placeholder="姓名">
                                            <label for="player_add_account">资金账号</label>
                                            <input type="text" name="account" class="form-control" required id="player_add_account" placeholder="资金账号">
                                            <#--<label for="player_add_capital">本金</label>-->
                                            <#--<input type="text" name="capital" class="form-control" required id="player_add_capital" oninput="this.value=this.value.replace(/[^\d.]/g,'')" placeholder="本金">-->
                                            <label for="player_add_idNo">身份证</label>
                                            <input type="text" name="idCard" class="form-control" required id="player_add_idNo" placeholder="身份证">
                                            <label for="player_add_phone">手机号码</label>
                                            <input type="text" name="telPhone" class="form-control" required id="player_add_phone" placeholder="手机号码">
                                        </form>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                                    <button type="button" id="player_add_submit" class="btn btn-primary" data-dismiss="modal"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade" id="playerEditModal" tabindex="-1" role="dialog" aria-labelledby="playerEditModalLabel">
                        <div class="modal-dialog" role="document" style="width:30%;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="playerEditModalLabel">编辑</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <form id="play_edit_form" action="#" method="post">
											<input type="hidden" name="id" id="player_edit_id">
											<label for="player_accountName">昵称</label>
											<input type="text" name="accountName" class="form-control" id="player_accountName" placeholder="昵称">
											<label for="player_account">资金账号</label>
											<input type="text" name="account" class="form-control" id="player_account" placeholder="资金账号">
                                            <label for="player_capital">本金</label>
                                            <input type="text" name="capital" class="form-control" id="player_capital" oninput="this.value=this.value.replace(/[^\d.]/g,'')" placeholder="本金">
											<label for="player_bz">备注</label>
											<textarea name="bz" class="form-control" id="player_bz" placeholder="备注"></textarea>
										</form>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                                    <button type="button" id="player_btn_submit" class="btn btn-primary" data-dismiss="modal"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade" id="playerAuditModal" tabindex="-1" role="dialog" aria-labelledby="playerAuditModalLabel">
                        <div class="modal-dialog" role="document" style="width:30%;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="playerAModalLabel">审核选手</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
										<form id="play_audit_form" action="#" method="post">
											<input type="hidden" name="id" id="player_audit_id">
											<input type="hidden" name="auditFlag" id="player_audit_status">
											<label for="player_account">资金账号</label>
											<input type="text" name="account" class="form-control" placeholder="资金账号">
                                            <label for="player_account">审核人</label>
                                            <input type="text" id="auditer" name="auditer" disabled class="form-control" placeholder="审核人" value="${token.email}">
											<label for="player_bz">备注</label>
											<textarea name="bz" class="form-control" placeholder="备注"></textarea>
                                        </form>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                                    <button type="button" id="player_audit_submit" class="btn btn-primary" data-dismiss="modal"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade" id="playerWechatModal" tabindex="-1" role="dialog" aria-labelledby="playerWechatModalLabel">
                        <div class="modal-dialog" role="document" style="width:30%;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="playerWechatModalLabel">添加微信</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <form id="play_wechat_form" action="#" method="post">
                                            <input type="hidden" name="id" id="player_wechat_id">
                                            <input type="hidden" name="auditFlag" id="player_wechat_status">
                                            <label for="player_wechat">微信号码</label>
                                            <input type="text" name="wechat" class="form-control" placeholder="微信号码">
                                        </form>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                                    <button type="button" id="player_wechat_submit" class="btn btn-primary" data-dismiss="modal"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade" id="playerDetailsModal" tabindex="-1" role="dialog" aria-labelledby="playerDetailsModalLabel">
                        <div class="modal-dialog" role="document" style="width:30%;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="playerDetailsModalLabel">详情</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <form id="play_details_form" action="#" method="post">
                                            <input type="hidden" name="id" id="player_details_id">
                                            <label for="player_details_accountName">昵称</label>
                                            <input type="text" class="form-control" id="player_details_accountName" disabled>
                                            <label for="player_details_name">姓名</label>
                                            <input type="text" class="form-control" id="player_details_name" disabled>
                                            <label for="player_details_account">资金账号</label>
                                            <input type="text" class="form-control" id="player_details_account" disabled >
                                            <label for="player_details_capital">本金</label>
                                            <input type="text" class="form-control" id="player_details_capital" disabled >
                                            <label for="player_details_idNo">身份证</label>
                                            <input type="text" class="form-control" id="player_details_idNo" disabled>
                                            <label for="player_details_phone">手机号码</label>
                                            <input type="text" class="form-control" id="player_details_phone" disabled >
                                            <label for="player_details_date">报名时间</label>
                                            <input type="text" class="form-control" id="player_details_date" disabled>
                                            <label for="player_details_auditer">审核人</label>
                                            <input type="text" class="form-control" id="player_details_auditer" disabled >
                                            <label for="player_details_auditDate">审核时间</label>
                                            <input type="text" class="form-control" id="player_details_auditDate" disabled >
                                            <label for="player_details_wechat">微信号码</label>
                                            <input type="text" class="form-control" id="player_details_wechat" disabled >
                                            <label for="player_details_belong">归属</label>
                                            <input type="text" class="form-control" id="player_details_belong" disabled >
                                            <label for="player_details_bz">备注</label>
                                            <textarea class="form-control" id="player_details_bz" disabled ></textarea>
                                        </form>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                                </div>
                            </div>
                        </div>
                    </div>
				</div>
			</div><#--/row-->
		</div>
			
	</body>
</html>