package com.sitech.rom.user.controller;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sitech.rom.common.bo.LoginProBo;
import com.sitech.rom.common.busi.BaseController;
import com.sitech.rom.common.dto.RomProCode;
import com.sitech.rom.common.dto.RomSysFunction;
import com.sitech.rom.common.dto.RomSysRole;
import com.sitech.rom.user.service.FunctionSvc;
import com.sitech.rom.user.service.PopedomSvc;
import com.sitech.rom.user.service.ProductSvc;
import com.sitech.rom.user.service.RoleSvc;
import com.sitech.rom.util.Constants;
import com.sitech.rom.util.StringUtil;

@Controller
public class PopedomController extends BaseController {
	
	@Resource
	private RoleSvc roleSvc;
	@Resource
	private PopedomSvc popedomSvc;
	@Resource
	private ProductSvc productSvc;
	@Resource
	private FunctionSvc functionSvc;
    /*
     * 菜单树
     */
	@RequestMapping(value = "getPopedomMenu.do")
	@ResponseBody
	public String getPopedomMenu(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap modelMap, String parentNode, String themePath) {
		
		String loginNo = session.getAttribute("loginNo").toString();
		
		List<RomSysFunction> funcList = null;
		StringBuffer htmlTxt = new StringBuffer("");
		
		if(StringUtil.notNull(loginNo)){
			
			htmlTxt.append("tree"+parentNode+" = new MzTreeView('tree"+parentNode+"');");
			htmlTxt.append("tree"+parentNode+".setIconPath('"+request.getContextPath()+"/nresources/"+themePath+"/images/mztree/');");
			htmlTxt.append("with(tree"+parentNode+"){");
			
			List<RomProCode> proList = productSvc.getProList(null);
			for(RomProCode product: proList){
				
				LoginProBo loginProBo = new LoginProBo();
				loginProBo.setLoginNo(loginNo);
				loginProBo.setProCode(product.getProCode());
				
				String proVersion=product.getProVersion()==null?"":product.getProVersion();
				
				funcList = functionSvc.getFunctionListByLoginPro(loginProBo);
				
				RomSysFunction func;
				int len = funcList.size();
				if(len>0){
					for(int i=0; i<funcList.size(); i++){
						func = funcList.get(i);
						String actionName = func.getActionName();
						if(func.getActionName() != null){
							actionName = StringUtil.encodeUrI(func.getActionName());
						}
						
						if(i==0){ //新增一级目录树节点，以产品命名，父节点为顶级节点
							htmlTxt.append("N['"+Constants.TREE_PARENT+"_"+product.getProCode()+"']=\"T:"+StringUtil.encodeUrI(product.getProName()+proVersion)+"\";");
						}
						if(Constants.TREE_PARENT.equals(func.getParentCode())){ //原一级目录挂到新增的产品节点下
							htmlTxt.append("N['"+product.getProCode()+"_"+product.getProCode()+func.getFunctionCode()+"']=\"T:"+StringUtil.encodeUrI(func.getFunctionName())+";C:L('"+func.getOpenType()+"','"+product.getProCode()+"-"+func.getFunctionCode()+"','"+StringUtil.encodeUrI(product.getProName()+proVersion+"-"+func.getFunctionName())+"','"+actionName+"','000','"+product.getProCode()+"')\";");
						}else{ //其他级别关系不变
							htmlTxt.append("N['"+product.getProCode()+func.getParentCode()+"_"+product.getProCode()+func.getFunctionCode()+"']=\"T:"+StringUtil.encodeUrI(func.getFunctionName())+";C:L('"+func.getOpenType()+"','"+product.getProCode()+"-"+func.getFunctionCode()+"','"+StringUtil.encodeUrI(product.getProName()+proVersion+"-"+func.getFunctionName())+"','"+actionName+"','000','"+product.getProCode()+"')\";");
						}
					}
					
				}
				
			}
		}

		htmlTxt.append("}");
		htmlTxt.append("$('#node"+parentNode+"').html(tree"+parentNode+".toString());");
		
		return htmlTxt.toString();
	}
	
    /*
     * goto角色权限设置
     */
	@RequestMapping(value = "gotoSetPopedom.do")
	public String gotoSetPopedom(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap modelMap) {
		
		String roleId=request.getParameter("roleId");
		
		RomSysRole qryPara=new RomSysRole();
		qryPara.setRoleId(Long.valueOf(roleId));
		qryPara=roleSvc.getSysRole(qryPara);
		
		if(qryPara!=null){
			modelMap.put("roleId", roleId);
			modelMap.put("popedomBoList", popedomSvc.getPopedomBoList(qryPara));
			modelMap.put("popedomForChk", popedomSvc.getPopedomChkList(roleId));
		}
		
		return "user/popedom/popedom_main";
	}

    /*
     * 角色权限设置
     */
	@RequestMapping(value = "setPopedom.do")
	@ResponseBody
	public String setPopedom(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap modelMap) {
		
		String roleId=request.getParameter("roleId");
		String[] funcs=request.getParameter("chkfunc").split(",");
		String[] func_opers=request.getParameter("chkoper").split(",");
		
		try{
			popedomSvc.setPopedomRole(roleId, funcs, func_opers);

			//保存日志
			String proId=request.getParameter("proId");
			String opCode=request.getParameter("opCode");
			String opContent="角色权限设置：角色名称="+request.getParameter("roleName");
			Date opTime=new Date();
			this.saveLog(session, proId, opCode, opTime, opContent, "");
			
			return "0"; //权限设置成功
		}catch(Exception e){
			e.printStackTrace();
			return "1"; //权限设置失败
		}
	}
}
