<!DOCTYPE html>
<html lang="zh-cn">
<head>
<#include "../head.ftl" >
    <meta charset="utf-8" />
    <title>常见问题列表</title>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
    <link href="${basePath}/js/common/bootstrap/3.3.5/css/bootstrap.min.css?${_v}" rel="stylesheet"/>
    <link href="${basePath}/css/common/base.css?${_v}" rel="stylesheet"/>
    <link href="${basePath}/css/gwGame.css?${_v}" rel="stylesheet"/>
    <script  src="${basePath}/js/common/layer/layer.js"></script>
    <script  src="${basePath}/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script  src="${basePath}/js/shiro.demo.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
    <!-- fwb -->
    <script type="text/javascript" charset="utf-8" src="${basePath}/js/fwb/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${basePath}/js/fwb/ueditor.all.js"></script>
    <script type="text/javascript" src="${basePath}/js/fwb/lang/zh-cn/zh-cn.js"></script>


    <script >
        so.init(function(){
            //初始化全选。
            so.checkBoxInit('#checkAll','[check=box]');

            $('#problem_edit_submit').click(function(){
                var flag = validEditForm();
                if (!flag) {
                    return;
                }
                $("#answer_edit").val(UE.getEditor('myEditor1').getContent());
                var formData = new FormData($( "#editForm" )[0]);
                $.ajax({
                    type: "POST",
                    url: "/problem/update.shtml",
                    data: formData,
                    dataType: "json",
                    success: function(result) {
                        if (result && result.level != 1) {
                            msg(result.messageText);
                        } else {
                            layer.msg('编辑成功！');
                            $('#problem_edit-remove').click();
                            $('#formId').submit();
                        }
                    },
                    error: function(data) {
                        layer.alert('系统错误，请联系管理员！', {
                            icon: 2,
                            skin: 'layui-layer-lan'
                        });
                    },
                    cache : false,
                    contentType : false,
                    processData : false
                });
            });


            $('#problem_add_submit').click(function(){
                var flag = validAddForm();
                if (!flag) {
                    return;
                }
                var data = $('#addForm').serializeArray();
                $("#answer_add").val(UE.getEditor('myEditor2').getContent());
                var formData = new FormData($( "#addForm" )[0]);
                $.ajax({
                    type: "POST",
                    url: "/problem/add.shtml",
                    data: formData,
                    dataType: "json",
                    success: function(result) {
                        if (result && result.level != 1) {
                            msg(result.messageText);
                        } else {
                            layer.msg('添加成功！');
                            $('#problem_add-remove').click();
                            $('#formId').submit();
                        }
                    },
                    error: function(data) {
                        layer.alert('系统错误，请联系管理员！', {
                            icon: 2,
                            skin: 'layui-layer-lan'
                        });
                    },
                    cache : false,
                    contentType : false,
                    processData : false
                });
            });

        });
        //进入新增页面
        function problemAddBtn(){
            $("#addForm")[0].reset();
            UE.getEditor('myEditor2').setContent("");//在富文本编辑器中设置值。
            ue.reset();
            $('#addModal').modal();
        }
        //进入修改页面
        function _update(id){
            $("#problem_id").val(id);
            $.ajax({
                type: "POST",
                url: "/problem/findById.shtml",
                data: {id:id},
                dataType: "json",
                success: function(result) {
                    $("#problem_problem_edit").val(result.problem);
                    $("#problem_volume_edit").val(result.volume);
                    ue1.reset();
                    UE.getEditor('myEditor1').setContent(result.answer);//在富文本编辑器中设置值。
                    $('#problemEditModal').modal();
                },
                error: function(data) {
                    layer.alert('系统错误，请联系管理员！', {
                        icon: 2,
                        skin: 'layui-layer-lan'
                    });
                }
            });
        }

        function _del(id){
            var index =  layer.confirm("确定删除此条数据？",function(){
                var load = layer.load();

                $.ajax({
                    type: "POST",
                    url: "/problem/del.shtml",
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


        function msg(messageText){
            layer.alert(messageText, {
                icon: 0,
                skin: 'layui-layer-lan'
            });
        }


        function validEditForm(){
            if ($("#problem_problem_edit").val() == null || $("#problem_problem_edit").val() == '') {
                msg('问题不能为空！');
                return false;
            }
            return true;
        }

        function validAddForm(){
            if ($("#problem_problem_add").val() == null || $("#problem_problem_add").val() == '') {
                msg('问题不能为空！');
                return false;
            }
            return true;
        }



        //实例化编辑器
        var ue = UE.getEditor('myEditor2', {
            autoHeightEnabled: false,
            elementPathEnabled:false,
            tableDragable:false
        });

        var ue1 = UE.getEditor('myEditor1', {
            autoHeightEnabled: false,
            elementPathEnabled:false,
            tableDragable:false
        });
    </script>
</head>
<body data-target="#one" data-spy="scroll" id="contentDiv">

<@_top.top 8/>
<div class="container"  >
    <div class="row">
    <@_left.eventReport 2/>
        <div class="col-md-10">
            <h2>常见问题列表</h2>
            <hr>
            <form method="post" action="${basePath}/problem/list.shtml" id="formId" class="form-inline">
                <div class="col-sm-12" style="margin-top: 10px;margin-bottom: 20px;">
                    <div class="form-group  col-sm-4">
                        <label for="title">问题</label>
                        <input type="text" class="form-control"  value="${problem?default('')}"
                               name="problem" id="problem" placeholder="输入问题" />
                    </div>
                    <div class="form-group  col-sm-4">
						<span class=""> <#--pull-right -->
							<button type="submit" class="btn btn-primary">查询</button>
							<a class="btn btn-success" onclick="problemAddBtn();">新增</a>
						</span>
                    </div>
                </div>

                <table class="table table-bordered">
                    <tr>
                        <th width="120">问题</th>
                        <th width="120">序号</th>
                        <th width="100">发布时间</th>
                        <th width="80">操作</th>
                    </tr>
				<#if page?exists && page.list?size gt 0 >
					<#list page.list as it>
                        <tr>
                            <td>${it.problem}</td>
                            <td>${it.volume}</td>
                            <td>${it.crtTime?string("yyyy-MM-dd HH:mm:ss")}</td>
                            <td>
							<#--<@shiro.hasPermission name="/problem/updateById.shtml">-->
                                <a href="javascript:_update('${it.id}');"><i class="fas fa-edit normal" title="编辑" ></i></a>
							<#--</@shiro.hasPermission>-->
							<#--<@shiro.hasPermission name="/problem/delById.shtml">-->
                                <a href="javascript:_del('${it.id}');"><i class="glyphicon glyphicon-remove" title="删除"></i></a>
							<#--</@shiro.hasPermission>-->
                            </td>
                        </tr>
					</#list>
				<#else>
                    <tr>
                        <td class="text-center danger" colspan="10">暂未发现数据</td>
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
            <div class="modal fade" id="problemEditModal" tabindex="-1" role="dialog" aria-labelledby="problemEditModalLabel">
                <div class="modal-dialog" role="document" style="width: 1000px;height: 800px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                            <h4 class="modal-title" id="problemEditModalLabel">常见问题编辑</h4>
                        </div>
                        <div class="modal-body">
                            <form method="post" action="${basePath}/problem/update.shtml" id="editForm" class="form-horizontal" enctype="multipart/form-data">
                                <input type="hidden" name="id" id="problem_id">
                                <div class="form-group">
                                    <label for="problem_problem_edit" class="col-md-2 control-label">问题</label>
                                    <div class="col-md-4">
                                        <input type="text" class="form-control" id="problem_problem_edit"   name="problem"/>
                                    </div>

                                    <label for="problem_volume_edit" class="col-md-2 control-label">序号</label>
                                    <div class="col-md-4">
                                        <input type="text" class="form-control" id="problem_volume_edit" name="volume" value="100"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="answer_edit" class="col-md-2 control-label">答复</label>
                                    <div class="col-md-10">
                                        <input type="hidden" id="answer_edit" name="answer" datatype="*1-10000" nullmsg="请输入内容!" errormsg="内容最多10000个字符!"/>
                                        <!--style给定宽度可以影响编辑器的最终宽度-->
                                        <script type="text/plain" id="myEditor1" style="width:100%;height:360px;"></script>
                                        </div>
                                 </div>

                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" id="problem_edit-remove"class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                            <button type="button" id="problem_edit_submit" class="btn btn-primary"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                        </div>
                    </div>
                </div>
            </div>

            <!--添加 -->
            <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel">
                <div class="modal-dialog" role="document" style="width: 1000px;height: 800px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                            <h4 class="modal-title" id="addModalLabel">常见问题新增</h4>
                        </div>
                        <div class="modal-body">
                            <form method="post" action="${basePath}/problem/add.shtml" id="addForm" class="form-horizontal" enctype="multipart/form-data">
                                <div class="form-group">
                                    <label for="problem_problem_add" class="col-md-2 control-label">问题</label>
                                    <div class="col-md-4">
                                        <input type="text" class="form-control" id="problem_problem_add"   name="problem"/>
                                    </div>
    
                                    <label for="problem_volume_add" class="col-md-2 control-label">序号</label>
                                    <div class="col-md-4">
                                        <input type="text" class="form-control" id="problem_volume_add" name="volume" value="100"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="content" class="col-md-2 control-label">答复</label>
                                    <div class="col-md-10">
                                        <input type="hidden" id="answer_add" name="answer" datatype="*1-10000" nullmsg="请输入内容!" errormsg="内容最多10000个字符!"/>
                                        <!--style给定宽度可以影响编辑器的最终宽度-->
                                        <script type="text/plain" id="myEditor2" style="width:100%;height:360px;"></script>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" id="problem_add-remove"  class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                            <button type="button" id="problem_add_submit" class="btn btn-primary"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div><#--/row-->
</div>

</body>
</html>