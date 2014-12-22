package com.sitech.rom.user.controller;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sitech.rom.common.bo.HostBo;
import com.sitech.rom.common.busi.BaseController;
import com.sitech.rom.common.dao.RomSysLoginDao;
import com.sitech.rom.common.dto.RomProCode;
import com.sitech.rom.common.dto.RomProvinceCode;
import com.sitech.rom.common.dto.RomSysRole;
import com.sitech.rom.common.dto.RomTellcorpCode;
import com.sitech.rom.common.dto.Seq;
import com.sitech.rom.user.service.ProductSvc;
import com.sitech.rom.user.service.ProvinceSvc;
import com.sitech.rom.user.service.RoleSvc;
import com.sitech.rom.user.service.SeqSvc;
import com.sitech.rom.user.service.TelecorpSvc;
import com.sitech.rom.util.AjaxResponsePacket;
import com.sitech.rom.util.Constants;

@Controller
public class RoleController extends BaseController {
	@Resource
	private RoleSvc roleSvc;
	@Resource
	private SeqSvc seqSvc;
	@Resource
	private ProvinceSvc provinceSvc;
	@Resource
	private TelecorpSvc telecorpSvc;
	@Resource
	private ProductSvc productSvc;
	
	@Resource
	private RomSysLoginDao romSysLoginDao;
	
	/*
	 * goto角色管理主界面
	 */
	@RequestMapping(value = "role.do")
	public String role(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		List<RomProvinceCode> provinceList=provinceSvc.getProvinceList();
		request.setAttribute("provinceList", provinceList);

		List<RomTellcorpCode> tellcorpList=telecorpSvc.getTellcorpList();
		request.setAttribute("tellcorpList", tellcorpList);
		
		List<RomProCode> productList=productSvc.getProList(new RomProCode());
		request.setAttribute("productList", productList);
		
		return "user/role/role_main";		
	}

	@RequestMapping(value = "roleList.do")
	public String roleList(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
//	    String provinceCode = request.getParameter("provinceCode").trim();
//	    String tellType = request.getParameter("tellType").trim();
	    String proCode = request.getParameter("proCode").trim();
	    
	    String tellType = "";
	    String provinceCode = "";

	    RomSysRole romSysRole = new RomSysRole();
	    if(provinceCode!=null && !"".equals(provinceCode))romSysRole.setProvinceCode(provinceCode);
	    if(tellType!=null && !"".equals(tellType))romSysRole.setTellType(tellType);
	    if(proCode!=null && !"".equals(proCode))romSysRole.setProCode(proCode);
	    request.setAttribute("roleList", romSysLoginDao.qryRomRoleInfo(romSysRole));
		
		return "user/role/role_list";		
	}
	/*
	 * goto角色新增
	 */
	@RequestMapping(value = "gotoAddRole.do")
	public String gotoAddRole(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
 
		List<RomProvinceCode> provinceList=provinceSvc.getProvinceList();
		request.setAttribute("provinceList", provinceList);

		List<RomTellcorpCode> tellcorpList=telecorpSvc.getTellcorpList();
		request.setAttribute("tellcorpList", tellcorpList);
		
		List<RomProCode> productList=productSvc.getProList(new RomProCode());
		System.out.println("=====productList.size():"+productList.size());
		request.setAttribute("productList", productList);
		
		return "user/role/role_add";		
	}
	
	/*
	 * 角色新增
	 */
	@RequestMapping(value = "addRole.do")
	public String addRole(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,@ModelAttribute("role") RomSysRole role) {
 	
		Seq seq=new Seq();
		seq.setSeq_name(Constants.SEQ_COMMON);
		Long roleId=seqSvc.getSeq(seq);
		
		role.setRoleId(roleId);
		role.setRemarks("新增角色");
		role.setProvinceCode("");
		role.setTellType("");
		
		if(roleSvc.addRole(role)){
			request.setAttribute("operInfo","新增角色成功！");

			//保存日志
			String proId=request.getParameter("proId");
			String opCode=request.getParameter("opCode");
			String opContent="新增角色：角色名称="+role.getRoleName()+"，产品名称="+request.getParameter("proName");
			Date opTime=new Date();
			this.saveLog(session, proId, opCode, opTime, opContent, "");			
		}else{
			request.setAttribute("operInfo","新增角色失败！");
		}
		
		return "forward:gotoAddRole.do";		
	}	
	
