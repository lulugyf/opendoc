package com.sitech.rom.user.controller;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sitech.rom.common.bo.LoginBo;
import com.sitech.rom.common.bo.RoleBo;
import com.sitech.rom.common.busi.BaseController;
import com.sitech.rom.common.dao.RomSysLoginDao;
import com.sitech.rom.common.dto.RomLoginRoleRelation;
import com.sitech.rom.common.dto.RomProvinceCode;
import com.sitech.rom.common.dto.RomSysLogin;
import com.sitech.rom.common.dto.RomSysRole;
import com.sitech.rom.user.service.LoginSvc;
import com.sitech.rom.user.service.ProvinceSvc;
import com.sitech.rom.user.service.RoleSvc;
import com.sitech.rom.util.AjaxResponsePacket;
import com.sitech.rom.util.Constants;
import com.sitech.rom.util.StringUtil;
import static java.lang.String.format;

@Controller
public class LoginController extends BaseController {
	
	@Resource
	private LoginSvc loginSvc;
	@Resource
	private RoleSvc roleSvc;
	@Resource
	private ProvinceSvc provinceSvc;
	
	@Resource
	private RomSysLoginDao romSysLoginDao;
	
	private final Logger log = Logger.getLogger(getClass());
	/*
     * 登录工号/密码校验
     */
	@RequestMapping(value = "login.do")
	public String login(HttpServletRequest request,
			HttpServletResponse response, HttpSession session
			//ModelMap modelMap 
			//@ModelAttribute("loginNo") String loginNo,
			//@ModelAttribute("loginPwd") String loginPwd
			) {
		String loginNo = request.getParameter("loginNo");
		String loginPwd = request.getParameter("loginPwd");
		//if(session.getAttribute("loginNo")!= null){ //重复登录
		//	modelMap.put("loginAgain", true);
		//}else{
			boolean flag = false;
			String isfirstlogin = "";
			try{
				flag = loginSvc.validUserPwd(loginNo, loginPwd); //工号密码校验
			}catch(Throwable e){
				System.out.println(format("===failed: %s , %s", loginNo, e.toString()));
			}
			log.info(format("==== validUserPwd %s return %s", loginNo, flag));
			
			if(flag == true){ //工号密码校验成功
				RomSysLogin romSysLogin = loginSvc.queryRomSysLogin(loginNo);
				isfirstlogin = romSysLogin.getLoginFlg();
				String areaCode=null;
				
				session.setAttribute("loginNo",loginNo);
				session.setAttribute("loginName",romSysLogin.getLoginName());
				session.setAttribute("cityId", romSysLogin.getProvince_code()); 
				if(romSysLogin.getProvince_code().equals("01")){
					areaCode="0531";	
				}else if(romSysLogin.getProvince_code().equals("02")){
					areaCode="0532";	
				}else if(romSysLogin.getProvince_code().equals("03")){
					areaCode="0535";	
				}else if(romSysLogin.getProvince_code().equals("04")){
					areaCode="0536";	
				}
				session.setAttribute("areaCode",areaCode);
				session.setAttribute("themePath","UI");
			}
			
			request.setAttribute("isLoginSucc", flag); //是否登录成功标识
		//}
			
			if("0".equals(isfirstlogin)){
				return "login/pass_update";
			}
		
			return "login/index";
		//return new ModelAndView("login/index",modelMap);
	}
	
	/* 
	 * goto工号管理主界面
	 */
	@RequestMapping(value = "loginMain.do")
	public String loginMain(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		return "user/syslogin/login_main";
	}

	@RequestMapping(value = "loginList.do")
	public String loginList(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		String loginNo = request.getParameter("loginNo");
	    String loginName = request.getParameter("loginName");
	    String useFlg = request.getParameter("useFlg");
	    
	    RomSysLogin romSysLogin = new RomSysLogin();
	    if(StringUtil.notNull(loginNo))romSysLogin.setLoginNo(loginNo);
	    if(StringUtil.notNull(loginName))romSysLogin.setLoginName(loginName);
	    if(StringUtil.notNull(useFlg))romSysLogin.setUseFlg(useFlg);
	    
	    request.setAttribute("loginlist", romSysLoginDao.queryList(romSysLogin) );
		
		return "user/syslogin/login_list";
	}
	
