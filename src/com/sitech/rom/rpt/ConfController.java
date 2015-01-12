package com.sitech.rom.rpt;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sitech.rom.common.bo.LoginProBo;
import com.sitech.rom.common.dto.RomProCode;
import com.sitech.rom.common.dto.RomSysFunction;
import com.sitech.rom.common.dto.RomSysPopedom;
import com.sitech.rom.rpt.base.DocService;
import com.sitech.rom.rpt.base.IMyBaseDao;
import com.sitech.rom.rpt.bo.BOServer;
import com.sitech.rom.rpt.bo.Doc;
import com.sitech.rom.rpt.bo.DocGroup;
import com.sitech.rom.rpt.bo.DocParam;
import com.sitech.rom.rpt.bo.ParamData;
import com.sitech.rom.rpt.bo.ParamType;
import com.sitech.rom.rpt.bo.ParamUser;
import com.sitech.rom.rpt.bo.QueryAll;
import com.sitech.rom.util.AjaxResponsePacket;
import com.sitech.rom.util.Constants;
import com.sitech.rom.util.RequestUtils;
import com.sitech.rom.util.StringUtil;

@Controller
public class ConfController {
	@Resource
	private IMyBaseDao dao;
	
	@Resource
	private DocService docsvc;
	
	private final Logger log = Logger.getLogger(getClass());
	
	@RequestMapping(value = "rptconf_main.do")
	public String rptconf_main(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		request.setAttribute("paramtypelist", dao.queryForList("rptparam.qryType"));
		request.setAttribute("datatypelist", ParamType.getDataTypeList());
		request.setAttribute("loginlist", dao.queryForList("rptparam.selUser"));
		request.setAttribute("bolist", dao.queryForList("boserver.qryBOServer"));
		return "rpt/rptconf_main";
	}

	@ResponseBody
	@RequestMapping(value = "getrpttree.do")
	public String getrpttree(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		try{
			j.put("data", docsvc.getDocTree(dao));
			ret = 0;
		}catch(Throwable e){
			j.put("msg", "failed:"+e.getMessage());
		}
		j.put("ret", ret);
		return j.toString(4);
	}
	
	@ResponseBody
	@RequestMapping(value = "getrptparam.do")
	public String getrptparam(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		try{
			int docid = Integer.parseInt(request.getParameter("docid"));
			j.put("data", docsvc.getDocParam(docid));
			ret = 0;
		}catch(Throwable e){
			j.put("msg", "failed:"+e.getMessage());
		}
		j.put("ret", ret);
		return j.toString(4);
	}
	
	@ResponseBody
	@RequestMapping(value = "getparamtype.do")
	public String getparamtype(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		try{
			List<ParamType> list = (List<ParamType>)dao.queryForList("rptparam.qryType");
			j.put("data", JSONArray.fromObject(list));
			ret = 0;
		}catch(Throwable e){
			j.put("msg", "failed:"+e.getMessage());
		}
		j.put("ret", ret);
		return j.toString(4);
	}
	
	
	@ResponseBody
	@RequestMapping(value = "addrptgroup.do")
	public String addrptgroup(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		try{
			DocGroup dg = new DocGroup();
			dg.setGroup_name(request.getParameter("group_name"));
			dg.setParent_group(request.getParameter("parent_group"));
			String group_func = docsvc.addGroup(dg);
			j.put("group_func", group_func);
			ret = 0;
		}catch(Throwable e){
			j.put("msg", "failed:"+e.getMessage());
		}

		j.put("ret", ret);
		return j.toString(4);
	}
	
	@ResponseBody
	@RequestMapping(value = "modrptgroup.do")
	public String modrptgroup(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		try{
			DocGroup dg = new DocGroup();
			String group_name = request.getParameter("group_name");
			String group_func = request.getParameter("group_func");
			dg.setGroup_name(group_name);
			dg.setGroup_func(group_func);
			docsvc.modGroup(dg);
			ret = 0;
		}catch(Throwable e){
			j.put("msg", "failed:"+e.getMessage());
		}
		j.put("ret", ret);
		return j.toString(4);
	}
	
	@ResponseBody
	@RequestMapping(value = "delrptgroup.do")
	public String delrptgroup(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		try{
			DocGroup dg = new DocGroup();
			String group_func = request.getParameter("group_func");
			dg.setGroup_func(group_func);
			docsvc.delGroup(dg);
			ret = 0;
		}catch(Throwable e){
			j.put("msg", "failed:"+e.getMessage());
		}
		j.put("ret", ret);
		return j.toString(4);
	}

