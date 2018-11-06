<#macro user index>
<div id="one" class="col-md-2">
	<ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
	  <li class="${(index==1)?string('active',' ')}">
	      <a href="${basePath}/user/index.shtml">
	    	 <i class="glyphicon glyphicon-chevron-right"></i>个人资料
	      </a>
	       <ul class="dropdown-menu" aria-labelledby="dLabel" style="margin-left: 160px; margin-top: -40px;">
              <li><a href="${basePath}/user/updateSelf.shtml">资料修改</a></li>
              <li><a href="${basePath}/user/updatePswd.shtml">密码修改</a></li>
          </ul>
	  </li>
	  <li class="${(index==2)?string('active',' ')} dropdown">
	      <a href="${basePath}/role/mypermission.shtml">
	    	 <i class="glyphicon glyphicon-chevron-right"></i>我的权限
	      </a>
	  </li>
	</ul>
</div>
</#macro>
<#macro member index>
	<@shiro.hasAnyRoles name='888888,100002,100004,100005'>
		<div  id="one" class="col-md-2">
			<ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
			  <li class="${(index==1)?string('active',' ')}">
			      <a href="${basePath}/member/list.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>用户列表
			      </a>
			  </li>
			  <li class="${(index==2)?string('active',' ')} dropdown">
			      <a href="${basePath}/member/online.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>在线用户
			      </a>
			  </li>
			</ul>
		</div>
	</@shiro.hasAnyRoles>         
</#macro>
<#macro role index>
	<@shiro.hasAnyRoles name='888888,100003,100004,100005'>
		<div id="one" class="col-md-2">
			<ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
			 
			 <@shiro.hasPermission name="/role/index.shtml">
			  <li class="${(index==1)?string('active',' ')}">
			      <a href="${basePath}/role/index.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>角色列表
			      </a>
			  </li>
			  </@shiro.hasPermission>
			 <@shiro.hasPermission name="/role/allocation.shtml">
			  <li class="${(index==2)?string('active',' ')} dropdown">
			      <a href="${basePath}/role/allocation.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>角色分配
			      </a>
			  </li>
			  </@shiro.hasPermission>
			  <@shiro.hasPermission name="/permission/index.shtml">
			  <li class="${(index==3)?string('active',' ')} dropdown">
			      <a href="${basePath}/permission/index.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>权限列表
			      </a>
			  </li>
			  </@shiro.hasPermission>
			  <@shiro.hasPermission name="/permission/allocation.shtml">
			  <li class="${(index==4)?string('active',' ')} dropdown">
			      <a href="${basePath}/permission/allocation.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>权限分配
			      </a>
			  </li>
			  </@shiro.hasPermission>
			</ul>
		</div>
	</@shiro.hasAnyRoles>   
</#macro>
<#macro player index>
	<@shiro.hasAnyRoles name='888888,100002,100004,100005'>
    <div  id="one" class="col-md-2">
        <ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
			<@shiro.hasPermission name="/player/list.shtml">
            <li class="${(index==1)?string('active',' ')}">
                <a href="${basePath}/player/list.shtml?">
                    <i class="glyphicon glyphicon-chevron-right"></i>选手列表
                </a>
            </li>
			</@shiro.hasPermission>
			<@shiro.hasPermission name="/gainsInfo/list.shtml">
                <li class="${(index==2)?string('active',' ')} dropdown">
                    <a href="${basePath}/gainsInfo/list.shtml?">
                        <i class="glyphicon glyphicon-chevron-right"></i>参赛选手数据
                    </a>
                </li>
			</@shiro.hasPermission>
			<@shiro.hasPermission name="/playerMoney/list.shtml">
                <li class="${(index==3)?string('active',' ')} dropdown">
                    <a href="${basePath}/playerMoney/list.shtml?">
                        <i class="glyphicon glyphicon-chevron-right"></i>参赛选手资金
                    </a>
                </li>
			</@shiro.hasPermission>

            <#--<li class="${(index==2)?string('active',' ')} dropdown">-->
                <#--<a href="${basePath}/member/online.shtml">-->
                    <#--<i class="glyphicon glyphicon-chevron-right"></i>在线用户-->
                <#--</a>-->
            <#--</li>-->
        </ul>
    </div>
	</@shiro.hasAnyRoles>
