<!DOCTYPE html>
<html lang="zh-cn">
	<head>
    <#include "../head.ftl" >
		<meta charset="utf-8" />
		<title>参赛人员资金列表</title>
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
                $("#uploadEventBtn").unbind("click").bind("click", function() {
                    $("#uploadEventFile").click();
                });
                bindFile();
				//初始化全选。
				so.checkBoxInit('#checkAll','[check=box]');
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

                laydate({
                    elem: '#playerMoney_businessTime',
                    istime:true,
                    format:'YYYY-MM-DD hh:mm:ss'
                });

                laydate({
                    elem: '#playerMoney_businessTime_add',
                    istime:true,
                    format:'YYYY-MM-DD hh:mm:ss'
                });

                $('#reComplate').click(function(){
                    $("#contentDiv").mask("计算排名中，请稍后...");
                    $.ajax({
                        type: "POST",
                        url: "/playerMoney/reComplate.shtml",
                        data: [],
                        dataType: "json",
                        success: function(result) {
                            $("#contentDiv").unmask();
                            if (result && result.level != 1) {
                                msg(result.messageText);
                            } else {
                                layer.msg('排名计算成功！');
                                $('#playerMoney_edit-remove').click();
                                $('#formId').submit();
                            }
                        },
                        error: function(data) {
                            $("#contentDiv").unmask();
                            layer.alert('系统错误，请联系管理员！', {
                                icon: 2,
                                skin: 'layui-layer-lan'
                            });
                        }
                    });
                });
                $('#playerMoney_edit_submit').click(function(){
                    var flag = validEditForm();
                    if (!flag) {
                        return;
                    }
                    var data = $('#editForm').serializeArray();
                    var businessTimeDate = getDate($('#playerMoney_businessTime').val());
                    $.each(data, function(i, field){
                        if (field.name == "businessTime") {
                            field.value = businessTimeDate;
                        }
                    });
                    $.ajax({
                        type: "POST",
                        url: "/playerMoney/update.shtml",
                        data: data,
                        dataType: "json",
                        success: function(result) {
                            if (result && result.level != 1) {
                                msg(result.messageText);
                            } else {
                                layer.msg('编辑成功！');
                                $('#playerMoney_edit-remove').click();
                                $('#formId').submit();
                            }
                        },
                        error: function(data) {
                            layer.alert('系统错误，请联系管理员！', {
                                icon: 2,
                                skin: 'layui-layer-lan'
                            });
                        }
                    });
				});


                $('#playerMoney_add_submit').click(function(){
                    var flag = validAddForm();
                    if (!flag) {
                        return;
                    }
                    var data = $('#addForm').serializeArray();
                    var businessTimeDate = getDate($('#playerMoney_businessTime_add').val());
                    $.each(data, function(i, field){
                        if (field.name == "businessTime") {
                            field.value = businessTimeDate;
                        }
                    });
                    $.ajax({
                        type: "POST",
                        url: "/playerMoney/add.shtml",
                        data: data,
                        dataType: "json",
                        success: function(result) {
                            if (result && result.level != 1) {
                                msg(result.messageText);
                            } else {
                                layer.msg('添加成功！');
                                $('#playerMoney_add-remove').click();
                                $('#formId').submit();
                            }
                        },
                        error: function(data) {
                            layer.alert('系统错误，请联系管理员！', {
                                icon: 2,
                                skin: 'layui-layer-lan'
                            });
                        }
                    });
                });

                $("#playerMoney_account_add").blur(function(event){
                    event.stopPropagation();
                    var accountName = $("#playerMoney_account_add").val();
                    if (accountName != null && accountName != "") {
                        $.ajax({
                            type: "POST",
                            url: "/player/findAll.shtml",
                            data: {'account':accountName},
                            dataType: "json",
                            success: function(result) {
                                if (result && result.length != 1) {
                                    msg("资金账户不存在，请验证后再输入");
                                    $("#player_accountName_add").val("");
                                    $("#player_name_add").val("");
                                    $('#playerMoney_add_submit').attr("disabled","disabled");
                                } else {
                                    $("#player_accountName_add").val(result[0].accountName);
                                    $("#player_name_add").val(result[0].name);
                                    $('#playerMoney_add_submit').removeAttr("disabled");
                                }
                            },
                            error: function(data) {
                                layer.alert('系统错误，请联系管理员！', {
                                    icon: 2,
                                    skin: 'layui-layer-lan'
                                });
                            }
                        });
                    }

                });

			});

            function _del(id){
                var index =  layer.confirm("确定删除此条数据？",function(){
                    var load = layer.load();

                    $.ajax({
                        type: "POST",
                        url: "/playerMoney/del.shtml",
                        data: {id:id},
                        dataType: "json",
                        success: function(result) {
                            if (result && result.level != 1) {
                                return layer.msg(result.messageText, so.default), !0;
                            } else {
                                layer.msg('删除成功！');
                                $('#formId').submit();
                            }
                        },
                        error: function(data) {
                            layer.alert('系统错误，请联系管理员！', {
                                icon: 2,
                                skin: 'layui-layer-lan'
                            });
                        }
                    });

                    layer.close(index);
                });
            }
			function _update(id,accountName,name,account,businessTimeStr,totalMoney,balanceMoney){
				$("#playerMoney_id").val(id);
                $("#player_accountName").val(accountName);
                $("#player_name").val(name);
                $("#playerMoney_account").val(account);
                $("#playerMoney_businessTime").val(businessTimeStr);
                $("#playerMoney_totalMoney").val(totalMoney);
                $("#playerMoney_balanceMoney").val(balanceMoney);
			}

            function getDate(strDate) {
                var date = eval('new Date(' + strDate.replace(/\d+(?=-[^-]+$)/,
                        function (a) { return parseInt(a, 10) - 1; }).match(/\d+/g) + ')');
                return date;
            }

            function msg(messageText){
                layer.alert(messageText, {
                    icon: 0,
                    skin: 'layui-layer-lan'
                });
            }


            function validEditForm(){
                if ($("#playerMoney_id").val() == null || $("#playerMoney_id").val() == ''){
                    msg('修改错误，请联系管理员处理');
                    return false;
                }
                if ($("#playerMoney_account").val() == null || $("#playerMoney_account").val() == '') {
                    msg('资金账号不能为空！');
                    return false;
                }
                if ($("#playerMoney_businessTime").val() == null || $("#playerMoney_businessTime").val() == '') {
                    msg('时间不能为空！');
                    return false;
                }
                if ($("#playerMoney_balanceMoney").val() == null || $("#playerMoney_balanceMoney").val() == '') {
                    msg('资金余额不能为空！');
                    return false;
                }
                if ($("#playerMoney_totalMoney").val() == null || $("#playerMoney_totalMoney").val() == '') {
                    msg('总收益不能为空！');
                    return false;
                }
                return true;
            }

            function validAddForm(){
                if ($("#playerMoney_account_add").val() == null || $("#playerMoney_account_add").val() == '') {
                    msg('资金账号不能为空！');
                    return false;
                }
                if ($("#playerMoney_businessTime_add").val() == null || $("#playerMoney_businessTime_add").val() == '') {
                    msg('时间不能为空！');
                    return false;
                }


                if ($("#playerMoney_balanceMoney_add").val() == null || $("#playerMoney_balanceMoney_add").val() == '') {
                    msg('资金余额不能为空！');
                    return false;
                }
                if ($("#playerMoney_totalMoney_add").val() == null || $("#playerMoney_totalMoney_add").val() == '') {
                    msg('总收益不能为空！');
                    return false;
                }
                return true;
            }

            function replaceFile(){
                $('#uploadEventFile').remove();
                $("#uploadEventBtn").after('<input type="file" name="file"  style="width:0px;height:0px;display: none;" id="uploadEventFile" />');
                bindFile();
            }

            function bindFile(){
                $("#uploadEventFile").bind("change", function() {

                    var uploadEventFile = $("#uploadEventFile").val();
                    if (uploadEventFile == '') {
                        msg("请择excel,再上传");
                        return;
                    } else if (uploadEventFile.lastIndexOf(".xls") < 0 || uploadEventFile.lastIndexOf(".xlsx") < 0) {//可判断以.xls和.xlsx结尾的excel
                        msg("只能上传Excel文件");
                        return;
                    } else {
                        $("#contentDiv").mask("文件上传中，请稍后...");
                        var formData = new FormData();
                        formData.append('file', $('#uploadEventFile')[0].files[0]);
                        $.ajax({
                            url : '${basePath}/playerMoney/import.shtml',
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
		</script>
	</head>
	<body data-target="#one" data-spy="scroll" id="contentDiv">
		
		<@_top.top 4/>
		<div class="container"  >
			<div class="row">
				<@_left.player 3/>
				<div class="col-md-10">
					<h2>参赛选手账户资金</h2>
					<hr>
					<form method="post" action="${basePath}/playerMoney/list.shtml" id="formId" class="form-inline">
                        <div class="col-sm-12">
                            <div class="form-group col-sm-8" form-inline>
                                <label for="bgnTime">时间</label>
								<input type="text"  class="form-control" name="bgnTime" id="bgnTime" value="${bgnTime?default('')}" placeholder="开始时间" />
								~
                                <input type="text"  class="form-control" name="endTime" id="endTime" value="${endTime?default('')}" placeholder="结束时间" />
							</div>
                            <div class="form-group col-sm-4">
                                <label for="account">资金账号</label>
                                <input type="text" class="form-control"  value="${account?default('')}"
                                       name="account" id="account" placeholder="输入资金账号" />
                            </div>
						</div>
						<div class="col-sm-12" style="margin-top: 10px;margin-bottom: 20px;">
                            <div class="form-group col-sm-7" form-inline>
                            </div>
                            <div class="form-group  col-sm-5">
                                <span class=""> <#--pull-right -->
                                    <button type="submit" class="btn btn-primary">查询</button>
                                    <a class="btn btn-success" onclick="$('#playerMoneyAddModal').modal();">添加</a>
                                    <button type="button" class="btn btn-primary" id="reComplate">计算排名</button>
                                    <form enctype="multipart/form-data" id="excelForm"   method="post" >
                                        <button class="btn btn-primary" id="uploadEventBtn"  type="button" >
                                            导入
                                        </button>
                                        <input type="file" name="file"  style="width:0px;height:0px;display: none;" id="uploadEventFile" />
                                    </form>
                                    <a href="${basePath}/file/playerMoney.xlsx">模板下载</a>
                                </span>
                            </div>
						</div>

					<table class="table table-bordered">
						<tr>
                            <th width="40">序号</th>
							<th width="100">昵称</th>
							<th width="100">姓名</th>
							<th width="100">资金账号</th>
                            <th width="100">时间</th>
                            <th width="100">资金余额</th>
                            <th width="100">总资产</th>
                            <th width="80">操作</th>
						</tr>
						<#if page?exists && page.list?size gt 0 >
							<#list page.list as it>
								<tr>
                                    <td>${it_index+1}</td>
									<td>${it.accountName!''}</td>
									<td>${it.name!''}</td>
									<td>${it.account!''}</td>
									<td>${it.businessTimeStr!''}</td>
                                    <td>${it.balanceMoney!''}</td>
                                    <td>${it.totalMoney!''}</td>
									<td>
										<#--<@shiro.hasPermission name="/playerMoney/updateById.shtml">-->
											<a href="javascript:_update('${it.id}','${it.accountName}','${it.name}','${it.account}','${it.businessTimeStr}','${it.totalMoney}','${it.balanceMoney}');"><i class="fas fa-edit normal" title="编辑" data-toggle="modal" data-target="#playerMoneyEditModal"></i></a>
										<#--</@shiro.hasPermission>-->
										<#--<@shiro.hasPermission name="/playerMoney/delById.shtml">-->
                                            	<a href="javascript:_del('${it.id}');"><i class="glyphicon glyphicon-remove" title="删除"></i></a>
										<#--</@shiro.hasPermission>-->
									</td>
								</tr>
							</#list>
						<#else>
							<tr>
								<td class="text-center danger" colspan="8">暂未发现数据</td>
							</tr>
						</#if>
					</table>
					<#if page?exists>
						<div class="pagination pull-right">
							${page.pageHtml}
						</div>
					</#if>
					</form>

                    <!--修改 -->
                    <div class="modal fade" id="playerMoneyEditModal" tabindex="-1" role="dialog" aria-labelledby="playerMoneyEditModalLabel">
                        <div class="modal-dialog" role="document" style="width: 1000px;height: 800px;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="playerMoneyEditModalLabel">资料编辑</h4>
                                </div>
                                <div class="modal-body">
                                    <form method="post" action="${basePath}/playerMoney/update.shtml" id="editForm" class="form-horizontal">
                                        <input type="hidden" name="id" id="playerMoney_id">
										<div class="form-group">
                                            <label for="player_accountName" class="col-md-2 control-label">昵称</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" id="player_accountName"  readonly="readonly" />
                                            </div>

                                            <label for="player_name" class="col-md-2 control-label">姓名</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" id="player_name"  readonly="readonly" />
                                            </div>
										</div>

                                        <div class="form-group">
                                            <label for="playerMoney_account" class="col-md-2 control-label">资金账号</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" id="playerMoney_account"  readonly="readonly" />
                                            </div>

                                            <label for="playerMoney_businessTime" class="col-md-2 control-label">交易时间</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="businessTime" id="playerMoney_businessTime"  />
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="playerMoney_balanceMoney" class="col-md-2 control-label">资金余额</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="balanceMoney" id="playerMoney_balanceMoney"  />
                                            </div>
                                            <label for="playerMoney_totalMoney" class="col-md-2 control-label">总资产</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="totalMoney" id="playerMoney_totalMoney"  />
                                            </div>
                                        </div>

									</form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" id="playerMoney_edit-remove"class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                                    <button type="button" id="playerMoney_edit_submit" class="btn btn-primary"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--添加 -->
                    <div class="modal fade" id="playerMoneyAddModal" tabindex="-1" role="dialog" aria-labelledby="playerMoneyAddModalLabel">
                        <div class="modal-dialog" role="document" style="width: 1000px;height: 800px;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="playerMoneyAddModalLabel">资料添加</h4>
                                </div>
                                <div class="modal-body">
                                    <form method="post" action="${basePath}/playerMoney/add.shtml" id="addForm" class="form-horizontal">
                                        <div class="form-group">
                                            <label for="player_accountName_add" class="col-md-2 control-label">昵称</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" id="player_accountName_add"  readonly="readonly" />
                                            </div>

                                            <label for="player_name_add" class="col-md-2 control-label">姓名</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" id="player_name_add"  readonly="readonly" />
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="playerMoney_account_add" class="col-md-2 control-label">资金账号</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" id="playerMoney_account_add" name="account"   />
                                            </div>

                                            <label for="playerMoney_businessTime_add" class="col-md-2 control-label">交易时间</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="businessTime" id="playerMoney_businessTime_add"  />
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="playerMoney_balanceMoney_add" class="col-md-2 control-label">资金余额</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="balanceMoney" id="playerMoney_balanceMoney_add"  />
                                            </div>
                                            <label for="playerMoney_totalMoney_add" class="col-md-2 control-label">总资产</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="totalMoney" id="playerMoney_totalMoney_add"  />
                                            </div>
                                        </div>

                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" id="playerMoney_add-remove"  class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                                    <button type="button" id="playerMoney_add_submit" class="btn btn-primary" disabled="disabled"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                                </div>
                            </div>
                        </div>
                    </div>

				</div>
			</div><#--/row-->
		</div>
			
	</body>
</html>