	@ResponseBody
	@RequestMapping(value = "addrptdoc.do")
	public String addrptdoc(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		try{
			Doc doc = new Doc();

			doc.setGroup_func(request.getParameter("group_func"));
//			doc.setBaseurl(request.getParameter("baseurl"));
			doc.setDocname(request.getParameter("docname"));
			doc.setRemarks(request.getParameter("remarks"));
			
			BOServer bo = new BOServer();
			bo.setBoid(Integer.parseInt(request.getParameter("boid")));
			bo = (BOServer)dao.queryForObject("boserver.qryBOServer", bo);
			String baseurl = String.format("http://%s/BOE/OpenDocument/opendoc/openDocument.jsp?sIDType=CUID&iDocID=%s&buttonrefresh=hide", 
					bo.getOpendocaddr(), request.getParameter("opendocid"));
			doc.setBaseurl(baseurl);
			
			doc.setBoid(bo.getBoid());
			doc.setOpendocid(request.getParameter("opendocid"));
			docsvc.addDoc(doc);
			j.put("docid", doc.getDocid());
			j.put("function_code", doc.getFunction_code());
			ret = 0;
		}catch(Throwable e){
			j.put("msg", "failed:"+e.getMessage());
		}
		j.put("ret", ret);
		return j.toString(4);
	}

	@ResponseBody
	@RequestMapping(value = "modrptdoc.do")
	public String modrptdoc(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		try{
			Doc doc = new Doc();
			doc.setDocid(Integer.parseInt(request.getParameter("docid")));
			//doc.setBaseurl(request.getParameter("baseurl"));
			doc.setDocname(request.getParameter("docname"));
			doc.setRemarks(request.getParameter("remarks"));
			
			BOServer bo = new BOServer();
			bo.setBoid(Integer.parseInt(request.getParameter("boid")));
			bo = (BOServer)dao.queryForObject("boserver.qryBOServer", bo);
			String baseurl = String.format("http://%s/BOE/OpenDocument/opendoc/openDocument.jsp?sIDType=CUID&iDocID=%s&buttonrefresh=hide", 
					bo.getOpendocaddr(), request.getParameter("opendocid"));
			doc.setBaseurl(baseurl);
			
			doc.setBoid(Integer.parseInt(request.getParameter("boid")));
			doc.setOpendocid(request.getParameter("opendocid"));
			docsvc.modDoc(doc);
			ret = 0;
		}catch(Throwable e){
			j.put("msg", "failed:"+e.getMessage());
		}
		j.put("ret", ret);
		return j.toString(4);
	}

	@ResponseBody
	@RequestMapping(value = "delrptdoc.do")
	public String delrptdoc(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		try{
			docsvc.delDoc(Integer.parseInt(request.getParameter("docid")));
			ret = 0;
		}catch(Throwable e){
			j.put("msg", "failed:"+e.getMessage());
		}
		j.put("ret", ret);
		return j.toString(4);
	}

	@ResponseBody
	@RequestMapping(value = "adddocparam.do")
	public String adddocparam(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		try{
			DocParam dp = new DocParam();
			dp.setDocid(Integer.parseInt(request.getParameter("docid")));
			dp.setPnametype(request.getParameter("pnametype"));
			dp.setParam(request.getParameter("param"));
			dp.setDefault_value(request.getParameter("default_value"));
			dp.setFilterflag(Integer.parseInt(request.getParameter("filterflag")));
			dp.setAllowchange(Integer.parseInt(request.getParameter("allowchange")));
			dp.setTypeid(Integer.parseInt(request.getParameter("typeid")));
			dp.setRemarks(request.getParameter("remarks"));
			docsvc.addDocParam(dp);
			ret = 0;
		}catch(Throwable e){
			e.printStackTrace();
			j.put("msg", "failed:"+e.getMessage());
		}
		j.put("ret", ret);
		return j.toString(4);
	}

	@ResponseBody
	@RequestMapping(value = "moddocparam.do")
	public String moddocparam(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		try{
			DocParam dp = new DocParam();
			dp.setParamid(Integer.parseInt(request.getParameter("paramid")));
			dp.setDocid(Integer.parseInt(request.getParameter("docid")));
			dp.setPnametype(request.getParameter("pnametype"));
			dp.setParam(request.getParameter("param"));
			dp.setDefault_value(request.getParameter("default_value"));
			dp.setFilterflag(Integer.parseInt(request.getParameter("filterflag")));
			dp.setAllowchange(Integer.parseInt(request.getParameter("allowchange")));
			dp.setTypeid(Integer.parseInt(request.getParameter("typeid")));
			dp.setRemarks(request.getParameter("remarks"));
			docsvc.modDocParam(dp);
			ret = 0;
		}catch(Throwable e){
			j.put("msg", "failed:"+e.getMessage());
		}
		j.put("ret", ret);
		return j.toString(4);
	}

	@ResponseBody
	@RequestMapping(value = "deldocparam.do")
	public String deldocparam(HttpServletRequest request,
			HttpServletResponse response, HttpSession session)
	{
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		try{
			DocParam dp = new DocParam();
			dp.setParamid(Integer.parseInt(request.getParameter("paramid")));
			dp.setDocid(Integer.parseInt(request.getParameter("docid")));
			dp.setParam(request.getParameter("param"));
			docsvc.delDocParam(dp);
			ret = 0;
		}catch(Throwable e){
			j.put("msg", "failed:"+e.getMessage());
		}
		j.put("ret", ret);
		return j.toString(4);
	}
	
}
