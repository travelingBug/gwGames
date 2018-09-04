<!DOCTYPE html>
<html lang="zh-cn">
    <head>
        <meta charset="utf-8">
        <title>登录</title>
        <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
        <link rel="icon" href="https://open.sojson.com/favicon.ico" type="image/x-icon" />
		<link rel="shortcut icon" href="https://open.sojson.com/favicon.ico" />
        <!-- CSS -->
        <#--<link rel="stylesheet" href="http://open.sojson.com/itboy/js/itboy/app/reset.css">-->
        <#--<link rel="stylesheet" href="http://open.sojson.com/itboy/js/itboy/app/supersized.css">-->
        <#--<link rel="stylesheet" href="http://open.sojson.com/itboy/js/itboy/app/style.css"/>-->

        <link rel="stylesheet" type="text/css" href="${basePath}/css/login/normalize.css" />
        <link rel="stylesheet" type="text/css" href="${basePath}/css/login/demo.css" />
        <!--必要样式-->
        <link rel="stylesheet" type="text/css" href="${basePath}/css/login/component.css" />

        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
            <script src="http://static.supportfolios.com/js/www/html5shiv.js"></script>
        <![endif]-->
		<style>
			canvas{position: fixed; top: 0px; left: 0px; }
		</style>
    </head>

    <body id="body">
        <#--<div class="page-container">-->
            <#--<h1>Login</h1>-->
            <#--<form id="_form" action="" method="post">-->
                <#--<input type="text" name="account" class="username" placeholder="Account">-->
                <#--<input type="password" name="password" class="password" placeholder="Password">-->
                <#--<div style="text-align: left; margin-left: 10px;">-->
                <#--<label><input type="checkbox" checked="checked"  id="rememberMe"style="width: 10px; height: 10px;">记住我</label>-->
                <#--</div>-->
                <#--<button type="button" id="login">登录</button>-->
                <#--<button type="button" id="register" class="register">Register</button>-->
                <#---->
                <#--<div class="error"><span>+</span></div>-->
            <#--</form>-->
        <#--</div>-->

        <div class="container demo-1">
        <div class="content">
            <div id="large-header" class="large-header">
                <canvas id="demo-canvas"></canvas>
                <div class="logo_box">
                    <h3>欢迎你</h3>
                    <form action="#" name="f" method="post">
                        <div class="input_outer">
                            <span class="u_user"></span>
                            <input name="account" class="text username" style="color: #FFFFFF !important" type="text" placeholder="请输入账户">
                        </div>
                        <div class="input_outer">
                            <span class="us_uer"></span>
                            <input name="password" class="text password" style="color: #FFFFFF !important; position:absolute; z-index:100;"value="" type="password" placeholder="请输入密码">
                        </div>
                        <div class="mb2"><a class="act-but submit" id="login" href="javascript:;" style="color: #FFFFFF">登录</a></div>
                    </form>
                </div>
            </div>
        </div>
        </div><!-- /container -->
        <!-- Javascript -->
       <script  src="http://open.sojson.com/common/jquery/jquery1.8.3.min.js"></script>
        <script src="http://open.sojson.com/common/MD5.js"></script>
        <#--<script src="http://open.sojson.com/itboy/js/itboy/app/supersized.3.2.7.min.js"></script>-->
        <#--<script src="http://open.sojson.com/itboy/js/itboy/app/supersized-init.js"></script>-->
		<script  src="${basePath}/js/common/layer/layer.js"></script>

        <script src="${basePath}/js/login/TweenLite.min.js"></script>
        <script src="${basePath}/js/login/EasePack.min.js"></script>
        <script src="${basePath}/js/login/rAF.js"></script>
        <script src="${basePath}/js/login/demo-1.js"></script>
        <script >
			jQuery(document).ready(function() {
				try{
					var _href = window.location.href+"";
					if(_href && _href.indexOf('?kickout')!=-1){
						layer.msg('您已经被踢出，请重新登录！');
					}
				}catch(e){
					
				}
				//回车事件绑定
				document.onkeydown=function(event){
					var e = event || window.event || arguments.callee.caller.arguments[0];
					if(e && e.keyCode==13){ 
						$('#login').click();
					}
				}; 
			
				//登录操作
			    $('#login').click(function(){
			    	
			        var username = $('.username').val();
			        var password = $('.password').val();
			        if(username == '') {
			            $('.error').fadeOut('fast', function(){
			                $('.error').css('top', '27px').show();
			            });
			            $('.error').fadeIn('fast', function(){
			                $('.username').focus();
			            });
			            return false;
			        }
			        if(password == '') {
			            $('.error').fadeOut('fast', function(){
			                $('.error').css('top', '96px').show();
			            });
			            $(this).find('.error').fadeIn('fast', function(){
			                $('.password').focus();
			            });
			            return false;
			        }
			        var pswd = MD5(username +"#" + password),
			        	data = {pswd:pswd,email:username,rememberMe:$("#rememberMe").is(':checked')};
			        var load = layer.load();
			        $.post("${basePath}/u/submitLogin.shtml",data ,function(result){
			        	layer.close(load);
			    		if(result && result.status != 200){
			    			layer.msg(result.message,function(){});
			    			$('.password').val('');
			    			return;
			    		}else{
			    			layer.msg('登录成功！');
			    			setTimeout(function(){
			    				//登录返回
				    			window.location.href= result.back_url || "${basePath}/";
			    			},1000)
			    		}
			    	},"json");
			        
			    });
			    $('.page-container form .username, .page-container form .password').keyup(function(){
			        $(this).parent().find('.error').fadeOut('fast');
			    });
			    //注册
			    $("#register").click(function(){
			    	window.location.href="register.shtml";
			    });
			});
        </script>
    </body>

</html>

