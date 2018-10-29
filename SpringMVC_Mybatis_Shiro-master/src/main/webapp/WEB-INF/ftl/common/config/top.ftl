<#macro top index>

<script baseUrl="${basePath}" src="${basePath}/js/user.login.js"></script>
<script  src="${basePath}/js/common/mask/Jquery.mask.js"></script>
<script  src="${basePath}/js/common/laydate/laydate.dev.js"></script>

<div class="navbar navbar-inverse navbar-fixed-top animated fadeInDown" style="z-index: 101;height: 41px;">

      <div class="container" style="padding-left: 0px; padding-right: 0px;">
        <div class="navbar-header">
          <button data-target=".navbar-collapse" data-toggle="collapse" type="button" class="navbar-toggle collapsed">
            <span class="sr-only">导航</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
	     </div>
	     <div role="navigation" class="navbar-collapse collapse">
	     		<a id="_logo"  href="${basePath}" style="color:#fff; font-size: 24px;" class="navbar-brand hidden-sm">股神大赛后台</a>
	          <ul class="nav navbar-nav" id="topMenu">
				<li class="dropdown ${(index==1)?string('active','')}">
					<a aria-expanded="false" aria-haspopup="true" role="button" data-toggle="dropdown" class="dropdown-toggle" href="${basePath}/user/index.shtml">
						个人中心<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="${basePath}/user/index.shtml">个人资料</a></li>
						<li><a href="${basePath}/user/updateSelf.shtml" >资料修改</a></li>
						<li><a href="${basePath}/user/updatePswd.shtml" >密码修改</a></li>
						<li><a href="${basePath}/role/mypermission.shtml">我的权限</a></li>
					</ul>
				</li>	  
				<#--拥有 角色888888（管理员） ||  100002（用户中心）-->
				<@shiro.hasAnyRoles name='888888,100002,100004,100005'>
				<li class="dropdown ${(index==2)?string('active','')}">
					<a aria-expanded="false" aria-haspopup="true"  role="button" data-toggle="dropdown" class="dropdown-toggle" href="${basePath}/member/list.shtml">
						用户中心<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<@shiro.hasPermission name="/member/list.shtml">
							<li><a href="${basePath}/member/list.shtml">用户列表</a></li>
						</@shiro.hasPermission>
						<@shiro.hasPermission name="/member/online.shtml">
							<li><a href="${basePath}/member/online.shtml">在线用户</a></li>
						</@shiro.hasPermission>
					</ul>
				</li>	
				</@shiro.hasAnyRoles>         
				<#--拥有 角色888888（管理员） ||  100003（权限频道）-->
				<@shiro.hasAnyRoles name='888888,100003,100004,100005'>
					<li class="dropdown ${(index==3)?string('active','')}">
						<a aria-expanded="false" aria-haspopup="true"  role="button" data-toggle="dropdown" class="dropdown-toggle" href="${basePath}/permission/index.shtml">
							权限管理<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<@shiro.hasPermission name="/role/index.shtml">
								<li><a href="${basePath}/role/index.shtml">角色列表</a></li>
							</@shiro.hasPermission>
							<@shiro.hasPermission name="/role/allocation.shtml">
								<li><a href="${basePath}/role/allocation.shtml">角色分配</a></li>
							</@shiro.hasPermission>
							<@shiro.hasPermission name="/permission/index.shtml">
								<li><a href="${basePath}/permission/index.shtml">权限列表</a></li>
							</@shiro.hasPermission>
							<@shiro.hasPermission name="/permission/allocation.shtml">
								<li><a href="${basePath}/permission/allocation.shtml">权限分配</a></li>
							</@shiro.hasPermission>
						</ul>
					</li>	
				</@shiro.hasAnyRoles>

			  <#--拥有 角色888888（管理员） ||  100002（用户中心）-->
				  <@shiro.hasAnyRoles name='888888,100002,100004,100005'>
                      <li class="dropdown ${(index==4)?string('active','')}">
                          <a aria-expanded="false" aria-haspopup="true"  role="button" data-toggle="dropdown" class="dropdown-toggle" href="${basePath}/player/list.shtml">
                              选手管理<span class="caret"></span>
                          </a>
                          <ul class="dropdown-menu">
							  <@shiro.hasPermission name="/player/list.shtml">
                                  <li><a href="${basePath}/player/list.shtml">选手列表</a></li>
							  </@shiro.hasPermission>
							  <@shiro.hasPermission name="/gainsInfo/list.shtml">
                                  <li><a href="${basePath}/gainsInfo/list.shtml">参赛选手数据</a></li>
							  </@shiro.hasPermission>
							  <@shiro.hasPermission name="/playerMoney/list.shtml">
                                  <li><a href="${basePath}/playerMoney/list.shtml">参赛资金</a></li>
							  </@shiro.hasPermission>
                          </ul>
                      </li>
				  </@shiro.hasAnyRoles>

			      <#--拥有 角色888888（管理员）-->
				  <@shiro.hasAnyRoles name='888888,100004,100005'>
                      <li class="dropdown ${(index==5)?string('active','')}">
                          <a aria-expanded="false" aria-haspopup="true" role="button" data-toggle="dropdown" class="dropdown-toggle" href="${basePath}/dealer/list.shtml?parentId=0">
                              经销商管理<span class="caret"></span>
                          </a>
                          <ul class="dropdown-menu">
							  <@shiro.hasPermission name="/dealer/list.shtml">
                                  <li><a href="${basePath}/dealer/list.shtml?parentId=0">经销商列表</a></li>
							  </@shiro.hasPermission>
							  <@shiro.hasPermission name="/dealer/countDealerList.shtml">
                                  <li><a href="${basePath}/dealer/countDealerList.shtml">经销商会员统计</a></li>
							  </@shiro.hasPermission>
                          </ul>

                      </li>
				  </@shiro.hasAnyRoles>

			  		<#--拥有 角色200001（经销商）-->
				  <@shiro.hasAnyRoles name='200001,100004,100005'>
                      <li class="dropdown ${(index==6)?string('active','')}">
                          <a aria-expanded="false" aria-haspopup="true" role="button" data-toggle="dropdown" class="dropdown-toggle" href="${basePath}/dealer/employeeList.shtml?parentId=${userId}">
                              员工管理<span class="caret"></span>
                          </a>
                          <ul class="dropdown-menu">
							  <@shiro.hasPermission name="/dealer/employeeList.shtml">
                                  <li><a href="${basePath}/dealer/employeeList.shtml?parentId=${userId}">员工列表</a></li>
							  </@shiro.hasPermission>
							  <@shiro.hasPermission name="/dealer/countEmployeeList.shtml">
                                  <li><a href="${basePath}/dealer/countEmployeeList.shtml">员工会员统计</a></li>
							  </@shiro.hasPermission>

                          </ul>
                      </li>
				  </@shiro.hasAnyRoles>

				  <@shiro.hasAnyRoles name='888888,200001,200002,100004,100005,100006'>
                      <li class="dropdown ${(index==7)?string('active','')}">
                          <a aria-expanded="false" aria-haspopup="true" role="button" data-toggle="dropdown" class="dropdown-toggle" href="${basePath}/dealer/vipsList.shtml?parentId=${userId}">
                              会员管理<span class="caret"></span>
                          </a>
                          <ul class="dropdown-menu">
							  <@shiro.hasPermission name="/dealer/vipsList.shtml">
                                  <li><a href="${basePath}/dealer/vipsList.shtml?parentId=${userId}">会员列表</a></li>
							  </@shiro.hasPermission>
							  <@shiro.hasPermission name="/dealer/vipsRecordList.shtml">
                                  <li><a href="${basePath}/dealer/vipsRecordList.shtml?userId=${userId}">购票明细</a></li>
							  </@shiro.hasPermission>
                          </ul>
                      </li>
				  </@shiro.hasAnyRoles>

			  		<#--拥有 角色888888（管理员）-->
				  <@shiro.hasAnyRoles name='888888,100006'>
                      <li class="dropdown ${(index==8)?string('active','')}">
                          <a aria-expanded="false" aria-haspopup="true" role="button" data-toggle="dropdown" class="dropdown-toggle" href="${basePath}/eventReport/list.shtml">
                              赛事报道管理<span class="caret"></span>
                          </a>
                          <ul class="dropdown-menu">
							  <@shiro.hasPermission name="/eventReport/list.shtml">
                                  <li><a href="${basePath}/eventReport/list.shtml">赛事报道列表</a></li>
							  </@shiro.hasPermission>
							  <@shiro.hasPermission name="/problem/list.shtml">
                                  <li><a href="${basePath}/problem/list.shtml">常见问题列表</a></li>
							  </@shiro.hasPermission>
                          </ul>
                      </li>
				  </@shiro.hasAnyRoles>

			  <#--拥有 角色888888（管理员）-->
				  <@shiro.hasAnyRoles name='888888,100006'>
                      <li class="dropdown ${(index==9)?string('active','')}">
                          <a aria-expanded="false" aria-haspopup="true" role="button" data-toggle="dropdown" class="dropdown-toggle" href="${basePath}/stopdate/list.shtml">
                              系统配置<span class="caret"></span>
                          </a>
                          <ul class="dropdown-menu">
							  <@shiro.hasPermission name="/stopdate/list.shtml">
                                  <li><a href="${basePath}/stopdate/list.shtml">系统配置</a></li>
							  </@shiro.hasPermission>
							  <@shiro.hasPermission name="/homeConfig/list.shtml">
                                  <li><a href="${basePath}/homeConfig/list.shtml">首页配置</a></li>
							  </@shiro.hasPermission>
                          </ul>
                      </li>
				  </@shiro.hasAnyRoles>
			  </ul>

	           <ul class="nav navbar-nav  pull-right" >
				<li class="dropdown ${(index==10)?string('active','')}" style="color:#fff;">
					<a aria-expanded="false" aria-haspopup="true"  role="button" data-toggle="dropdown"  
						<@shiro.user>  
							onclick="location.href='${basePath}/user/index.shtml'" href="${basePath}/user/index.shtml" class="dropdown-toggle qqlogin" >
							${token.nickname?default('无')}<span class="caret"></span></a>
							<ul class="dropdown-menu" userid="${token.id}">
								<li><a href="${basePath}/user/index.shtml">个人资料</a></li>
								<li><a href="${basePath}/role/mypermission.shtml">我的权限</a></li>
								<li><a href="javascript:void(0);" onclick="logout();">退出登录</a></li>
							</ul>
						</@shiro.user>  
						<@shiro.guest>   
							 <a href="javascript:void(0);" onclick="location.href='${basePath}/u/login.shtml'" class="dropdown-toggle qqlogin" >
							<img src="http://qzonestyle.gtimg.cn/qzone/vas/opensns/res/img/Connect_logo_1.png">&nbsp;登录</a>
						</@shiro.guest>  					
				</li>	
	          </ul>
                <@shiro.hasAnyRoles name='200001,200002'>
                 <a href="javacript:;" style="color:#fff; font-size: 16px;float:right;" id="mainInviteCode" class="navbar-brand hidden-sm"></a>
                 <a href="javacript:;" style="color:#fff; font-size: 16px;float:right;" class="navbar-brand hidden-sm">
                     <i class="fas fa-link" onclick="_queryMainLink('${userId}');"></i>
                 </a>
                </@shiro.hasAnyRoles>

	          <style>#topMenu>li>a{padding:10px 13px}</style>
	    </div>
  	</div>