	/* 
	 * goto新增工号
	 */
	@RequestMapping(value = "gotoAddLogin.do")
	public String gotoAddLogin(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,ModelMap modelMap, @ModelAttribute("failAddObj") RomSysLogin failAddObj) {
		
		/**
		 * 新增工号时增加地市编码
		 */
		List<RomProvinceCode> provinceList=provinceSvc.getProvinceList();
		request.setAttribute("provinceList", provinceList);
		
		modelMap.put("failAddObj", failAddObj);
		return "user/syslogin/login_add"; 
	}
	
	/* 
	 * 新增工号
	 */
	@RequestMapping(value = "addLogin.do")
	public String addLogin(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap modelMap, @ModelAttribute("user") RomSysLogin user) {
		
		user.setLoginPwd(Constants.INIT_PWD); //初始密码
		try{
			if(loginSvc.queryRomSysLogin(user.getLoginNo())!=null){
				modelMap.put("failAddObj", user);
				modelMap.put("operInfo", "新增工号失败，工号已经存在！");
			}else{
				if(loginSvc.addSysLogin(user)){
					modelMap.put("operInfo", "新增工号成功！");

					//保存日志
					String proId=request.getParameter("proId");
					String opCode=request.getParameter("opCode");
					String opContent="新增工号：工号="+user.getLoginNo();
					Date opTime=new Date();
					this.saveLog(session, proId, opCode, opTime, opContent, "");
				}else{
					modelMap.put("failAddObj", user);
					modelMap.put("operInfo", "新增工号失败，请正确填写相关信息！");
				}
			}			
		}catch(Exception e){
			modelMap.put("failAddObj", user);
			modelMap.put("operInfo", "新增工号失败，请正确填写相关信息！");
			e.printStackTrace();
		}
		
		return "forward:gotoAddLogin.do";
	}
    
	/*  
	 * goto修改工号
	 */
	@RequestMapping(value = "gotoUpdateLogin.do")
	public ModelAndView updateForward(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap modelMap) {
		
		/**
		 * 修改工号时增加地市编码
		 */
		List<RomProvinceCode> provinceList=provinceSvc.getProvinceList();
		request.setAttribute("provinceList", provinceList);
		
		String loginNo = request.getParameter("loginNo")==null?"":request.getParameter("loginNo").trim();
		
		RomSysLogin user = null;
		try{
			user = loginSvc.queryRomSysLogin(loginNo);
			modelMap.put("updateObj", user);
			if(user==null)modelMap.put("operInfo", "系统查无此工号！");
		}catch(Exception e){
			modelMap.put("operInfo", "查询工号出现错误！");
			e.printStackTrace();
		}
		
		return new ModelAndView("user/syslogin/login_update",modelMap);
	}
	
	/* 
	 * 修改工号 
	 */
	@RequestMapping(value = "updateLogin.do")
	public ModelAndView updateLogin(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap modelMap, @ModelAttribute("user") RomSysLogin user) {
		try{
			String loginNoOld=request.getParameter("loginNoOld");
			String loginNo=user.getLoginNo();
			boolean flag=true;
			
			if(!loginNo.equals(loginNoOld)){
				if(loginSvc.queryRomSysLogin(loginNo)!=null){
					modelMap.put("operInfo", loginNo+"工号已存在，请正确填写相关信息！");
					user.setLoginNo(loginNoOld);
					modelMap.put("updateObj", user);
					flag=false;
				}
			}
			
			if(flag==true){
				if(loginSvc.updateSysLogin(user,loginNoOld)){
					modelMap.put("operInfo", "修改工号信息成功！");
					modelMap.put("updateObj", user);

					//保存日志
					String proId=request.getParameter("proId");
					String opCode=request.getParameter("opCode");
					String opContent="修改工号：";
					if(!loginNo.equals(loginNoOld)){
						opContent=opContent+"原工号="+loginNoOld+"，修改后工号="+loginNo;
					}else{
						opContent=opContent+"工号="+loginNoOld;
					}
					Date opTime=new Date();
					this.saveLog(session, proId, opCode, opTime, opContent, "");
				}else{
					modelMap.put("operInfo", "修改工号失败，请正确填写相关信息！");
					user.setLoginNo(loginNoOld);
					modelMap.put("updateObj", user);
				}
			}
		}catch(Exception e){
			modelMap.put("operInfo", "修改工号失败，请正确填写相关信息！");
			e.printStackTrace();
		}
				
		return new ModelAndView("user/syslogin/login_update",modelMap);
	}
	
