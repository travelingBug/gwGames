<!DOCTYPE html>
<html lang="zh-cn">
	<head>
        <#include "../head.ftl" >
		<meta charset="utf-8" />
		<title>参赛人员列表</title>
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
                    elem: '#gainsInfo_businessTime',
                    istime:true,
                    format:'YYYY-MM-DD hh:mm:ss'
                });

                laydate({
                    elem: '#gainsInfo_businessTime_add',
                    istime:true,
                    format:'YYYY-MM-DD hh:mm:ss'
                });

                $('#gainsInfo_edit_submit').click(function(){
                    var flag = validEditForm();
                    if (!flag) {
                        return;
                    }
                    var data = $('#editForm').serializeArray();
                    var businessTimeDate = getDate($('#gainsInfo_businessTime').val());
                    $.each(data, function(i, field){
                        if (field.name == "businessTime") {
                            field.value = businessTimeDate;
                        }
                    });
                    $.ajax({
                        type: "POST",
                        url: "/gainsInfo/update.shtml",
                        data: data,
                        dataType: "json",
                        success: function(result) {
                            if (result && result.level != 1) {
                                msg(result.messageText);
                            } else {
                                layer.msg('编辑成功！');
                                $('#gainsInfo_edit-remove').click();
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


                $('#gainsInfo_add_submit').click(function(){
                    var flag = validAddForm();
                    if (!flag) {
                        return;
                    }
                    var data = $('#addForm').serializeArray();
                    var businessTimeDate = getDate($('#gainsInfo_businessTime_add').val());
                    $.each(data, function(i, field){
                        if (field.name == "businessTime") {
                            field.value = businessTimeDate;
                        }
                    });
                    $.ajax({
                        type: "POST",
                        url: "/gainsInfo/add.shtml",
                        data: data,
                        dataType: "json",
                        success: function(result) {
                            if (result && result.level != 1) {
                                msg(result.messageText);
                            } else {
                                layer.msg('添加成功！');
                                $('#gainsInfo_add-remove').click();
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

                $("#gainsInfo_account_add").unbind('blur').bind('blur',function(event){
                    event.stopPropagation();
                    var accountName = $("#gainsInfo_account_add").val();
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
                                    $('#gainsInfo_add_submit').attr("disabled","disabled");
                                } else {
                                    $("#player_accountName_add").val(result[0].accountName);
                                    $("#player_name_add").val(result[0].name);
                                    $('#gainsInfo_add_submit').removeAttr("disabled");
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

                $("#gainsInfo_volume_add").blur(function(event){
                    event.stopPropagation();
                    complateAmount("gainsInfo_amount_add", $("#gainsInfo_volume_add").val(),$("#gainsInfo_price_add").val());
                });

                $("#gainsInfo_price_add").blur(function(event){
                    event.stopPropagation();
                    complateAmount( "gainsInfo_amount_add",$("#gainsInfo_volume_add").val(),$("#gainsInfo_price_add").val());
                });

                $("#gainsInfo_volume").blur(function(event){
                    event.stopPropagation();
                    complateAmount("gainsInfo_amount", $("#gainsInfo_volume").val(),$("#gainsInfo_price").val());
                });

                $("#gainsInfo_price").blur(function(event){
                    event.stopPropagation();
                    complateAmount("gainsInfo_amount",$("#gainsInfo_volume").val(),$("#gainsInfo_price").val());
                });



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

			function complateAmount(id,volume,price){
			    if (volume != null && volume != ""
                && price != null && price != "") {
                    $("#"+id).val((parseFloat(volume)*parseFloat(price)).toFixed(2));
                }
            }


            function _del(id){
                var index =  layer.confirm("确定删除此条数据？",function(){
                    var load = layer.load();

                    $.ajax({
                        type: "POST",
                        url: "/gainsInfo/del.shtml",
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
			function _update(id,accountName,name,account,businessTimeStr,sharesCode,sharesName,businessFlag,volume,price,amount){
				$("#gainsInfo_id").val(id);
                $("#player_accountName").val(accountName);
                $("#player_name").val(name);
                $("#gainsInfo_account").val(account);
                $("#gainsInfo_businessTime").val(businessTimeStr);
                $("#gainsInfo_sharesCode").val(sharesCode);
                $("#gainsInfo_sharesName").val(sharesName);
                $("#gainsInfo_businessFlag").val(businessFlag);
                $("#gainsInfo_price").val(price);
                $("#gainsInfo_volume").val(volume);
                $("#gainsInfo_amount").val(amount);


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
                if ($("#gainsInfo_id").val() == null || $("#gainsInfo_id").val() == ''){
                    msg('修改错误，请联系管理员处理');
                    return false;
                }
                if ($("#gainsInfo_account").val() == null || $("#gainsInfo_account").val() == '') {
                    msg('资金账号不能为空！');
                    return false;
                }
                if ($("#gainsInfo_businessTime").val() == null || $("#gainsInfo_businessTime").val() == '') {
                    msg('交易时间不能为空！');
                    return false;
                }
                if ($("#gainsInfo_sharesCode").val() == null || $("#gainsInfo_sharesCode").val() == '') {
                    msg('股票代码不能为空！');
                    return false;
                }
                if ($("#gainsInfo_sharesName").val() == null || $("#gainsInfo_sharesName").val() == '') {
                    msg('股票名称不能为空！');
                    return false;
                }
                if ($("#gainsInfo_businessFlag").val() == null || $("#gainsInfo_businessFlag").val() == '') {
                    msg('买卖标志不能为空！');
                    return false;
                }
                if ($("#gainsInfo_price").val() == null || $("#gainsInfo_price").val() == '') {
                    msg('交易价格不能为空！');
                    return false;
                }
                if ($("#gainsInfo_amount").val() == null || $("#gainsInfo_amount").val() == '') {
                    msg('资金总金额不能为空！');
                    return false;
                }

                if ($("#gainsInfo_volume").val() == null || $("#gainsInfo_volume").val() == '') {
                    msg('交易数量不能为空！');
                    return false;
                }
                return true;
            }

            function validAddForm(){
                if ($("#gainsInfo_account_add").val() == null || $("#gainsInfo_account_add").val() == '') {
                    msg('资金账号不能为空！');
                    return false;
                }
                if ($("#gainsInfo_businessTime_add").val() == null || $("#gainsInfo_businessTime_add").val() == '') {
                    msg('交易时间不能为空！');
                    return false;
                }
                if ($("#gainsInfo_sharesCode_add").val() == null || $("#gainsInfo_sharesCode_add").val() == '') {
                    msg('股票代码不能为空！');
                    return false;
                }
                if ($("#gainsInfo_sharesName_add").val() == null || $("#gainsInfo_sharesName_add").val() == '') {
                    msg('股票名称不能为空！');
                    return false;
                }
                if ($("#gainsInfo_businessFlag_add").val() == null || $("#gainsInfo_businessFlag_add").val() == '') {
                    msg('买卖标志不能为空！');
                    return false;
                }
                if ($("#gainsInfo_price_add").val() == null || $("#gainsInfo_price_add").val() == '') {
                    msg('交易价格不能为空！');
                    return false;
                }
                if ($("#gainsInfo_amount_add").val() == null || $("#gainsInfo_amount_add").val() == '') {
                    msg('资金总金额不能为空！');
                    return false;
                }


                if ($("#gainsInfo_volume_add").val() == null || $("#gainsInfo_volume_add").val() == '') {
                    msg('交易数量不能为空！');
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
                            url : '${basePath}/gainsInfo/import.shtml',
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
				<@_left.player 2/>
				<div class="col-md-10">
					<h2>参赛选手数据表</h2>
					<hr>
					<form method="post" action="${basePath}/gainsInfo/list.shtml" id="formId" class="form-inline">
                        <div class="col-sm-12">
                            <div class="form-group col-sm-8" form-inline>
                                <label for="bgnTime">交易时间</label>
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


					        <div class="form-group  col-sm-4">
                                <label for="sharesCode">股票代码</label>
                                <input type="text" class="form-control"  value="${sharesCode?default('')}"
                                     name="sharesCode" id="sharesCode" placeholder="输入股票代码" />

                            </div>
                            <div class="form-group  col-sm-4">
                                <label for="sharesName">股票名称</label>
                                <input type="text" class="form-control" value="${sharesName?default('')}"
                                       name="sharesName" id="sharesName" placeholder="输入股票名称" />
                            </div>
                            <div class="form-group  col-sm-4">
                                <span class=""> <#--pull-right -->
                                    <button type="submit" class="btn btn-primary">查询</button>
                                    <a class="btn btn-success" onclick="$('#gainsInfoAddModal').modal();">添加</a>
                                    <form enctype="multipart/form-data" id="excelForm"   method="post" >
                                        <button class="btn btn-primary" id="uploadEventBtn"  type="button" >
                                            导入
                                        </button>
                                        <input type="file" name="file"  style="width:0px;height:0px;display: none;" id="uploadEventFile" />
                                    </form>
                                    <a href="${basePath}/file/playergains.xlsx">模板下载</a>
                                </span>
                            </div>
						</div>

					<table class="table table-bordered">
						<tr>
                            <th width="50">序号</th>
							<th width="120">昵称</th>
							<th width="120">姓名</th>
							<th width="100">资金账号</th>
                            <th width="180">交易时间</th>
							<th width="100">股票代码</th>
							<th width="100">股票名称</th>
							<th width="90">买卖标致</th>
                            <th width="80">成交量</th>
                            <th width="100">成交价格</th>
                            <th width="100">成交总额</th>
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
                                    <td>${it.sharesCode!''}</td>
                                    <td>${it.sharesName!''}</td>
									<td>
										<#if it.businessFlag==0>
											证券买入
										<#elseif it.businessFlag==1>
                                            证券卖出
                                        <#elseif it.businessFlag==2>
                                            基金申购
                                        <#elseif it.businessFlag==3>
                                            基金赎回
                                        <#elseif it.businessFlag==4>
                                            融券回购
										</#if>
									</td>
                                    <td>${it.volume!''}</td>
                                    <td>${it.price!''}</td>
                                    <td>${it.amount!''}</td>
									<td>
										<#--<@shiro.hasPermission name="/gainsInfo/updateById.shtml">-->
											<a href="javascript:_update('${it.id}','${it.accountName!''}','${it.name}','${it.account}','${it.businessTimeStr}','${it.sharesCode}','${it.sharesName}','${it.businessFlag}','${it.volume}','${it.price}','${it.amount}');"><i class="fas fa-edit normal" title="编辑" data-toggle="modal" data-target="#gainsInfoEditModal"></i></a>
										<#--</@shiro.hasPermission>-->
										<#--<@shiro.hasPermission name="/gainsInfo/delById.shtml">-->
                                            	<a href="javascript:_del('${it.id}');"><i class="glyphicon glyphicon-remove" title="删除"></i></a>
										<#--</@shiro.hasPermission>-->
									</td>
								</tr>
							</#list>
						<#else>
							<tr>
								<td class="text-center danger" colspan="13">暂未发现数据</td>
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
                    <div class="modal fade" id="gainsInfoEditModal" tabindex="-1" role="dialog" aria-labelledby="gainsInfoEditModalLabel">
                        <div class="modal-dialog" role="document" style="width: 1000px;height: 800px;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="gainsInfoEditModalLabel">资料编辑</h4>
                                </div>
                                <div class="modal-body">
                                    <form method="post" action="${basePath}/gainsInfo/update.shtml" id="editForm" class="form-horizontal">
                                        <input type="hidden" name="id" id="gainsInfo_id">
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
                                            <label for="gainsInfo_account" class="col-md-2 control-label">资金账号</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" id="gainsInfo_account"  readonly="readonly" />
                                            </div>

                                            <label for="gainsInfo_businessTime" class="col-md-2 control-label">交易时间</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="businessTime" id="gainsInfo_businessTime"  />
                                            </div>
                                        </div>


                                        <div class="form-group">
                                            <label for="gainsInfo_sharesCode" class="col-md-2 control-label">股票代码</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="sharesCode" id="gainsInfo_sharesCode"  />
                                            </div>

                                            <label for="gainsInfo_sharesName" class="col-md-2 control-label">股票名称</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="sharesName" id="gainsInfo_sharesName"  />
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="gainsInfo_businessFlag" class="col-md-2 control-label">买卖标志</label>
                                            <div class="col-md-4">
                                                <select name="businessFlag" class="form-control" id="gainsInfo_businessFlag">
                                                    <option value="0">证券买入</option>
                                                    <option value="1">证券卖出</option>
                                                    <option value="2">基金申购</option>
                                                    <option value="3">基金赎回</option>
                                                    <option value="4">融券回购</option>
                                                </select>
                                            </div>

                                            <label for="gainsInfo_volume" class="col-md-2 control-label">成交量</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="volume" id="gainsInfo_volume"  />
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="gainsInfo_price" class="col-md-2 control-label">成交价格</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="price" id="gainsInfo_price"  />
                                            </div>


                                            <label for="gainsInfo_amount" class="col-md-2 control-label">成交总金额</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="amount" id="gainsInfo_amount"  />
                                            </div>

                                        </div>

									</form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" id="gainsInfo_edit-remove"class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                                    <button type="button" id="gainsInfo_edit_submit" class="btn btn-primary"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--添加 -->
                    <div class="modal fade" id="gainsInfoAddModal" tabindex="-1" role="dialog" aria-labelledby="gainsInfoAddModalLabel">
                        <div class="modal-dialog" role="document" style="width: 1000px;height: 800px;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="gainsInfoAddModalLabel">资料添加</h4>
                                </div>
                                <div class="modal-body">
                                    <form method="post" action="${basePath}/gainsInfo/add.shtml" id="addForm" class="form-horizontal">
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
                                            <label for="gainsInfo_account_add" class="col-md-2 control-label">资金账号</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" id="gainsInfo_account_add" name="account"   />
                                            </div>

                                            <label for="gainsInfo_businessTime_add" class="col-md-2 control-label">交易时间</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="businessTime" id="gainsInfo_businessTime_add"  />
                                            </div>
                                        </div>


                                        <div class="form-group">
                                            <label for="gainsInfo_sharesCode_add" class="col-md-2 control-label">股票代码</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="sharesCode" id="gainsInfo_sharesCode_add"  />
                                            </div>

                                            <label for="gainsInfo_sharesName_add" class="col-md-2 control-label">股票名称</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="sharesName" id="gainsInfo_sharesName_add"  />
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="gainsInfo_businessFlag_add" class="col-md-2 control-label">买卖标志</label>
                                            <div class="col-md-4">
                                                <select name="businessFlag" class="form-control" id="gainsInfo_businessFlag_add">
                                                    <option value="0">证券买入</option>
                                                    <option value="1">证券卖出</option>
                                                    <option value="2">基金申购</option>
                                                    <option value="3">基金赎回</option>
                                                    <option value="4">融券回购</option>
                                                </select>
                                            </div>

                                            <label for="gainsInfo_volume_add" class="col-md-2 control-label">成交量</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="volume" id="gainsInfo_volume_add"  />
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="gainsInfo_price_add" class="col-md-2 control-label">成交价格</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="price" id="gainsInfo_price_add"  />
                                            </div>

                                            <label for="gainsInfo_amount_add" class="col-md-2 control-label">成交总金额</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="amount" id="gainsInfo_amount_add"  />
                                            </div>
                                        </div>


                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" id="gainsInfo_add-remove"  class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                                    <button type="button" id="gainsInfo_add_submit" class="btn btn-primary" disabled="disabled"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                                </div>
                            </div>
                        </div>
                    </div>

				</div>
			</div><#--/row-->
		</div>
			
	</body>
</html>