<#macro top index>
<script baseUrl="${basePath}" src="${basePath}/js/user.login.js"></script>
<script  src="${basePath}/js/common/mask/Jquery.mask.js"></script>
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
				<@shiro.hasAnyRoles name='888888,100002'>          
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
				<@shiro.hasAnyRoles name='888888,100003'>
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
				  <@shiro.hasAnyRoles name='888888,100002'>
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
                          </ul>
                      </li>
				  </@shiro.hasAnyRoles>

			      <#--拥有 角色888888（管理员）-->
				  <@shiro.hasAnyRoles name='888888'>
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
				  <@shiro.hasAnyRoles name='200001'>
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
							 href="javascript:void(0);" onclick="location.href='${basePath}/u/login.shtml'" class="dropdown-toggle qqlogin" >
							<img src="http://qzonestyle.gtimg.cn/qzone/vas/opensns/res/img/Connect_logo_1.png">&nbsp;登录</a>
						</@shiro.guest>  					
				</li>	
	          </ul>
	          <style>#topMenu>li>a{padding:10px 13px}</style>
	    </div>
  	</div>
</div>
</#macro>
