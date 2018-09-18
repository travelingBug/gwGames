<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>参赛人员列表</title>
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
        <script  src="${basePath}/js/common/laydate/laydate.dev.js"></script>
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
			function _update(id,accountName,name,idCard,businessTimeStr,sharesCode,sharesName,businessFlag,volume,price,totalMoney){
				$("#gainsInfo_id").val(id);
                $("#player_accountName").val(accountName);
                $("#player_name").val(name);
                $("#gainsInfo_idCard").val(idCard);
                $("#gainsInfo_businessTime").val(businessTimeStr);
                $("#gainsInfo_sharesCode").val(sharesCode);
                $("#gainsInfo_sharesName").val(sharesName);
                $("#gainsInfo_businessFlag").val(businessFlag);
                $("#gainsInfo_price").val(price);
                $("#gainsInfo_volume").val(volume);
                $("#gainsInfo_totalMoney").val(totalMoney);
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
                if ($("#gainsInfo_idCard").val() == null || $("#gainsInfo_idCard").val() == '') {
                    msg('身份证号码不能为空！');
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
                if ($("#gainsInfo_volume").val() == null || $("#gainsInfo_volume").val() == '') {
                    msg('交易数量不能为空！');
                    return false;
                }
                if ($("#gainsInfo_totalMoney").val() == null || $("#gainsInfo_totalMoney").val() == '') {
                    msg('总收益不能为空！');
                    return false;
                }
                return true;
            }

            function validAddForm(){
                if ($("#gainsInfo_idCard_add").val() == null || $("#gainsInfo_idCard_add").val() == '') {
                    msg('身份证号码不能为空！');
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
                if ($("#gainsInfo_volume_add").val() == null || $("#gainsInfo_volume_add").val() == '') {
                    msg('交易数量不能为空！');
                    return false;
                }
                if ($("#gainsInfo_totalMoney_add").val() == null || $("#gainsInfo_totalMoney_add").val() == '') {
                    msg('总收益不能为空！');
                    return false;
                }
                return true;
            }

            function replaceFile(){
                $('#uploadEventFile').remove();
                $("#uploadEventBtn").after('<input type="file" name="file"  style="width:0px;height:0px;" id="uploadEventFile" />');
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
                                    skin: 'layui-layer-lan'
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
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;" >
			<div class="row">
				<@_left.player 2/>
				<div class="col-md-10">
					<h2>参赛选手数据表</h2>
					<hr>
					<form method="post" action="${basePath}/gainsInfo/list.shtml" id="formId" class="form-inline">
                        <div class="col-sm-12">
                            <div class="form-group col-sm-8" form-inline>
                                <label for="bgnTime">交易时间</label>
								<input type="text"  class="form-control" name="bgnTime" id="bgnTime" placeholder="开始时间" />
								~
                                <input type="text"  class="form-control" name="endTime" id="endTime" placeholder="结束时间" />
							</div>
                            <div class="form-group col-sm-4">
                                <label for="idCard">身份证号</label>
                                <input type="text" class="form-control"  value="${idCard?default('')}"
                                       name="idCard" id="idCard" placeholder="输入身份证号" />
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
                                    <a class="btn btn-success" onclick="$('#gainsInfoAddModal').modal();">增加选手资料</a>
                                    <form enctype="multipart/form-data" id="excelForm"   method="post" >
                                        <button class="btn btn-primary" id="uploadEventBtn"  type="button" >导入选手数据</button>
                                        <input type="file" name="file"  style="width:0px;height:0px;display: none;" id="uploadEventFile" />
                                    </form>
                                </span>
                            </div>
						</div>

					<table class="table table-bordered">
						<tr>
							<th><input type="checkbox" id="checkAll"/></th>
							<th>昵称</th>
							<th>姓名</th>
							<th>身份证</th>
                            <th>交易时间</th>
							<th>股票代码</th>
							<th>股票名称</th>
							<th>买卖标致</th>
                            <th>成交量</th>
                            <th>成交价格</th>
                            <th>总资产</th>
                            <th>操作</th>
						</tr>
						<#if page?exists && page.list?size gt 0 >
							<#list page.list as it>
								<tr>
									<td><input value="${it.id}" check='box' type="checkbox" /></td>
									<td>${it.accountName}</td>
									<td>${it.name}</td>
									<td>${it.idCard}</td>
									<td>${it.businessTimeStr}</td>
                                    <td>${it.sharesCode}</td>
                                    <td>${it.sharesName}</td>
									<td>
										<#if it.businessFlag==0>
											买入
										<#elseif it.businessFlag==1>
											卖出
										</#if>
									</td>
                                    <td>${it.volume}</td>
                                    <td>${it.price}</td>
                                    <td>${it.totalMoney}</td>
									<td>
										<#--<@shiro.hasPermission name="/gainsInfo/updateById.shtml">-->
											<a href="javascript:_update('${it.id}','${it.accountName}','${it.name}','${it.idCard}','${it.businessTimeStr}','${it.sharesCode}','${it.sharesName}','${it.businessFlag}','${it.volume}','${it.price}','${it.totalMoney}');"><i class="fas fa-edit normal" title="编辑" data-toggle="modal" data-target="#gainsInfoEditModal"></i></a>
										<#--</@shiro.hasPermission>-->
										<#--<@shiro.hasPermission name="/gainsInfo/delById.shtml">-->
                                            	<a href="javascript:_del('${it.id}');"><i class="glyphicon glyphicon-remove" title="删除"></i></a>
										<#--</@shiro.hasPermission>-->
									</td>
								</tr>
							</#list>
						<#else>
							<tr>
								<td class="text-center danger" colspan="12">暂未发现数据</td>
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
                                            <label for="gainsInfo_idCard" class="col-md-2 control-label">身份证号</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" id="gainsInfo_idCard"  readonly="readonly" />
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
                                                    <option value="0">买入</option>
                                                    <option value="1">卖出</option>
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

                                            <label for="gainsInfo_totalMoney" class="col-md-2 control-label">总资产</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="totalMoney" id="gainsInfo_totalMoney"  />
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
                                            <label for="gainsInfo_idCard_add" class="col-md-2 control-label">身份证号</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" id="gainsInfo_idCard_add" name="idCard"   />
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
                                                    <option value="0">买入</option>
                                                    <option value="1">卖出</option>
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

                                            <label for="gainsInfo_totalMoney_add" class="col-md-2 control-label">总资产</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="totalMoney" id="gainsInfo_totalMoney_add"  />
                                            </div>
                                        </div>

                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" id="gainsInfo_add-remove"  class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                                    <button type="button" id="gainsInfo_add_submit" class="btn btn-primary"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                                </div>
                            </div>
                        </div>
                    </div>

				</div>
			</div><#--/row-->
		</div>
			
	</body>
</html>