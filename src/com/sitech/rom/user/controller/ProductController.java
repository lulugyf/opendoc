package com.sitech.rom.user.controller;

import java.io.UnsupportedEncodingException;
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

import com.sitech.rom.common.busi.BaseController;
import com.sitech.rom.common.dto.RomHostInfo;
import com.sitech.rom.common.dto.RomProCode;
import com.sitech.rom.common.dto.RomProHostRelation;
import com.sitech.rom.common.dto.RomSysFunction;
import com.sitech.rom.common.dto.RomSysLogin;
import com.sitech.rom.common.dto.RomSysProFunction;
import com.sitech.rom.user.service.FunctionSvc;
import com.sitech.rom.user.service.ProFunctionSvc;
import com.sitech.rom.user.service.ProductSvc;
import com.sitech.rom.util.AjaxResponsePacket;
import com.sitech.rom.util.Constants;

@Controller
public class ProductController extends BaseController {

	@Resource
	private ProductSvc productSvc;
	@Resource
	private FunctionSvc functionSvc;
	@Resource
	private ProFunctionSvc proFunctionSvc;
	
	@RequestMapping(value = "product.do")
	public String product(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {

		//List<RomProCode> productList=productSvc.getProList(new RomProCode());
		//request.setAttribute("productList", productList);
		
		return "user/product/product_main";
	}
	
	@RequestMapping(value = "productList.do")
	public String productList(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {

		String proCode = request.getParameter("proCode").trim();
	    String proName = request.getParameter("proName").trim();
		
	    RomProCode qryobj = new RomProCode();
	    
	    if(proCode!=null && !"".equals(proCode))qryobj.setProCode(proCode);
	    if(proName!=null && !"".equals(proName))qryobj.setProName(proName);
		List<RomProCode> productList=productSvc.getProList(qryobj);
		request.setAttribute("productList", productList);
		
		return "user/product/product_list";
	}
    	
	@RequestMapping(value = "gotoAddProduct.do")
	public String gotoAddProduct(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
 
		return "user/product/product_add";
	}
	
	@RequestMapping(value = "addProduct.do")
	public String addProduct(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
 		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
 		String proName = request.getParameter("proName").trim();
 		String proVersion = request.getParameter("proVersion").trim();
 		String remarks = request.getParameter("remarks").trim();
	    RomProCode qryObj = new RomProCode();
	    
	    System.out.println("====proName:"+proName);
 		
		qryObj.setProName(proName);
		qryObj.setProVersion(proVersion);
		int length = productSvc.getProList(qryObj).size();
		if(length==0){
			qryObj.setRemarks(remarks);
			if(productSvc.addProduct(qryObj)){
				request.setAttribute("operInfo", "产品添加成功！!"+proName);

				//保存日志
				String proId=request.getParameter("proId");
				String opCode=request.getParameter("opCode");
				String opContent="新增产品：产品名称="+proName+"，版本="+proVersion;
				Date opTime=new Date();
				this.saveLog(session, proId, opCode, opTime, opContent, "");
			}else{
				request.setAttribute("operInfo", "产品添加失败！");
			}
		}else{
			request.setAttribute("operInfo", "该产品名称与版本号已存在，产品添加失败！");
		}
		
		return "forward:gotoAddProduct.do";
	}
	
	@RequestMapping(value = "gotoUpdateProduct.do")
	public String gotoUpdateProduct(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, String productCode) {
 
		//产品信息表
		RomProCode qryObj=new RomProCode();
		qryObj.setProCode(productCode);
		RomProCode romProCode=productSvc.getPro(qryObj);
		request.setAttribute("romProCode", romProCode);
		
		return "user/product/product_update";
	}
	
	@RequestMapping(value = "updateProduct.do")
	public String updateProduct(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, @ModelAttribute("code") RomProCode romProCode,String productCode) {
		
		RomProCode qryObj=new RomProCode();
		qryObj.setProCode(productCode);
		qryObj=productSvc.getPro(qryObj);
		boolean flag=false;
		String opContent="修改产品：";
		if(qryObj!=null){
			if(qryObj.getProName().equals(romProCode.getProName()) && qryObj.getProVersion().equals(romProCode.getProVersion())){ //名称版本没改
				flag=true;
				opContent=opContent+"产品名称="+romProCode.getProName()+"，版本="+romProCode.getProVersion();
			}else{
				int flagInt=0;
				if(!qryObj.getProName().equals(romProCode.getProName())){
					opContent=opContent+"原产品名称="+qryObj.getProName()+"，修改后产品名称="+romProCode.getProName();
					flagInt=1;
				}
				if(!qryObj.getProVersion().equals(romProCode.getProVersion())){
					if(flagInt==1){
						opContent=opContent+"，原版本="+qryObj.getProVersion()+"，修改后版本="+romProCode.getProVersion();
					}else{
						opContent=opContent+"产品名称="+romProCode.getProName()+"，原版本="+qryObj.getProVersion()+"，修改后版本="+romProCode.getProVersion();
					}
					flagInt=2;
				}
				if(flagInt==1){
					opContent=opContent+"，版本="+romProCode.getProVersion();
				}
				
				qryObj=new RomProCode();
				qryObj.setProName(romProCode.getProName());
				qryObj.setProVersion(romProCode.getProVersion());
				int length = productSvc.getProList(qryObj).size();
				if(length==0){
					flag=true;
				}else{
					request.setAttribute("operInfo", "该产品名称与版本号已存在，产品修改失败！");
				}
			}
		}
		
		if(flag==true){
			RomProCode savevo=new RomProCode();
			savevo.setProCode(productCode);
			savevo.setProName(romProCode.getProName());
			savevo.setProVersion(romProCode.getProVersion());
			savevo.setRemarks(romProCode.getRemarks());
			
			if(productSvc.updateProduct(savevo)){
				request.setAttribute("operInfo", "产品修改成功！");

				//保存日志
				String proId=request.getParameter("proId");
				String opCode=request.getParameter("opCode");
				Date opTime=new Date();
				this.saveLog(session, proId, opCode, opTime, opContent, "");
				
			}else{
				request.setAttribute("operInfo", "产品修改失败！");
			}
		}
		
		return "forward:gotoUpdateProduct.do";
	}
	
	@ResponseBody
	@RequestMapping(value = "delProduct.do")
	public String delProduct(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap modelMap) {
		
		String productCode = request.getParameter("productCode")==null?"":request.getParameter("productCode").trim();
		AjaxResponsePacket responsePacked = new AjaxResponsePacket();

		try{
 
			RomProCode obj=new RomProCode();
			obj.setProCode(productCode);

			//远程主机管理表
			if(productSvc.delProduct(obj)){
				responsePacked.data.put("retCode", "1"); //删除成功

				//保存日志
				String proId=request.getParameter("proId");
				String opCode=request.getParameter("opCode");
				String opContent="删除产品：产品名称="+request.getParameter("proName")+"，版本="+request.getParameter("proVersion");
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
	
	@RequestMapping(value = "gotoUpdateProductFunc.do")
	public String gotoUpdateProductFunc(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, String productCode) {

		//产品信息表
		RomProCode qryObj=new RomProCode();
		qryObj.setProCode(productCode);
		RomProCode romProCode=productSvc.getPro(qryObj);
		request.setAttribute("romProCode", romProCode);
		
		//获取所有可见功能列表
		RomSysFunction romSysFunction = new RomSysFunction();
		//romSysFunction.setNodeType(Constants.FUNC_SHOW); //可见的功能
		List<RomSysFunction> functionList=functionSvc.getFunctionList(romSysFunction);
		request.setAttribute("functionList", functionList);
		
		//已经存在的产品对应的功能列表
		RomSysProFunction qryo=new RomSysProFunction();
		qryo.setProCode(productCode);
		List<RomSysProFunction> proFunctionList=proFunctionSvc.getProFunctionList(qryo);
		String rtn = "";
		for(RomSysProFunction obj:proFunctionList){
			rtn=rtn+obj.getFunctionCode()+";";
		}
		request.setAttribute("proFunctionForChk", rtn);
 	
		return "user/product/product_function_update";
	} 
	
	
	@RequestMapping(value = "setProductFunction.do")
	public String setProductFunction(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {

		String productCode=request.getParameter("productCode");
		String[] funcs=request.getParameterValues("chkfunc");
		try{
			productSvc.setProductFunction(productCode, funcs);
			request.setAttribute("operInfo", "功能设置成功！");
			
			//保存日志
			String proId=request.getParameter("proId");
			String opCode=request.getParameter("opCode");
			String opContent="设置产品对应功能";
			Date opTime=new Date();
			this.saveLog(session, proId, opCode, opTime, opContent, "");
			
		}catch(Exception e){
			request.setAttribute("operInfo", "功能设置失败！");
		}
		
		return "forward:gotoUpdateProductFunc.do";
	}
	
}