</div>

<div class="modal fade" id="mainLinkModal" tabindex="-1" role="dialog" aria-labelledby="mainLinkModalLabel">
    <div class="modal-dialog" role="document" style="width:30%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                <h4 class="modal-title" id="mainLinkModalLabel">开户二维码/链接</h4>
            </div>
            <div class="modal-body">
                <div class="form-group" style="text-align: center;">
                    <div>
                        <img src="${qrCodeUrl}${userId}.jpg"/>
                    </div>
                    <input type="text" readonly="readonly" value="www.baidu.com" id="mainLink">
                    <button class="btn btn-blue" id="mainCopyBtn">复制链接</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

    $(function(){
    <@shiro.hasAnyRoles name='200001,200002'>
        _queryInviteNum();
    </@shiro.hasAnyRoles>

        const btn = document.querySelector('#mainCopyBtn');
        btn.addEventListener('click',function() {
            const input = document.getElementById("mainLink");
            input.select();
            try{
                if(document.execCommand('copy', false, null)){
                    //success info
                    console.log('复制成功');
                } else{
                    //fail info
                }
            } catch(err){
                //fail info
            }
        });

    });

    function _queryMainLink(userId){
        $.ajax({
            type: "POST",
            url: "${basePath}/dealer/queryLink.shtml",
            data: {userId: userId},
            dataType: "json",
            success: function (data) {
                if (data != null && data.level == 1) {
                    $("#mainLink").val(data.data[0]);
                    $("#mainLinkModal").modal();
                } else {
                    layer.alert(data.messageText, {
                        icon: 0,
                        skin: 'layui-layer-lan'
                    });
                }
            }
        });
    }
    <@shiro.hasAnyRoles name='200001,200002'>
        function _queryInviteNum(userId){
            $.ajax({
                type: "POST",
                url: "${basePath}/dealer/queryLink.shtml",
                data: {userId: userId},
                dataType: "json",
                success: function (data) {
                    if (data != null && data.level == 1) {
                        $("#mainInviteCode").text("开户推荐码："+getUrlParam("inviteNum",data.data[0]));
                    } else {
                        layer.alert(data.messageText, {
                            icon: 0,
                            skin: 'layui-layer-lan'
                        });
                    }
                }
            });
        }
    </@shiro.hasAnyRoles>

    //获取url中的参数
    function getUrlParam(name, url) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
        var r = url.substr(1).match(reg);  //匹配目标参数
        if (r != null) return unescape(r[2]); return null; //返回参数值
    }

</script> 
</#macro>

