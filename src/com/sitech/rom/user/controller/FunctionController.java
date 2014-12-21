package com.sitech.rom.user.controller;

import java.util.Date;

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

import com.sitech.rom.common.bo.FunctionBo;
import com.sitech.rom.common.busi.BaseController;
import com.sitech.rom.common.dto.RomSysFunction;
import com.sitech.rom.common.dto.RomSysProFunction;
import com.sitech.rom.common.dto.RomSysRoleFunction;
import com.sitech.rom.user.service.FunctionSvc;
import com.sitech.rom.user.service.ProFunctionSvc;
import com.sitech.rom.user.service.RoleFunctionSvc;

@Controller
public class FunctionController extends BaseController {

	@Resource
	private FunctionSvc functionSvc;
	@Resource
	private RoleFunctionSvc roleFunctionSvc;
	@Resource
	private ProFunctionSvc proFunctionSvc;
	/* 
	 * goto功能管理主界面
	 */
	@RequestMapping(value = "function.do")
	public ModelAndView function(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,ModelMap modelMap) {
		
		return new ModelAndView("user/function/function_main",modelMap);
	}
	
	/* 
	 * 功能信息查看
	 */
	@RequestMapping(value = "getFuncDetail.do")
	public ModelAndView getFuncDetail(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,ModelMap modelMap,String functionCode) {
		
		if(functionCode!=null && !"".equals(functionCode)){

			FunctionBo functionBo = new FunctionBo();
			functionBo.setFunctionCode(functionCode);
			functionBo=functionSvc.getFunctionBoDetail(functionBo);
			
			System.out.println("====OperationName:"+functionBo.getOperationName()+"]]");
			modelMap.put("functionBo", functionBo);
		}
		
		return new ModelAndView("user/function/function_view",modelMap);
	}
	
	/* 
	 * 获取所有功能节点
	 */
	@RequestMapping(value = "getFuncTree.do")
	public ModelAndView getFuncTree(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,ModelMap modelMap) {

		modelMap.put("functionList", functionSvc.getFunctionList(null));
		
		return new ModelAndView("user/function/function_tree",modelMap);
	}
	
	/* 
	 * goto功能新增
	 */
	@RequestMapping(value = "gotoFuncAdd.do")
	public ModelAndView gotoFuncAdd(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,ModelMap modelMap) {
		
		modelMap.put("functionList", functionSvc.getFunctionList(null));
		modelMap.put("operaArr", functionSvc.getOperaArr());
		
		return new ModelAndView("user/function/function_add",modelMap);
	}
	
	/* 
	 * 功能新增
	 */
	@RequestMapping(value = "functionAdd.do")
	@ResponseBody
	public String functionAdd(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,ModelMap modelMap,@ModelAttribute("function") RomSysFunction function) {
		
		if(function.getFunctionCode()!=null && !"".equals(function.getFunctionCode())){
			RomSysFunction romSysFunction = new RomSysFunction();
			romSysFunction.setFunctionCode(function.getFunctionCode());
			romSysFunction=functionSvc.getFunction(romSysFunction);
			
			if(romSysFunction==null){
				try{
					if(functionSvc.addFunction(function)){
						
						//保存日志
						String proId=request.getParameter("proId");
						String opCode=request.getParameter("opCode");
						String opContent="新增功能节点：功能代码="+function.getFunctionCode()+"，功能名称="+function.getFunctionName();
						Date opTime=new Date();
						this.saveLog(session, proId, opCode, opTime, opContent, "");
						
						return "0";
					}
				}catch(Exception e){
					e.printStackTrace();
					return "1";
				}
				
			}else{
				return "repeat"; //功能重复
			}
		}
		
		return "1";
	}
	
	/* 
	 * goto功能信息修改
	 */
	@RequestMapping(value = "gotoFuncUpdate.do")
	public ModelAndView gotoFuncUpdate(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,ModelMap modelMap,String functionCode) {
		
		if(functionCode!=null && !"".equals(functionCode)){

			FunctionBo functionBo = new FunctionBo();
			functionBo.setFunctionCode(functionCode);
			functionBo=functionSvc.getFunctionBoDetail(functionBo);
			
			modelMap.put("functionBo", functionBo);
			
			modelMap.put("functionList", functionSvc.getFunctionList(null));
			modelMap.put("operaArr", functionSvc.getOperaArr());
		}
		
		return new ModelAndView("user/function/function_update",modelMap);
	}

	/* 
	 * 功能信息修改
	 */
	@RequestMapping(value = "functionUpdate.do")
	@ResponseBody
	public String functionUpdate(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,ModelMap modelMap,@ModelAttribute("function") RomSysFunction function) {
		
		if(function.getFunctionCode()!=null && !"".equals(function.getFunctionCode())){
			try{
				if(functionSvc.updateFunction(function)){
					
					//保存日志
					String proId=request.getParameter("proId");
					String opCode=request.getParameter("opCode");
					String opContent="修改功能节点：功能代码="+function.getFunctionCode()+"，功能名称="+function.getFunctionName();
					Date opTime=new Date();
					this.saveLog(session, proId, opCode, opTime, opContent, "");
					
					return "0"; //更新成功
				}
			}catch(Exception e){
				e.printStackTrace();
				return "1"; //更新失败
			}
		}
		return "1";
	}
	
	/* 
	 * 功能信息删除
	 */
	@RequestMapping(value = "functionDelete.do")
	@ResponseBody
	public String functionDelete(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,ModelMap modelMap,String functionCode,String functionName) {
		
		if(functionCode!=null && !"".equals(functionCode)){
			RomSysFunction romSysFunction = new RomSysFunction();
			romSysFunction.setFunctionCode(functionCode);
			
			RomSysRoleFunction romSysRoleFunction = new RomSysRoleFunction();
			romSysRoleFunction.setFunctionCode(functionCode);
			
			RomSysProFunction romSysProFunction = new RomSysProFunction();
			romSysProFunction.setFunctionCode(functionCode);
			
			try{
				
				functionSvc.delFunction(romSysFunction);
				roleFunctionSvc.deleteSysRoleFunction(romSysRoleFunction);
				proFunctionSvc.delProFunction(romSysProFunction);
				
				//保存日志
				String proId=request.getParameter("proId");
				String opCode=request.getParameter("opCode");
				String opContent="删除功能节点：功能代码="+functionCode+"，功能名称="+functionName;
				Date opTime=new Date();
				this.saveLog(session, proId, opCode, opTime, opContent, "");
				
				return "0";
			}catch(Exception e){
				e.printStackTrace();
				return "1";
			}
		}
		
		return "1";
	}
}