	/* 
	 * 删除工号 
	 * @ResponseBody用来处理ajax返回
	 */
	@ResponseBody
	@RequestMapping(value = "delLogin.do")
	public String delLogin(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap modelMap) {
		
		String loginNo = request.getParameter("loginNo")==null?"":request.getParameter("loginNo").trim();
		AjaxResponsePacket responsePacked = new AjaxResponsePacket();

		try{
			if(loginSvc.delSysLogin(loginNo)){
				responsePacked.data.put("retCode", "1"); //删除成功

				//保存日志
				String proId=request.getParameter("proId");
				String opCode=request.getParameter("opCode");
				String opContent="删除工号：工号="+loginNo;
				Date opTime=new Date();
				this.saveLog(session, proId, opCode, opTime, opContent, "");
			}else{
				responsePacked.data.put("retCode", "0"); //删除失败
			}
		}catch(Exception e){
			responsePacked.data.put("retCode", "0"); //删除失败
			e.printStackTrace();
		}
		
		return responsePacked.getAjaxPacketText();
	}
	
	//工号角色关系
	@RequestMapping(value = "gotoSetLoginRole.do")
	public String  gotoSetLoginRole(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,ModelMap modelMap ) {
 
		String loginNo=request.getParameter("loginNo");
		
		//获取所有有效的角色
	    RomSysRole romSysRole = new RomSysRole(); 
	    romSysRole.setRoleState(Constants.VALID);//有效	    
	    List<RoleBo> roleList=loginSvc.getRomRoleInfo(romSysRole);	    
	    request.setAttribute("roleList",roleList);
	    
	    //已经存在的工号角色
	    RomLoginRoleRelation romLoginRoleRelation=new RomLoginRoleRelation();
	    romLoginRoleRelation.setLoginNo(loginNo);
	    List<RomLoginRoleRelation> loginRoleList=loginSvc.getLoginRoleList(romLoginRoleRelation);
		String rtn = "";
		for(RomLoginRoleRelation obj:loginRoleList){
			rtn=rtn+obj.getRoleId()+";";
		}
		request.setAttribute("loginRoleForChk", rtn);
		request.setAttribute("loginNo", loginNo);//选择的某个工号
	  
		return "user/syslogin/loginRole_set";
	}
	
	@RequestMapping(value = "setLoginRole.do")
	public String setLoginRole(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {

		String loginNo=request.getParameter("loginNo");
		String[] roles=request.getParameterValues("chkrole");
		
		loginSvc.setLoginRole(loginNo, roles);
		
		request.setAttribute("operInfo", "角色设置成功！");

		//保存日志
		String proId=request.getParameter("proId");
		String opCode=request.getParameter("opCode");
		String opContent="工号角色设置：工号="+loginNo;
		Date opTime=new Date();
		this.saveLog(session, proId, opCode, opTime, opContent, "");
		
		return "forward:gotoSetLoginRole.do";
	}
	

	//获取同产品、省份、运营商工号集合
	@RequestMapping(value = "gotoGetLoginTree.do")
	public String  gotoGetLoginTree(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,ModelMap modelMap, @ModelAttribute("loginBo") LoginBo loginBo) {
		
		loginBo.setLoginNo(session.getAttribute("loginNo").toString());
		request.setAttribute("loginList", loginSvc.getLoginTree(loginBo));
	  
		return "user/syslogin/getLoginTree";
	}
}
