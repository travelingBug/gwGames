<!DOCTYPE html>
<html lang="zh-cn">
<head>
<#include "../head.ftl" >
    <meta charset="utf-8" />
    <title>首页配置</title>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
    <link href="${basePath}/js/common/bootstrap/3.3.5/css/bootstrap.min.css?${_v}" rel="stylesheet"/>
    <link href="${basePath}/css/common/base.css?${_v}" rel="stylesheet"/>
    <link href="${basePath}/css/gwGame.css?${_v}" rel="stylesheet"/>
    <script  src="${basePath}/js/common/layer/layer.js"></script>
    <script  src="${basePath}/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script  src="${basePath}/js/shiro.demo.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
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

            $('#homeConfig_edit_submit').click(function(){
                var flag = validEditForm();
                if (!flag) {
                    return;
                }
                var formData = new FormData($( "#editForm" )[0]);
                $.ajax({
                    type: "POST",
                    url: "/homeConfig/update.shtml",
                    data: formData,
                    dataType: "json",
                    success: function(result) {
                        if (result && result.level != 1) {
                            msg(result.messageText);
                        } else {
                            layer.msg('编辑成功！');
                            $('#homeConfig_edit-remove').click();
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


            $('#homeConfig_add_submit').click(function(){
                var flag = validAddForm();
                if (!flag) {
                    return;
                }
                var data = $('#addForm').serializeArray();
                var formData = new FormData($( "#addForm" )[0]);
                $.ajax({
                    type: "POST",
                    url: "/homeConfig/add.shtml",
                    data: formData,
                    dataType: "json",
                    success: function(result) {
                        if (result && result.level != 1) {
                            msg(result.messageText);
                        } else {
                            layer.msg('添加成功！');
                            $('#homeConfig_add-remove').click();
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
            $('#addModal').modal();
        }
        //进入修改页面
        function _update(id){
            $("#homeConfig_id").val(id);
            $.ajax({
                type: "POST",
                url: "/homeConfig/findById.shtml",
                data: {id:id},
                dataType: "json",
                success: function(result) {
                    if(result.imgPath!=null&&result.imgPath!=''){
                        $("img[myid='imghead_edit']").attr("src",result.imgPath);
                    }else{
                        $("img[myid='imghead_edit']").attr("src","/images/default_img.jpg");
                    }
                    $("#report_title_edit").val(result.title);
                    $("#report_pathFlag_edit").val(result.pathFlag);
                    $("#report_url_edit").val(result.url);
                    $("#report_volume_edit").val(result.volume);
                    $('#homeConfigEditModal').modal();
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
                    url: "/homeConfig/del.shtml",
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
            if ($("#report_volume_edit").val() == null || $("#report_volume_edit").val() == '') {
                msg('序号不能为空！');
                return false;
            }

            return true;
        }

        function validAddForm(){
            if ($("#report_title_add").val() == null || $("#report_title_add").val() == '') {
                msg('标题不能为空！');
                return false;
            }

            if ($("#report_volume_add").val() == null || $("#report_volume_add").val() == '') {
                msg('序号不能为空！');
                return false;
            }
            return true;
        }


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

<@_top.top 9/>
<div class="container"  >
    <div class="row">
	<@_left.stopdate 2/>
        <div class="col-md-10">
            <h2>首页配置</h2>
            <hr>
            <form method="post" action="${basePath}/homeConfig/list.shtml" id="formId" class="form-inline">
                <div class="col-sm-12" style="margin-top: 10px;margin-bottom: 20px;">
                    <div class="form-group  col-sm-4">
                        <label for="title">标题</label>
                        <input type="text" class="form-control"  value="${title?default('')}"
                               name="title" id="title" placeholder="输入标题" />
                    </div>
                    <div class="form-group  col-sm-4">
                        <label for="title">位置</label>
                        <select name="pathFlag" class="form-control">
                            <option value=""></option>
                            <option value="0">首页横幅</option>
                            <option value="1">首页广告位</option>
                            <option value="2">底部广告位</option>
                            <option value="3">移动端横幅</option>
                        </select>
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
                        <th width="120">显示位置</th>
                        <th width="120">链接地址</th>
                        <th width="100">发布时间</th>
                        <th width="80">操作</th>
                    </tr>
				<#if page?exists && page.list?size gt 0 >
					<#list page.list as it>
                        <tr>
                            <td>${it.title}</td>
                            <td>${it.volume}</td>
                            <td>
                                <#if it.pathFlag==0>
                                    首页横幅
                                <#elseif it.pathFlag==1>
                                    首页广告位
                                <#elseif it.pathFlag==2>
                                    底部广告位
                                <#elseif it.pathFlag==3>
                                    移动端横幅
                                </#if>
                            </td>
                            <td>${it.url}</td>
                            <td>${it.crtTime?string("yyyy-MM-dd HH:mm:ss")}</td>
                            <td>
							<#--<@shiro.hasPermission name="/homeConfig/updateById.shtml">-->
                                <a href="javascript:_update('${it.id}');"><i class="fas fa-edit normal" title="编辑" ></i></a>
							<#--</@shiro.hasPermission>-->
							<#--<@shiro.hasPermission name="/homeConfig/delById.shtml">-->
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
            <div class="modal fade" id="homeConfigEditModal" tabindex="-1" role="dialog" aria-labelledby="homeConfigEditModalLabel">
                <div class="modal-dialog" role="document" style="width: 1000px;height: 800px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                            <h4 class="modal-title" id="homeConfigEditModalLabel">首页配置编辑</h4>
                        </div>
                        <div class="modal-body">
                            <form method="post" action="${basePath}/homeConfig/update.shtml" id="editForm" class="form-horizontal" enctype="multipart/form-data">
                                <input type="hidden" name="id" id="homeConfig_id">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-4" for="report_imgPath_edit">图片</label>
                                            <div class="col-md-8">
                                                <div id="preview">
                                                    <img myid="imghead_edit" class="imgylclass" src='/images/default_img.jpg' >
                                                </div>
                                                <span class="btn green fileinput-button" style="margin: 0;">
                                                    <i class="fa fa-plus"></i>
                                                    <span>选择图片</span>
                                                    <input name="file" type="file" onchange="previewImage(this,'imghead_edit')" class="myfileclass" id="report_imgPath_edit"/>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="report_title_edit" class="col-md-2 control-label">链接</label>
                                            <div class="col-md-10">
                                                <input type="text" class="form-control" id="report_url_edit" name="url"/>
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
                                            <label for="report_pathFlag_edit" class="col-md-2 control-label">位置</label>
                                            <div class="col-md-10">
                                                <select name="pathFlag" class="form-control" id="report_pathFlag_edit">
                                                    <option value="0">首页横幅</option>
                                                    <option value="1">首页广告位</option>
                                                    <option value="2">底部广告位</option>
                                                    <option value="3">移动端横幅</option>
                                                </select>
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
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <span style="color: red;">
                                                     注意：<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、首页横幅页面只会展示前3张，展示顺序为：序列从小到大，创建时间从大到小取值(图片建议大小：1440*300)。
                                                        <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、首页广告位只会展示1张，展示顺序为：序列从小到大，创建时间从大到小取值(图片建议大小：1000*190)。
                                                        <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、底部广告位只会展示1张，展示顺序为：序列从小到大，创建时间从大到小取值(图片建议大小：1440*280)。
                                                    <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4、移动端横幅页面只会展示前3张，展示顺序为：序列从小到大，创建时间从大到小取值(图片建议大小：1125*540)。

                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" id="homeConfig_edit-remove"class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                            <button type="button" id="homeConfig_edit_submit" class="btn btn-primary"><i class="fas fa-save normal"></i>&nbsp;保存</button>
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
                            <h4 class="modal-title" id="addModalLabel">首页配置新增</h4>
                        </div>
                        <div class="modal-body">
                            <form method="post" action="${basePath}/homeConfig/add.shtml" id="addForm" class="form-horizontal" enctype="multipart/form-data">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-4" for="report_title_add">图片</label>
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
                                            <label for="report_title_edit" class="col-md-2 control-label">链接</label>
                                            <div class="col-md-10">
                                                <input type="text" class="form-control" id="report_url_add" name="url"/>
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
                                            <label for="report_pathFlag_add" class="col-md-2 control-label">位置</label>
                                            <div class="col-md-10">
                                                <select name="pathFlag" class="form-control" id="report_pathFlag_add">
                                                    <option value="0">首页横幅</option>
                                                    <option value="1">首页广告位</option>
                                                    <option value="2">底部广告位</option>
                                                    <option value="3">移动端横幅</option>
                                                </select>
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
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <span style="color: red;">
                                                    注意：<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、首页横幅页面只会展示前3张，展示顺序为：序列从小到大，创建时间从大到小取值(图片建议大小：1440*380)。
                                                        <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、首页广告位只会展示1张，展示顺序为：序列从小到大，创建时间从大到小取值(图片建议大小：1000*190)。
                                                        <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、底部广告位只会展示1张，展示顺序为：序列从小到大，创建时间从大到小取值(图片建议大小：1440*280)。
                                                        <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4、移动端横幅页面只会展示前3张，展示顺序为：序列从小到大，创建时间从大到小取值(图片建议大小：1125*540)。
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" id="homeConfig_add-remove"  class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                            <button type="button" id="homeConfig_add_submit" class="btn btn-primary"><i class="fas fa-save normal"></i>&nbsp;保存</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div><#--/row-->
</div>

</body>
</html>