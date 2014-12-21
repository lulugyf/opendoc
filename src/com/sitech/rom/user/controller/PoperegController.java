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
import org.springframework.web.servlet.ModelAndView;

import com.sitech.rom.common.bo.PoperegBo;
import com.sitech.rom.common.busi.BaseController;
import com.sitech.rom.common.dao.UserDao;
import com.sitech.rom.common.dto.RomOperaCode;
import com.sitech.rom.common.dto.RomProCode;
import com.sitech.rom.common.dto.RomSysFunction;
import com.sitech.rom.common.dto.RomSysLogin;
import com.sitech.rom.common.dto.RomSysPopedom;
import com.sitech.rom.user.service.FunctionSvc;
import com.sitech.rom.user.service.PoperegSvc;
import com.sitech.rom.util.AjaxResponsePacket;
import com.sitech.rom.util.Constants;
import com.sitech.rom.util.StringUtil;

@Controller
public class PoperegController extends BaseController {

	@Resource
	private FunctionSvc functionSvc;
	@Resource
	private PoperegSvc poperegSvc;
	@Resource
	private UserDao userDao;
	
	/* 
	 * goto功能注册主界面
	 */
	@RequestMapping(value = "popereg.do")
	public ModelAndView popereg(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,ModelMap modelMap) {

		modelMap.put("functionList", functionSvc.getFunctionList(null));
		
		return new ModelAndView("user/popereg/popereg_main",modelMap);
	}
	
	@RequestMapping(value = "poperegList.do")
	public String poperegList(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
	    String functionCode = request.getParameter("functionCode");
	    String actionName = request.getParameter("actionName");
	    
	    PoperegBo poperegBo = new PoperegBo();
	    if(StringUtil.notNull(functionCode))poperegBo.setFunctionCode(functionCode);
	    if(StringUtil.notNull(actionName))poperegBo.setActionName(actionName);
	    request.setAttribute("popereglist", userDao.queryPoperegList(poperegBo));
		return "user/popereg/popereg_list";
	}
	
	/* 
	 * goto功能注册新增
	 */
	@RequestMapping(value = "gotoAddPopereg.do")
	public ModelAndView gotoAddPopereg(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,ModelMap modelMap) {
		
		modelMap.put("functionList", functionSvc.getFunctionList(null));
		
		return new ModelAndView("user/popereg/popereg_add",modelMap);
	}

	/* 
	 * 功能注册新增
	 */
	@RequestMapping(value = "addPopereg.do")
	@ResponseBody
	public String addPopereg(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,ModelMap modelMap, @ModelAttribute("popereg") RomSysPopedom popereg) {
		
		if(popereg.getFunctionCode()!=null && !"".equals(popereg.getFunctionCode())
				&& popereg.getActionName()!=null && !"".equals(popereg.getActionName())){
			
			RomSysPopedom romSysPopedom = new RomSysPopedom();
			romSysPopedom.setFunctionCode(popereg.getFunctionCode());
			romSysPopedom.setActionName(popereg.getActionName());
			List<RomSysPopedom> poperegList = poperegSvc.getPoperegList(romSysPopedom);
			
			if(poperegList!=null && poperegList.size()>0){
				return "repeat"; //功能重复
				
			}else{
				try{
					if(poperegSvc.addPopereg(popereg)){
						
						String proId=request.getParameter("proId");
						String opCode=request.getParameter("opCode");
						String opContent="新增功能注册：功能链接="+popereg.getActionName()+"，所属功能="+request.getParameter("functionLabel");
						Date opTime=new Date();
						//保存日志
						this.saveLog(session, proId, opCode, opTime, opContent, "");
						
						return "0";
					}
				}catch(Exception e){
					e.printStackTrace();
					return "1";
				}
			}
		}
		return "1";
	}

	/*  
	 * goto修改功能注册
	 */
	@RequestMapping(value = "gotoUpdatePopereg.do")
	public ModelAndView gotoUpdatePopereg(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap modelMap, String actionName, String functionCode) {
		
		PoperegBo poperegBo = new PoperegBo();
		poperegBo.setFunctionCode(functionCode);
		poperegBo.setActionName(actionName);
		
		modelMap.put("popereg", poperegSvc.getPoperegBo(poperegBo));
		modelMap.put("functionList", functionSvc.getFunctionList(null));
		
		return new ModelAndView("user/popereg/popereg_update",modelMap);
	}
	

