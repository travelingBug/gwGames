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
                var stopFlag = '${vo.stopFlag}';
                if (stopFlag == 1) {
                    $('#stopFlag').attr("checked","checked");
                }
			    $('#save').click(function (){
                    var stopFlag = 0;
                    if($('#stopFlag').is(':checked')) {
                        stopFlag = 1;
                    }
                    if (stopFlag == 1) {
                        layer.confirm("停止计时后，会员将不会扣除观赛时间，确认是否继续？",function(){
                            submitFlag(stopFlag);
                        });
                    } else {
                        layer.confirm("结束停止计时后，会员将会扣除观赛时间，确认是否继续？",function(){
                            submitFlag(stopFlag);
                        });
                    }
                });

			});

			function submitFlag(stopFlag) {

                $.ajax({
                    url : '${basePath}/stopdate/update.shtml',
                    type : 'post',
                    data : {stopFlag:stopFlag},
                    dataType : "json",
                    success : function(result) {
                        layer.msg(result.messageText);
                    },
                    error : function(result) {
                        layer.alert('系统错误，请联系管理员！', {
                            icon: 0,
                            skin: 'layui-layer-lan'
                        });
                    }
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
					<h2>系统配置</h2>
					<hr>
                    <div class="col-sm-12">
                        <div class="form-group col-sm-4" form-inline>
                            <label for="stopFlag">停止会员记时</label>
					        <input type="checkbox"   name="stopFlag" id="stopFlag" value="1" />
						</div>
                        <div class="form-group col-sm-4" form-inline>
                            <label style="color: red">注意：一旦启用后，所有购买观赛券的会员将不会扣除剩余时间!</label>
                        </div>
					</div>
                    <div class="col-sm-12" >
                        <div class="form-group col-sm-4" form-inline>
                        </div>
                        <div class="form-group  col-sm-4">
                            <span class=""> <#--pull-right -->
                                <button type="button" id="save" class="btn btn-primary">保存</button>
                            </span>
                        </div>
                    </div>
				</div>

			</div><#--/row-->
		</div>
			
	</body>
</html>