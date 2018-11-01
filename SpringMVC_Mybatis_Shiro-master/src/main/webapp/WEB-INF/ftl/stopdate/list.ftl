<!DOCTYPE html>
<html lang="zh-cn">
	<head>
    <#include "../head.ftl" >
		<meta charset="utf-8" />
		<title>系统设置</title>
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
                laydate({
                    elem: '#bgnTime',
                    istime:true,
                    format:'YYYY-MM-DD'
                });
                laydate({
                    elem: '#endTime',
                    istime:true,
                    format:'YYYY-MM-DD'
                });


                $('#stopdate_add_submit').click(function(){
                    var flag = validAddForm();
                    if (!flag) {
                        return;
                    }
                    var data = [];
                    data.push({name:'bgnTime',value:new Date(($('#bgnTime').val() + " 00:00:00").replace("-", "/").replace("-", "/"))});
                    data.push({name:'endTime',value:new Date(($('#endTime').val() + " 23:59:59").replace("-", "/").replace("-", "/"))});
                    $.ajax({
                        type: "POST",
                        url: "/stopdate/insert.shtml",
                        data: data,
                        dataType: "json",
                        success: function(result) {
                            if (result && result.level != 1) {
                                msg(result.messageText);
                            } else {
                                layer.msg('添加成功！');
                                $('#stopdate_add-remove').click();
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
			});

            function validAddForm(){
                if ($("#bgnTime").val() == null || $("#bgnTime").val() == '') {
                    msg('开始时间不能为空！');
                    return false;
                }
                if ($("#endTime").val() == null || $("#endTime").val() == '') {
                    msg('结束时间不能为空！');
                    return false;
                }
                return true;
            }

            function msg(messageText){
                layer.alert(messageText, {
                    icon: 0,
                    skin: 'layui-layer-lan'
                });
            }

            function _del(id){
                var index =  layer.confirm("确定删除此条数据？",function(){
                    var load = layer.load();

                    $.ajax({
                        type: "POST",
                        url: "/stopdate/del.shtml",
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

		</script>
	</head>
	<body data-target="#one" data-spy="scroll" id="contentDiv">
		
		<@_top.top 9/>
        <div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;" >
            <div class="row">
            <@_left.stopdate 1/>
                <div class="col-md-10">
                    <h2>停止计时时间段</h2>
                    <hr>
                    <form method="post" action="${basePath}/stopdate/list.shtml" id="formId" class="form-inline">
                        <div class="col-sm-12">
                            <div class="form-group col-sm-4">
                                <label for="userName">操作人姓名</label>
                                <input type="text" class="form-control"  value="${userName?default('')}"
                                       name="userName" id="userName" placeholder="请输入操作人姓名" />
                            </div>

                            <div class="form-group  col-sm-4">
                                <span class=""> <#--pull-right -->
                                    <button type="submit" class="btn btn-primary">查询</button>
                                    <a class="btn btn-success" onclick="$('#stopdateAddModal').modal();">添加</a>
                                </span>
                            </div>
                        </div>

                        <table class="table table-bordered" style="margin-top: 20px;">
                            <tr>
                                <th width="50">序号</th>
                                <th width="120">操作人姓名</th>
                                <th width="180">创建时间</th>
                                <th width="100">开始时间</th>
                                <th width="100">结束时间</th>
                                <th width="80">操作</th>
                            </tr>
                        <#if page?exists && page.list?size gt 0 >
                            <#list page.list as it>
                                <tr>

                                    <td> ${it_index+1}</td>
                                    <td>${it.userName}</td>
                                    <td>${it.crtTime?string("yyyy-MM-dd HH:mm:ss")}</td>
                                    <td>${it.bgnTime?string("yyyy-MM-dd")}</td>
                                    <td>${it.endTime?string("yyyy-MM-dd")}</td>
                                    <td>
                                        <a href="javascript:_del('${it.id}');"><i class="glyphicon glyphicon-remove" title="删除"></i></a>
                                    </td>
                                </tr>
                            </#list>
                        <#else>
                            <tr>
                                <td class="text-center danger" colspan="6">暂未发现数据</td>
                            </tr>
                        </#if>
                        </table>
                    <#if page?exists>
                        <div class="pagination pull-right">
                        ${page.pageHtml}
                        </div>
                    </#if>
                    </form>

                    <!--添加 -->
                    <div class="modal fade" id="stopdateAddModal" tabindex="-1" role="dialog" aria-labelledby="stopdateAddModalLabel">
                        <div class="modal-dialog" role="document" style="width: 1000px;height: 800px;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                    <h4 class="modal-title" id="stopdateAddModalLabel">添加</h4>
                                </div>
                                <div class="modal-body">
                                    <form method="post" action="${basePath}/stopdate/insert.shtml" id="addForm" class="form-horizontal">
                                        <div class="form-group">
                                            <label for="player_accountName_add" class="col-md-2 control-label">开始时间</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" id="bgnTime"  name="bgnTime" />
                                            </div>

                                            <label for="player_name_add" class="col-md-2 control-label">结束时间</label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" id="endTime"  name="endTime" />
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                <span style="color: red;">
                                                     注意：添加时间范围后，如果到达时间后，会员的观赛日期将不会被减少。
                                                </span>
                                                </div>
                                            </div>
                                        </div>

                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" id="stopdate_add-remove"  class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                                    <button type="button" id="stopdate_add_submit" class="btn btn-primary" ><i class="fas fa-save normal"></i>&nbsp;保存</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div><#--/row-->
        </div>
			
	</body>
</html>