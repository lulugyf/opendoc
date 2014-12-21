package com.sitech.rom.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.sitech.rom.common.bo.PopedomBo;
import com.sitech.rom.common.dao.UserDao;
import com.sitech.rom.user.service.PopedomSvc;
import com.sitech.rom.util.AjaxResponsePacket;

public class PopedomInterceptor extends HandlerInterceptorAdapter {
	@Resource
	private PopedomSvc popedomSvc;
	
	private String noCheckURL;
	private String mappingURL;//利用正则映射到需要拦截的路径

	public void setNoCheckURL(String noCheckURL) {
		this.noCheckURL = noCheckURL;
	}	
	public void setMappingURL(String mappingURL) {
		this.mappingURL = mappingURL;
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		
		
//		if(true){
//			request.setAttribute("opersForPage", "1;2;3;4;5");
//			return true;
//		}

		String upath = request.getRequestURL().toString();
		String url=upath;
		String path = request.getContextPath();
		String proCode = request.getParameter("proId");
		String opCode = request.getParameter("opCode");
		String provinceCode = request.getParameter("provinceCode");
		String tellType = request.getParameter("tellType");
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		String[] nochks = noCheckURL.split(";");
		for(String no:nochks){
			if(url.matches(no)){
				return true;
			}
		}
		
		if(mappingURL==null || url.matches(mappingURL)){
			//update by yl.不能简单的截取/作为@RequestMapping的名称。
			//url = url.substring(url.lastIndexOf("/")+1);
			url = url.substring(url.indexOf(basePath)+basePath.length());
			url = url.substring(0,url.indexOf(".do"))+".do";//web.xml中的dispatcher模式要是<url-pattern>*.do</url-pattern>的方式
			//update end.
			
			HttpSession session=request.getSession();
			String loginNo=(String) session.getAttribute("loginNo");
			
			boolean isValid = popedomSvc.validPopedom(loginNo, url, proCode, opCode, provinceCode, tellType);
			System.out.println(String.format("===popedom valid: %s %s %s %s %s %s return %s",
					loginNo, upath, proCode, opCode, provinceCode, tellType, isValid));
			if(isValid==true){
				request.setAttribute("opersForPage", popedomSvc.getOpersForPage());
				popedomSvc.setOpersForPage(null);
				return true;
			}else{
				
				if(isAjaxRequest(request)){
					String ajaxReturnDataType = request.getHeader("ajaxReturnDataType");
					if (ajaxReturnDataType != null && ajaxReturnDataType.equals("html")){
						response.getWriter().write("noright");
						
						//request.getRequestDispatcher("/npage/error/errorpage.jsp").forward(request, response);							
					}else{
						AjaxResponsePacket responsePacked = new AjaxResponsePacket();
						responsePacked.data.put("retCode", "noright"); //1:删除成功 2:工号没有权限 0:删除失败
						response.getWriter().write(responsePacked.getAjaxPacketText());
						response.flushBuffer();							
					}
				
				}else{
					request.getRequestDispatcher("/npage/error/errorpage.jsp").forward(request, response);
				}
				return false;	
			}
			
		}
		return true;
		
		
	}

	//add by yl.判断是否是ajax请求
	private boolean isAjaxRequest(HttpServletRequest request) {
		//X-Request-With不是XMLHttpRequest自己的特性，只是各个库比较统一地都用了这个头，jquery/ext/kissy/tangram/yui等都会自己给加上而已，
		//如果是自己来实现ajax函数的话，就要注意下了		
		String header = request.getHeader("X-Requested-With");
		if (header != null && "XMLHttpRequest".equals(header))
			return true;
		else
			return false;
	}	
}