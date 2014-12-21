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

	    String label = request.getParameter("label").trim();
	    String host = request.getParameter("host").trim();
	    String user = request.getParameter("user").trim();
	    String db = request.getParameter("db").trim();
	    String dbtype = request.getParameter("dbtype").trim();

	    if(label!=null && !"".equals(label))qry.setLabel(label);
	    if(host!=null && !"".equals(host))qry.setHost(host);;
	    if(user!=null && !"".equals(user))qry.setUser(user);;
	    if(db!=null && !"".equals(db))qry.setDb(db);
	    if(dbtype!=null && !"".equals(dbtype))qry.setDbtype(dbtype);
		request.setAttribute("rlist", myBaseDao.queryForList("sdbconns.qryConns", qry));
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
			HttpServletResponse response, HttpSession session,
			@ModelAttribute("label") String label) {
		
		request.setAttribute("typelist", myBaseDao.queryForList("sdbconns.qryDBTypes"));
		DBConn qry = new DBConn();
		qry.setLabel(label);
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
		
		String label = request.getParameter("label").trim();
		AjaxResponsePacket responsePacked = new AjaxResponsePacket();
		String err = "none";
		try{
			if(myBaseDao.delete("sdbconns.deleteConns", label) > 0)
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
