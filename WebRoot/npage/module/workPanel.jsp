<%@ page contentType="text/html;charset=UTF-8" %>
		<div id="workPanel" style="display: inline-block; width:80%">	
			<div id="tabset">
				<div id="tab">
					<ul id="tabtag" >
						<li id="index" class="current" name="true"><span class="fristab"><IMG src="<%=request.getContextPath()%>/nresources/<%=themePath%>/images/tab_work.gif" id="tab_user" id="tab_user"/>工作空间</span></li>
					</ul>
				</div>
				<span class="first"><img src="<%=request.getContextPath()%>/nresources/<%=themePath%>/images/tabimages/btn_left.gif"  onclick="BtnMoveLeft(event)" id="imgLeft" /></span>
				<span class="next"><img src="<%=request.getContextPath()%>/nresources/<%=themePath%>/images/tabimages/btn_right.gif" onclick="BtnMoveRight(event)"  id="imgRight" /></span>
				<dl id="contentArea">
					<dt class="on" >
						<iframe align="left"  class="workIframe"  id="ifram" src="../portal/work/portal.jsp" frameborder="0" scrolling="auto"  width="100%" height="100%" noresize>
					  </iframe>
					</dt>
				</dl>
			</div>
		</div>
	</div>	