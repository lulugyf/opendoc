package com.sitech.rom.rpt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sitech.rom.rpt.base.IMyBaseDao;
import com.sitech.rom.rpt.bo.BOServer;
import com.sitech.rom.rpt.bo.DBConn;
import com.sitech.rom.rpt.bo.TaskConf;
import com.sitech.rom.rpt.bo.TaskResult;
import com.sitech.rom.util.AjaxResponsePacket;

@Controller
public class BOServerController {
	@Resource
	private IMyBaseDao dao;
	
	List<String> jobRunTimeMList = new ArrayList<String>();
	List<String> jobRunTimeHList = new ArrayList<String>();
	List<String> jobRunTimemList = new ArrayList<String>();
	
	private final Logger log = Logger.getLogger(getClass());
	
	@RequestMapping(value = "boservermain.do")
	public String boservermain(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		return "rpt/boserver/boserver_main";
	}

	@RequestMapping(value = "boserverList.do")
	public String boserverList(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		BOServer bo = new BOServer();
		
		String pageNum = request.getParameter("pageNum").trim();
		System.out.println("pageNum:" + pageNum);
		bo.setPageNum(Integer.parseInt(pageNum));
		
		bo.setBoname(request.getParameter("boname"));
		bo.setUsername(request.getParameter("username"));
		bo.setAuthaddr(request.getParameter("authaddr"));
		bo.setOpendocaddr(request.getParameter("opendocaddr"));
		
		request.setAttribute("list", dao.queryForPageList("boserver.qryBOServer",bo));
		request.setAttribute("bo", bo);
		
		return "rpt/boserver/boserver_list";
	}
	
	@RequestMapping(value = "gotoAddBOServer.do")
	public String gotoAddBOServer(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
//		request.setAttribute("DBConnList", dao.queryForList("sdbconns.qryConns",new DBConn()));


		return "rpt/boserver/boserver_add";
	}
	
	@RequestMapping(value = "addBOServer.do")
	public String addBOServer(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,@ModelAttribute("BOServer") BOServer bo) {
 	
		boolean r = false;
		String err = null;
		
		bo.setBoid((int)dao.nextval("boserver"));
		
		try {
			dao.insert("boserver.insertBOServer", bo);
			r = true;
		} catch (RuntimeException e) {
			err = e.getMessage();
		}
		
		if(r){
			request.setAttribute("operInfo","新增配置成功！");			
		}else{
			request.setAttribute("operInfo","新增配置失败！ "+err);
		}
		
		return "forward:gotoAddBOServer.do";		
	}	

	
	@RequestMapping(value = "gotoUpdateBOServer.do")
	public String gotoUpdateBOServer(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		BOServer qry = new BOServer();
		qry.setBoid(Integer.parseInt(request.getParameter("boid").trim()));

		request.setAttribute("bo", dao.queryForObject("boserver.qryBOServer", qry));
		return "rpt/boserver/boserver_update";
	}
	
	@RequestMapping(value = "updateBOServer.do")
	public String updateBOServer(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@ModelAttribute("BOServer") BOServer bo) {
		boolean r = false;
		String err = null;
		try {
			dao.update("boserver.updateBOServer", bo);
			r = true;
		} catch (RuntimeException e) {
			err = e.getMessage();
		}
		
		if(r){
			request.setAttribute("operInfo","修改配置成功！");			
		}else{
			request.setAttribute("operInfo","修改配置失败！ "+err);
		}
		return "forward:gotoUpdateBOServer.do";
	}
	

	@ResponseBody
	@RequestMapping(value = "delBOServer.do")
	public String delBOServer(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		String boid = request.getParameter("boid").trim();
		AjaxResponsePacket responsePacked = new AjaxResponsePacket();
		String err = "none";
		try{
			if(dao.delete("boserver.deleteBOServer", Integer.parseInt(boid)) > 0)
				responsePacked.data.put("retCode", "1");
			else
				responsePacked.data.put("retCode", "0");
		}catch(Exception e){
			responsePacked.data.put("retCode", "0"); //删除失败
			err = e.getMessage();
			e.printStackTrace();
		}
		responsePacked.data.put("retMsg", err);
		return responsePacked.getAjaxPacketText();
	}
	
	
}
