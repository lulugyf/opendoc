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
import com.sitech.rom.rpt.bo.TESTServer;
import com.sitech.rom.rpt.bo.DBConn;
import com.sitech.rom.rpt.bo.TaskConf;
import com.sitech.rom.rpt.bo.TaskResult;
import com.sitech.rom.util.AjaxResponsePacket;

@Controller
public class TESTServerController {
	@Resource
	private IMyBaseDao dao;
	
	List<String> jobRunTimeMList = new ArrayList<String>();
	List<String> jobRunTimeHList = new ArrayList<String>();
	List<String> jobRunTimemList = new ArrayList<String>();
	
	private final Logger log = Logger.getLogger(getClass());
	
	@RequestMapping(value = "testservermain.do")
	public String testservermain(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		return "rpt/testserver/testserver_main";
	}

	@RequestMapping(value = "testserverList.do")
	public String testserverList(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		TESTServer bo = new TESTServer();
		bo.setOrder_id(request.getParameter("order_id"));
		bo.setServ_ip(request.getParameter("serv_ip"));
		bo.setServ_name(request.getParameter("serv_name"));
		bo.setServ_user(request.getParameter("serv_user"));
		
		request.setAttribute("list", dao.queryForList("testserver.qryTESTServer",bo));
		
		return "rpt/testserver/testserver_list";
	}
	
	@RequestMapping(value = "gotoAddTESTServer.do")
	public String gotoAddBOServer(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
//		request.setAttribute("DBConnList", dao.queryForList("sdbconns.qryConns",new DBConn()));


		return "rpt/testserver/testserver_add";
	}
	
	@RequestMapping(value = "addTESTServer.do")
	public String addBOServer(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,@ModelAttribute("TESTServer") TESTServer bo) {
 	
		boolean r = false;
		String err = null;
		
		//bo.setBoid((int)dao.nextval("boserver"));
		
		try {
			dao.insert("testserver.insertTESTServer", bo);
			r = true;
		} catch (RuntimeException e) {
			err = e.getMessage();
		}
		
		if(r){
			request.setAttribute("operInfo","新增配置成功！");	
		}else{
			request.setAttribute("operInfo","新增配置失败！ "+err);
		}
		
		return "forward:gotoAddTESTServer.do";		
	}	

	
	@RequestMapping(value = "gotoUpdateTESTServer.do")
	public String gotoUpdateBOServer(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		TESTServer qry = new TESTServer();
		qry.setOrder_id(request.getParameter("order_id").trim());

		request.setAttribute("bo", dao.queryForObject("testserver.qryTESTServer", qry));
		return "rpt/testserver/testserver_update";
	}
	
	@RequestMapping(value = "updateTESTServer.do")
	public String updateBOServer(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@ModelAttribute("TESTServer") TESTServer bo) {
		boolean r = false;
		String err = null;
		try {
			dao.update("testserver.updateTESTServer", bo);
			r = true;
		} catch (RuntimeException e) {
			err = e.getMessage();
		}
		
		if(r){
			request.setAttribute("operInfo","修改配置成功！");			
		}else{
			request.setAttribute("operInfo","修改配置失败！ "+err);
		}
		return "forward:gotoUpdateTESTServer.do";
	}
	

	@ResponseBody
	@RequestMapping(value = "deleteTESTServer.do")
	public String delBOServer(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		String order_id = request.getParameter("order_id").trim();
		AjaxResponsePacket responsePacked = new AjaxResponsePacket();
		String err = "none";
		try{
			if(dao.delete("testserver.deleteTESTServer", Integer.parseInt(order_id)) > 0)
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