</#macro>
<#macro dealer index>
	<@shiro.hasAnyRoles name='888888,100004,100005'>
    <div id="one" class="col-md-2">
        <ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
			<@shiro.hasPermission name="/dealer/list.shtml">
                <li class="${(index==1)?string('active',' ')}">
                    <a href="${basePath}/dealer/list.shtml?parentId=0">
                        <i class="glyphicon glyphicon-chevron-right"></i>代理商列表
                    </a>
                </li>
			</@shiro.hasPermission>
			<@shiro.hasPermission name="/dealer/countDealerList.shtml">
                <li class="${(index==2)?string('active',' ')}">
                    <a href="${basePath}/dealer/countDealerList.shtml">
                        <i class="glyphicon glyphicon-chevron-right"></i>代理商观众统计
                    </a>
                </li>
			</@shiro.hasPermission>
        </ul>
    </div>
	</@shiro.hasAnyRoles>
</#macro>
<#macro employee index>
	<@shiro.hasAnyRoles name='200001,100004,100005'>
    <div id="one" class="col-md-2">
        <ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
			<@shiro.hasPermission name="/dealer/employeeList.shtml">
                <li class="${(index==1)?string('active',' ')}">
                    <a href="${basePath}/dealer/employeeList.shtml?parentId=${userId}">
                        <i class="glyphicon glyphicon-chevron-right"></i>员工列表
                    </a>
                </li>
			</@shiro.hasPermission>

			<@shiro.hasPermission name="/dealer/countEmployeeList.shtml">
                <li class="${(index==2)?string('active',' ')}">
                    <a href="${basePath}/dealer/countEmployeeList.shtml">
                        <i class="glyphicon glyphicon-chevron-right"></i>员工观众统计
                    </a>
                </li>
			</@shiro.hasPermission>

        </ul>
    </div>
	</@shiro.hasAnyRoles>
</#macro>

<#macro vips index>
	<@shiro.hasAnyRoles name='888888,200001,200002,100004,100005,100006'>
    <div id="one" class="col-md-2">
        <ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
			<@shiro.hasPermission name="/dealer/vipsList.shtml">
                <li class="${(index==1)?string('active',' ')}">
                    <a href="${basePath}/dealer/vipsList.shtml?parentId=${userId}">
                        <i class="glyphicon glyphicon-chevron-right"></i>观众列表
                    </a>
                </li>
			</@shiro.hasPermission>
			<@shiro.hasPermission name="/dealer/vipsRecordList.shtml">
                <li class="${(index==2)?string('active',' ')}">
                    <a href="${basePath}/dealer/vipsRecordList.shtml?userId=${userId}">
                        <i class="glyphicon glyphicon-chevron-right"></i>购票明细
                    </a>
                </li>
			</@shiro.hasPermission>
        </ul>
    </div>
	</@shiro.hasAnyRoles>
</#macro>

<#macro eventReport index>
	<@shiro.hasAnyRoles name='888888,100006'>
    <div id="one" class="col-md-2">
        <ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
			<@shiro.hasPermission name="/eventReport/list.shtml">
                <li class="${(index==1)?string('active',' ')}">
                    <a href="${basePath}/eventReport/list.shtml">
                        <i class="glyphicon glyphicon-chevron-right"></i>赛事报道列表
                    </a>
                </li>
			</@shiro.hasPermission>

			<@shiro.hasPermission name="/problem/list.shtml">
                <li class="${(index==2)?string('active',' ')}">
                    <a href="${basePath}/problem/list.shtml">
                        <i class="glyphicon glyphicon-chevron-right"></i>常见问题列表
                    </a>
                </li>
			</@shiro.hasPermission>
        </ul>
    </div>
	</@shiro.hasAnyRoles>
</#macro>

<#macro stopdate index>
	<@shiro.hasAnyRoles name='888888,100006'>
    <div id="one" class="col-md-2">
        <ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
			<@shiro.hasPermission name="/stopdate/list.shtml">
                <li class="${(index==1)?string('active',' ')}">
                    <a href="${basePath}/stopdate/list.shtml">
                        <i class="glyphicon glyphicon-chevron-right"></i>系统配置
                    </a>
                </li>
			</@shiro.hasPermission>
			<@shiro.hasPermission name="/homeConfig/list.shtml">
                <li class="${(index==2)?string('active',' ')}">
                    <a href="${basePath}/homeConfig/list.shtml">
                        <i class="glyphicon glyphicon-chevron-right"></i>首页配置
                    </a>
                </li>
			</@shiro.hasPermission>
        </ul>
    </div>
	</@shiro.hasAnyRoles>
</#macro>