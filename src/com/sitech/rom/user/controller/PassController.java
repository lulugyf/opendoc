package com.sitech.rom.user.controller;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sitech.rom.common.busi.BaseController;
import com.sitech.rom.common.dto.RomSysLogin;
import com.sitech.rom.common.dto.RomSysRole;
import com.sitech.rom.user.service.LoginSvc;
import com.sitech.rom.user.service.RoleSvc;
import com.sitech.rom.util.AjaxResponsePacket;
import com.sitech.rom.util.Constants;
import com.sitech.rom.util.StringUtil;

@Controller
public class PassController extends BaseController {
	
	@Resource
	private LoginSvc loginSvc;
	
	@Resource
	private RoleSvc roleSvc;
	
	/* 
	 * goto工号密码管理主界面
	 */
	@RequestMapping(value = "passMain.do")
	public String passMain(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,ModelMap modelMap) {
		
		return "user/loginpass/pass_main";
	}
	
	/* 
	 * goto工号密码修改
	 */
	@RequestMapping(value = "gotoUpdatePass.do")
	public String gotoUpdatePass(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,ModelMap modelMap) {
		
		return "user/loginpass/pass_update";
	}
	
	/* 
	 * 修改工号密码 
	 * @ResponseBody用来处理ajax返回
	 */
	@RequestMapping(value = "updatePassword.do")
	@ResponseBody
	public String updatePassword(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap modelMap, 
			    String pre_login_password, String login_password) {
		
		AjaxResponsePacket responsePacked = new AjaxResponsePacket();
		String m_login_no = session.getAttribute("loginNo").toString();
		try{
			RomSysLogin result = loginSvc.queryRomSysLogin(m_login_no,pre_login_password); //工号+原始密码
			
			String operInfo="";
			if(result==null){
				operInfo="0";
			}else{
				operInfo="1";
				result.setLoginPwd(login_password);
				result.setLoginFlg("1");
				loginSvc.updateLoginPass(result);
				
			}
			
			responsePacked.data.put("retCode", operInfo);

			//保存日志
			String proId=request.getParameter("proId");
			String opCode=request.getParameter("opCode");
			String opContent="修改密码";
			Date opTime=new Date();
			this.saveLog(session, proId, opCode, opTime, opContent, "");
			
		}catch(Exception e){
			responsePacked.data.put("retCode", "-1"); //操作异常
			e.printStackTrace();
		}
		
		return responsePacked.getAjaxPacketText();
	}
	
	/* 
	 * 重置工号密码 
	 * @ResponseBody用来处理ajax返回
	 */
	@RequestMapping(value = "resetPassword.do")
	public String resetPassword(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap modelMap, String r_login_no) {
		
		try{
			RomSysLogin result = loginSvc.queryRomSysLogin(r_login_no);
			
			if(result==null){
				modelMap.put("operInfo", "此工号不存在！");
			}else{
				result.setLoginPwd(Constants.INIT_PWD);
				loginSvc.updateLoginPass(result);
				modelMap.put("operInfo", "工号密码重置成功！");
				
				//保存日志
				String proId=request.getParameter("proId");
				String opCode=request.getParameter("opCode");
				String opContent="密码重置：工号="+r_login_no;
				Date opTime=new Date();
				this.saveLog(session, proId, opCode, opTime, opContent, "");
			}
		}catch(Exception e){
			modelMap.put("operInfo", "系统异常，工号密码重置失败！");
			e.printStackTrace();
		}
		
		return "forward:passMain.do";
	}
}
