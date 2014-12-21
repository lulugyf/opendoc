package com.sitech.rom.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SessionInterceptor extends HandlerInterceptorAdapter {

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
		
		String url=request.getRequestURL().toString();
		if(url.matches(noCheckURL)){
			return true;
		}
		
		if(mappingURL==null || url.matches(mappingURL)){
			HttpSession session=request.getSession();
			String loginNo=(String) session.getAttribute("loginNo");
			if(null!=loginNo && !loginNo.equals("")){
				return true;
			}else{
				request.setAttribute("msg", "未登录，请登录！");
				request.getRequestDispatcher("/npage/login/login.htm").forward(request, response);
				return false;				
			}

		}
		return true;
	}


	
}