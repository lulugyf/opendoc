<%@ page contentType="text/html;charset=UTF-8" %>
<div id="searchPanel">
	<!--div class="serverCase">
		<div class="select" onclick="chgLoginType()">
			<input type="text" name="loginType" id="loginType" readonly loginType="<%=custType[0][0]%>" value="<%=custType[0][1]%>" >
			<div class="select_panel">
				<%
				for(int i=0;i<custType.length;i++)
				{
				%>
				<p value="<%=custType[i][0]%>"><%=custType[i][1]%></p>
			<%}%>
			</div>
		</div>
	</div>
	<div class="serverNum">
		<div class="input">
			<input type="text" name="phoneNo" class="forMobile" id="phoneNo" onfocus="clearPhoneNo()"  onkeyDown="if(event.keyCode==13)addTabBySearch()" value="请输入信息进行查询(Alt+1)" maxlength="20"/>
			<input type='hidden' name='phoneNo2' id='phoneNo2' value='' /> 
		</div>
		<button onClick="javascript:addTabBySearch()"></button>
	</div>
	<div class="quickGo">
		<div class="input">
			<input type='text' class="inp_name" id='tb_c' style="display:none;" onkeyDown="if(event.keyCode==13)exactSearch(this.value)" value='快速转入 (Alt+2)'/>
			<input type='text'  class="inp_name" id='tb' value='快速转入 (Alt+2)'/>
			<input type='hidden' id='tb_h' value='-1'/>
		</div>
		<button class="keyOn" id="lock" onclick="javascript:turnLock(this)" opcode=""></button>
	</div-->
	<ul class="layerout">
		<li id="a1" class="aSpace" onclick="layoutSwitch(1)" title="工作区最大化"></li>
		<li id="a2" class="bSpaceOn" onclick="layoutSwitch(2)" title="显示全部"></li>
		<li id="a3" class="cSpace" onclick="layoutSwitch(3)" title="无菜单"></li>
		<li id="a4" class="dSpace" onclick="layoutSwitch(4)" title="无树"></li>
		<input type="hidden" id="layoutStatus" value="3">
		<!--li class="more_set">整体面板定制
				<div class="more_panel">
					<iframe id="moresetIf" style="position:absolute;width:120px;height:100%;z-index:-1;top:-2px;left:-2px;" scrolling="no"frameborder="0" src="about:blank"></iframe>
					<ul>
						<li class="theme"><a href="javascript:openDivWin('../set/setTheme.jsp','主题模式定制','600','500')">主题模式设置</a></li>
						<li class="menu"><a href="javascript:openDivWin('../set/setMenu.jsp','主菜单设置','600','300')">主菜单设置</a></li>
						<li class="work"><a href="javascript:openDivWin('../set/setWork.jsp','工作区设置','600','500')">工作区设置</a></li>
					</ul>
					<div style="clear:both"></div>
				</div>
		</li-->
	</ul>
</div>