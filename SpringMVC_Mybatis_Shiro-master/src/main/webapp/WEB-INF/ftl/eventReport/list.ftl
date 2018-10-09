<!DOCTYPE html>
<html lang="zh-cn">
<head>
<#include "../head.ftl" >
    <meta charset="utf-8" />
    <title>赛事报道列表</title>
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
    <style>
        .myfileclass{
            height: auto;top: 0px;right: 0px;margin: 0px;opacity: 0;font-size: 23px; direction: ltr;cursor: pointer; width:100%;  margin-top: -34px;
        }
        .green{background: green;border-radius:0px;color: #ffffff;}
        .imgylclass{
            height: 145px;width:100%;border:0;
        }
        .btn.focus, .btn:focus, .btn:hover {
            color: #ffffff;
            text-decoration: none;
        }
        .btn > i{font-size: 12px;}
    </style>


    <script >
        so.init(function(){
            //初始化全选。
            so.checkBoxInit('#checkAll','[check=box]');

            $('#eventReport_edit_submit').click(function(){
                var flag = validEditForm();
                if (!flag) {
                    return;
                }
                $("#edit_content").val(UE.getEditor('myEditor1').getContent());
                var formData = new FormData($( "#editForm" )[0]);
                $.ajax({
                    type: "POST",
                    url: "/eventReport/update.shtml",
                    data: formData,
                    dataType: "json",
                    success: function(result) {
                        if (result && result.level != 1) {
                            msg(result.messageText);
                        } else {
                            layer.msg('编辑成功！');
                            $('#eventReport_edit-remove').click();
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


            $('#eventReport_add_submit').click(function(){
                var flag = validAddForm();
                if (!flag) {
                    return;
                }
                var data = $('#addForm').serializeArray();
                $("#content").val(UE.getEditor('myEditor2').getContent());
                var formData = new FormData($( "#addForm" )[0]);
                $.ajax({
                    type: "POST",
                    url: "/eventReport/add.shtml",
                    data: formData,
                    dataType: "json",
                    success: function(result) {
                        if (result && result.level != 1) {
                            msg(result.messageText);
                        } else {
                            layer.msg('添加成功！');
                            $('#eventReport_add-remove').click();
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
        function reportAddBtn(){
            $("#addForm")[0].reset();
            $("img[myid='imghead']").attr("src","/images/default_img.jpg");
            UE.getEditor('myEditor2').setContent("");//在富文本编辑器中设置值。
            ue.reset();
            $('#addModal').modal();
        }
        //进入修改页面
        function _update(id){
            $("#eventReport_id").val(id);
            $.ajax({
                type: "POST",
                url: "/eventReport/findById.shtml",
                data: {id:id},
                dataType: "json",
                success: function(result) {
                    if(result.cover!=null&&result.cover!=''){
                        $("img[myid='imghead_edit']").attr("src",result.cover);
                    }else{
                        $("img[myid='imghead_edit']").attr("src","/images/default_img.jpg");
                    }
                    $("#report_title_edit").val(result.title);
                    $("#report_described_edit").val(result.described);
                    $("#report_volume_edit").val(result.volume);
                    ue1.reset();
                    UE.getEditor('myEditor1').setContent(result.content);//在富文本编辑器中设置值。
                    $('#eventReportEditModal').modal();
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
                    url: "/eventReport/del.shtml",
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
            if ($("#report_title_edit").val() == null || $("#report_title_edit").val() == '') {
                msg('标题不能为空！');
                return false;
            }
            if ($("#report_described_add").val() == null || $("#report_described_edit").val() == '') {
                msg('简介不能为空！');
                return false;
            }
            return true;
        }

        function validAddForm(){
            if ($("#report_title_add").val() == null || $("#report_title_add").val() == '') {
                msg('标题不能为空！');
                return false;
            }
            if ($("#report_described_add").val() == null || $("#report_described_add").val() == '') {
                msg('简介不能为空！');
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
        //图片本地预览
        function previewImage(file,targetid){
            if(checkPic(file)){
                var MAXWIDTH  = 200;
                var MAXHEIGHT = 120;
                var img =$(file).parents("form").first().find("img[myid='"+targetid+"']")[0];
                if (file.files && file.files[0]){
                    img.onload = function(){
                        img.width =MAXWIDTH;
                        img.height = MAXHEIGHT;
                    }
                    var reader = new FileReader();
                    reader.onload = function(evt){img.src = evt.target.result;}
                    reader.readAsDataURL(file.files[0]);
                }else{
                    var sFilter='filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';
                    file.select();
                    var src = document.selection.createRange().text;
                    img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
                    div.innerHTML = "<div id=divhead style='width:"+MAXWIDTH+"px;height:"+MAXHEIGHT+"px;"+sFilter+src+"\"'></div>";
                }
            }
        }
        //图片选择格式限制
        function checkPic(obj) {
            var pass =$(obj)[0];
            var picPath = pass.value;
            var type = picPath.substring(picPath.lastIndexOf(".") + 1, picPath.length).toLowerCase();
            if (type != "jpg" && type != "bmp" && type != "png") {
                pass.setCustomValidity("请上传正确的图片格式");
                alert("请上传正确的图片格式");
                var file =$(obj) ;
                file.after(file.clone().val(""));
                file.remove();
                return false;
            }else{
                pass.setCustomValidity('');
                return true;
            }
        }
    </script>
</head>
<body data-target="#one" data-spy="scroll" id="contentDiv">

<@_top.top 8/>
<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;" >
    <div class="row">
	<@_left.eventReport 1/>
        <div class="col-md-10">
            <h2>赛事报道列表</h2>
            <hr>
            <form method="post" action="${basePath}/eventReport/list.shtml" id="formId" class="form-inline">
                <div class="col-sm-12" style="margin-top: 10px;margin-bottom: 20px;">
                    <div class="form-group  col-sm-4">
                        <label for="title">标题</label>
                        <input type="text" class="form-control"  value="${title?default('')}"
                               name="title" id="title" placeholder="输入标题" />
                    </div>
                    <div class="form-group  col-sm-4">
						<span class=""> <#--pull-right -->
							<button type="submit" class="btn btn-primary">查询</button>
							<a class="btn btn-success" onclick="reportAddBtn();">新增</a>
						</span>
                    </div>
                </div>

                <table class="table table-bordered">
                    <tr>
                        <th width="120">标题</th>
                        <th width="120">序号</th>
                        <th width="100">发布时间</th>
                        <th width="80">操作</th>
                    </tr>
				<#if page?exists && page.list?size gt 0 >
					<#list page.list as it>
                        <tr>
                            <td>${it.title}</td>
                            <td>${it.volume}</td>
                            <td>${it.crtTime?string("yyyy-MM-dd HH:mm:ss")}</td>
                            <td>
							<#--<@shiro.hasPermission name="/eventReport/updateById.shtml">-->
                                <a href="javascript:_update('${it.id}');"><i class="fas fa-edit normal" title="编辑" ></i></a>
							<#--</@shiro.hasPermission>-->
							<#--<@shiro.hasPermission name="/eventReport/delById.shtml">-->
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
            <div class="modal fade" id="eventReportEditModal" tabindex="-1" role="dialog" aria-labelledby="eventReportEditModalLabel">
                <div class="modal-dialog" role="document" style="width: 1000px;height: 800px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                            <h4 class="modal-title" id="eventReportEditModalLabel">赛事报道编辑</h4>
                        </div>
                        <div class="modal-body">
                            <form method="post" action="${basePath}/eventReport/update.shtml" id="editForm" class="form-horizontal" enctype="multipart/form-data">
                                <input type="hidden" name="id" id="eventReport_id">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-4" for="report_cover_edit">封面</label>
                                            <div class="col-md-8">
                                                <div id="preview">
                                                    <img myid="imghead_edit" class="imgylclass" src='/images/default_img.jpg' >
                                                </div>
                                                <span class="btn green fileinput-button" style="margin: 0;">
                                                    <i class="fa fa-plus"></i>
                                                    <span>选择图片</span>
                                                    <input name="file" type="file" onchange="previewImage(this,'imghead_edit')" class="myfileclass" id="report_cover_edit"/>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="report_title_edit" class="col-md-2 control-label">标题</label>
                                            <div class="col-md-10">
                                                <input type="text" class="form-control" id="report_title_edit" name="title"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="report_described_edit" class="col-md-2 control-label">简介</label>
                                            <div class="col-md-10">
                                                <textarea   class="form-control" id="report_described_edit" name="described" rows="3"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="report_volume_edit" class="col-md-2 control-label">序号</label>
                                            <div class="col-md-10">
                                                <input type="text" class="form-control" id="report_volume_edit" name="volume" value="100"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="content" class="col-md-2 control-label">内容</label>
                                    <div class="col-md-10">
                                        <input type="hidden" id="edit_content" name="content" datatype="*1-10000" nullmsg="请输入内容!" errormsg="内容最多10000个字符!"/>
                                        <!--style给定宽度可以影响编辑器的最终宽度-->
                                        <script type="text/plain" id="myEditor1" style="width:100%;height:360px;"></script>
                                        </div>
                                 </div>

                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" id="eventReport_edit-remove"class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                            <button type="button" id="eventReport_edit_submit" class="btn btn-primary"><i class="fas fa-save normal"></i>&nbsp;保存</button>
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
                            <h4 class="modal-title" id="addModalLabel">赛事报道新增</h4>
                        </div>
                        <div class="modal-body">
                            <form method="post" action="${basePath}/eventReport/add.shtml" id="addForm" class="form-horizontal" enctype="multipart/form-data">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-4" for="report_title_add">封面</label>
                                            <div class="col-md-8">
                                                <div id="preview">
                                                    <img myid="imghead" class="imgylclass" src='/images/default_img.jpg' >
                                                </div>
                                                <span class="btn green fileinput-button" style="margin: 0;">
                                                    <i class="fa fa-plus"></i>
                                                    <span>选择图片</span>
                                                    <input name="file" type="file" onchange="previewImage(this,'imghead')" class="myfileclass" id="report_cover_add"/>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="report_title_add" class="col-md-2 control-label">标题</label>
                                            <div class="col-md-10">
                                                <input type="text" class="form-control" id="report_title_add" name="title"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="report_described_add" class="col-md-2 control-label">简介</label>
                                            <div class="col-md-10">
                                                <textarea   class="form-control" id="report_described_add" name="described" rows="3"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="report_volume_add" class="col-md-2 control-label">序号</label>
                                            <div class="col-md-10">
                                                <input type="text" class="form-control" id="report_volume_add" name="volume" value="100"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="content" class="col-md-2 control-label">内容</label>
                                    <div class="col-md-10">
                                        <input type="hidden" id="content" name="content" datatype="*1-10000" nullmsg="请输入内容!" errormsg="内容最多10000个字符!"/>
                                        <!--style给定宽度可以影响编辑器的最终宽度-->
                                        <script type="text/plain" id="myEditor2" style="width:100%;height:360px;"></script>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" id="eventReport_add-remove"  class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                            <button type="button" id="eventReport_add_submit" class="btn btn-primary"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div><#--/row-->
</div>

</body>
</html>