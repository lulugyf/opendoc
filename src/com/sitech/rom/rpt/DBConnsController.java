package com.sitech.rom.rpt;

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

import com.sitech.jcf.core.exception.BusiException;
import com.sitech.rom.common.bo.LoginBo;
import com.sitech.rom.common.bo.RoleBo;
import com.sitech.rom.common.busi.BaseController;
import com.sitech.rom.common.dao.RomSysLoginDao;
import com.sitech.rom.common.dto.RomLoginRoleRelation;
import com.sitech.rom.common.dto.RomProCode;
import com.sitech.rom.common.dto.RomProvinceCode;
import com.sitech.rom.common.dto.RomSysLogin;
import com.sitech.rom.common.dto.RomSysRole;
import com.sitech.rom.common.dto.RomTellcorpCode;
import com.sitech.rom.common.dto.Seq;
import com.sitech.rom.rpt.base.DaoUtil;
import com.sitech.rom.rpt.base.IMyBaseDao;
import com.sitech.rom.rpt.bo.DBConn;
import com.sitech.rom.user.service.LoginSvc;
import com.sitech.rom.user.service.ProvinceSvc;
import com.sitech.rom.user.service.RoleSvc;
import com.sitech.rom.util.AjaxResponsePacket;
import com.sitech.rom.util.Constants;
import com.sitech.rom.util.StringUtil;

import static java.lang.String.format;

@Controller
public class DBConnsController {
	
	@Resource
	private IMyBaseDao myBaseDao;

	private final Logger log = Logger.getLogger(getClass());
	
	
	@RequestMapping(value = "dbconnsMain.do")
	public String dbconnsMain(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		request.setAttribute("typelist", myBaseDao.queryForList("sdbconns.qryDBTypes"));
		return "rpt/task/dbconn_main";
	}
	
	
	@RequestMapping(value = "dbconnsList.do")
	public String dbconnsList(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		DBConn qry = new DBConn();
		
		String pageNum = request.getParameter("pageNum").trim();
		System.out.println("pageNum:" + pageNum);
		qry.setPageNum(Integer.parseInt(pageNum));

	    String serv_ip = request.getParameter("serv_ip").trim();
	    String serv_name = request.getParameter("serv_name").trim();
	    String serv_user = request.getParameter("serv_user").trim();
	    String db_type = request.getParameter("db_type").trim();
	    String db_name = request.getParameter("db_name").trim();
	    String db_port = request.getParameter("db_port").trim();
	    String db_user = request.getParameter("db_user").trim();

	    if(serv_ip!=null && !"".equals(serv_ip))qry.setServ_ip(serv_ip);
	    if(serv_name!=null && !"".equals(serv_name))qry.setServ_name(serv_name);
	    if(serv_user!=null && !"".equals(serv_user))qry.setServ_user(serv_user);
	    if(db_type!=null && !"".equals(db_type))qry.setDb_type(db_type);
	    if(db_name!=null && !"".equals(db_name))qry.setDb_name(db_name);
	    if(db_port!=null && !"".equals(db_port))qry.setDb_port(Integer.parseInt(db_port));
	    if(db_user!=null && !"".equals(db_user))qry.setDb_user(db_user);
		request.setAttribute("rlist", myBaseDao.queryForPageList("sdbconns.qryConns", qry));
		request.setAttribute("bo", qry);
		return "rpt/task/dbconn_list";
	}
	
	
	@RequestMapping(value = "gotoAddDBConn.do")
	public String gotoAddDBConn(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		request.setAttribute("typelist", myBaseDao.queryForList("sdbconns.qryDBTypes"));
		
		return "rpt/task/dbconn_add";		
	}

	@RequestMapping(value = "addDBConn.do")
	public String addDBConn(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,@ModelAttribute("DBConn") DBConn c) {
 	
		boolean r = false;
		String err = null;
		
		long order_id = myBaseDao.nextval("dbconn");
		c.setOrder_id((int)order_id);
		try {
			myBaseDao.insert("sdbconns.insertConns", c);
			r = true;
		} catch (RuntimeException e) {
			//throw new  BusiException("1000",e.getMessage());
			//r = false;
			err = e.getMessage();
		}
		
		if(r){
			request.setAttribute("operInfo","新增连接配置成功！");			
		}else{
			request.setAttribute("operInfo","新增连接配置失败！ "+err);
		}
		
		return "forward:gotoAddDBConn.do";		
	}	

	
	@RequestMapping(value = "gotoUpdateDBConn.do")
	public String gotoUpdateDBConn(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		request.setAttribute("typelist", myBaseDao.queryForList("sdbconns.qryDBTypes"));
		String order_id = request.getParameter("order_id").trim();
		DBConn qry = new DBConn();
//		qry.setLabel(label);
		qry.setOrder_id(Integer.parseInt(order_id));
		request.setAttribute("db", myBaseDao.queryForObject("sdbconns.qryConns", qry));
		return "rpt/task/dbconn_update";
	}
	
	@RequestMapping(value = "updateDBConn.do")
	public String updateDBConn(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@ModelAttribute("DBConn") DBConn c) {
		boolean r = false;
		String err = null;
		try {
			myBaseDao.update("sdbconns.updateDBConn", c);
			r = true;
		} catch (RuntimeException e) {
			err = e.getMessage();
		}
		
		if(r){
			request.setAttribute("operInfo","修改连接配置成功！");			
		}else{
			request.setAttribute("operInfo","修改连接配置失败！ "+err);
		}
		return "forward:gotoUpdateDBConn.do";
	}

	@ResponseBody
	@RequestMapping(value = "delDBConn.do")
	public String delDBConn(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		String order_id = request.getParameter("order_id").trim();
		AjaxResponsePacket responsePacked = new AjaxResponsePacket();
		String err = "none";
		try{
			if(myBaseDao.delete("sdbconns.deleteConns", order_id) > 0)
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