	/*
	 * goto角色修改
	 */
	@RequestMapping(value = "gotoUpdateRole.do")
	public String gotoUpdateRole(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
 
		String roleId=request.getParameter("roleId");
		
		RomSysRole qryPara=new RomSysRole();
		qryPara.setRoleId(Long.valueOf(roleId));
		RomSysRole romSysRole=roleSvc.getSysRole(qryPara);
		request.setAttribute("romSysRole", romSysRole);
		
		List<RomProvinceCode> provinceList=provinceSvc.getProvinceList();
		request.setAttribute("provinceList", provinceList);

		List<RomTellcorpCode> tellcorpList=telecorpSvc.getTellcorpList();
		request.setAttribute("tellcorpList", tellcorpList);

		List<RomProCode> productList=productSvc.getProList(new RomProCode());
		System.out.println("=====productList.size():"+productList.size());
		request.setAttribute("productList", productList);
		
		return "user/role/role_update";		
	}
	
	/*
	 * 角色修改
	 */
	@RequestMapping(value = "updateRole.do")
	public String updateRole(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap modelMap, @ModelAttribute("role") RomSysRole role) {
		
		try{
			role.setRemarks("修改角色");
			if(roleSvc.updateRole(role)){
				modelMap.put("operInfo", "修改角色成功！");

				//保存日志
				String proId=request.getParameter("proId");
				String opCode=request.getParameter("opCode");
				String opContent="修改角色：";
				if(request.getParameter("roleNameOld").equals(role.getRoleName())){
					opContent=opContent+"角色名称="+role.getRoleName()+"，产品名称="+request.getParameter("proName");
				}else{
					opContent=opContent+"原角色名称="+request.getParameter("roleNameOld")+"，修改后角色名称="+role.getRoleName()+"，产品名称="+request.getParameter("proName");
				}
				Date opTime=new Date();
				this.saveLog(session, proId, opCode, opTime, opContent, "");
			}else{
				modelMap.put("operInfo", "修改角色失败，请正确填写相关信息！");
			}
			
		}catch(Exception e){
			modelMap.put("operInfo", "修改角色失败，请正确填写相关信息！");
			e.printStackTrace();
		}
		
		return "forward:gotoUpdateRole.do";		
	}
	
	/*
	 * 角色删除
	 */
	@ResponseBody
	@RequestMapping(value = "delRole.do")
	public String delLogin(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap modelMap) {
		
		String roleId = request.getParameter("roleId")==null?"":request.getParameter("roleId").trim();
		AjaxResponsePacket responsePacked = new AjaxResponsePacket();

		try{
 
			RomSysRole obj=new RomSysRole();
			obj.setRoleId(Long.valueOf(roleId));
			obj.setRoleState(Constants.INVALID);
			obj.setRemarks("删除角色");
			if(roleSvc.delRole(obj)){
				responsePacked.data.put("retCode", "1"); //删除成功
			}else{
				responsePacked.data.put("retCode", "0"); //删除失败
			}
		}catch(Exception e){
			responsePacked.data.put("retCode", "0"); //删除失败
			e.printStackTrace();
		}
		
		//保存日志
		String proId=request.getParameter("proId");
		String opCode=request.getParameter("opCode");
		String opContent="删除角色：角色名称="+request.getParameter("roleName")+"，产品名称="+request.getParameter("proName");
		Date opTime=new Date();
		this.saveLog(session, proId, opCode, opTime, opContent, "");
		
		return responsePacked.getAjaxPacketText();
	}
	
}