	/* 
	 * 功能信息修改
	 */
	@RequestMapping(value = "updatePopereg.do")
	@ResponseBody
	public String updatePopereg(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,ModelMap modelMap, @ModelAttribute("popereg") RomSysPopedom popereg) {
		
		String functionCodeOld=request.getParameter("functionCodeOld");
		String actionNameOld=request.getParameter("actionNameOld");
		
		RomSysPopedom param = new RomSysPopedom();
		param.setFunctionCode(functionCodeOld);
		param.setActionName(actionNameOld);
		
		if(popereg.getFunctionCode()!=null && !"".equals(popereg.getFunctionCode())
				&& popereg.getActionName()!=null && !"".equals(popereg.getActionName())){
			try{

				String opContent="修改功能注册：";
				if(functionCodeOld.equals(popereg.getFunctionCode()) && actionNameOld.equals(popereg.getActionName())){ //只改操作项
					poperegSvc.updatePopereg(popereg,param);
					opContent=opContent+"功能链接="+popereg.getActionName()+"，所属功能="+request.getParameter("functionLabelOld");
				}else{
					RomSysPopedom romSysPopedom = new RomSysPopedom();
					romSysPopedom.setFunctionCode(popereg.getFunctionCode());
					romSysPopedom.setActionName(popereg.getActionName());
					List<RomSysPopedom> poperegList = poperegSvc.getPoperegList(romSysPopedom);
					if(poperegList!=null && poperegList.size()>0){
						return "2"; //重复
					}else{
						poperegSvc.updatePopereg(popereg,param);
						int flag=0;
						if(!actionNameOld.equals(popereg.getActionName())){
							opContent=opContent+"原功能链接="+actionNameOld+"，修改后功能链接="+popereg.getActionName();
							flag=1;
						}
						if(!functionCodeOld.equals(popereg.getFunctionCode())){
							if(flag==1){
								opContent=opContent+"，原所属功能="+request.getParameter("functionLabelOld")+"，修改后所属功能="+request.getParameter("functionLabel");
							}else{
								opContent=opContent+"功能链接="+actionNameOld+"，原所属功能="+request.getParameter("functionLabelOld")+"，修改后所属功能="+request.getParameter("functionLabel");
							}
							flag=2;
						}
						
						if(flag==1){
							opContent=opContent+"，所属功能="+request.getParameter("functionLabelOld");
						}
					}
				}

				//保存日志
				String proId=request.getParameter("proId");
				String opCode=request.getParameter("opCode");
				Date opTime=new Date();
				this.saveLog(session, proId, opCode, opTime, opContent, "");
				
				return "0"; //更新成功
			}catch(Exception e){
				e.printStackTrace();
				return "1"; //更新失败
			}
		}
		
		return "1";
	}

	@ResponseBody
	@RequestMapping(value = "delPopereg.do")
	public String delPopereg(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap modelMap, String actionName, String functionCode) {
		
		AjaxResponsePacket responsePacked = new AjaxResponsePacket();

		try{
			
			if(actionName!=null && !"".equals(actionName) && functionCode!=null && !"".equals(functionCode)){
				RomSysPopedom romSysPopedom = new RomSysPopedom();
				romSysPopedom.setFunctionCode(functionCode);
				romSysPopedom.setActionName(actionName);

				//远程主机管理表
				if(poperegSvc.delPopereg(romSysPopedom)){
					responsePacked.data.put("retCode", "1"); //删除成功
					
					//保存日志
					String proId=request.getParameter("proId");
					String opCode=request.getParameter("opCode");
					String opContent="删除功能注册：功能链接="+actionName+"，所属功能="+request.getParameter("functionName")+" "+functionCode;
					Date opTime=new Date();
					this.saveLog(session, proId, opCode, opTime, opContent, "");
					
				}else{
					responsePacked.data.put("retCode", "0"); //删除失败
				}
				
			}else{
				responsePacked.data.put("retCode", "0"); //删除失败
			}
			
		}catch(Exception e){
			responsePacked.data.put("retCode", "0"); //删除失败
			e.printStackTrace();
		}
		
		return responsePacked.getAjaxPacketText();
	}
	
	
	/* 
	 * 获取功能编码对应的操作列表
	 */
	@RequestMapping(value = "getFuncOpers.do")
	@ResponseBody
	public String getFuncOpers(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,ModelMap modelMap,String functionCode) {
		
		StringBuffer sb = new StringBuffer("");
		sb.append("<option value=\"\">"+StringUtil.encodeUrI(Constants.OPER_NULL_NAME)+"</option>");
		
		if(functionCode!=null && !"".equals(functionCode)){
			List<RomOperaCode> operList = poperegSvc.getOpersForFunc(functionCode);
			for(RomOperaCode oper:operList){
				sb.append("<option value=\""+oper.getOperaCode()+"\">"+StringUtil.encodeUrI(oper.getOperaName())+"</option>");
			}
		}
		return sb.toString();
	}
}
