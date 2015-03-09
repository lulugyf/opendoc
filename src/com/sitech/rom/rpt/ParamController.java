package com.sitech.rom.rpt;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
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
import com.sitech.rom.rpt.base.IMyBaseDao;
import com.sitech.rom.rpt.bo.ParamData;
import com.sitech.rom.rpt.bo.ParamType;
import com.sitech.rom.rpt.bo.ParamUser;
import com.sitech.rom.rpt.bo.QueryAll;
import com.sitech.rom.util.AjaxResponsePacket;
import com.sitech.rom.util.Constants;
import com.sitech.rom.util.RequestUtils;
import com.sitech.rom.util.StringUtil;

@Controller
public class ParamController {
	@Resource
	private IMyBaseDao dao;
	
	@Resource
	private ParamService parSvc;
	
	private final Logger log = Logger.getLogger(getClass());
	
	// http://localhost:8081/rom/paramcfg_main.do?opCode=PARAMCFG&opName=报表0-报表参数配置报表0-报表参数配置&proId=P001&provinceCode=-1&tellType=-1
	@RequestMapping(value = "paramcfg_main.do")
	public String paramMain(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		List<ParamType> typelist = (List<ParamType>)dao.queryForList("rptparam.qryType");
		request.setAttribute("typelist", typelist);
		request.setAttribute("datatypelist", ParamType.getDataTypeList());
		return "rpt/param/param_main";
	}
	
	@ResponseBody
	@RequestMapping(value = "addparamtype.do")
	public String addType(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		//新增类型并返回其typeid, 如果 typeid 为 0， 则是新增； 如果>0, 则视为修改
		// 如果参数 optype=delete && typeid > 0, 则为删除
		
		/*for(Enumeration enu = request.getParameterNames(); enu.hasMoreElements(); ){
			String n = (String)enu.nextElement();
			System.out.printf("%s=%s\n", n, request.getParameter(n));
		}*/
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		
		String typeid = request.getParameter("typeid");
		try{
			if("0".equals(typeid)){
				ParamType pt = RequestUtils.requestToObject(request, ParamType.class);
				pt.setTypeid((int)dao.nextval("paramtype"));
				dao.insert("rptparam.addType", pt);
				ret = 0;
				j = JSONObject.fromObject(pt);
			}else if("delete".equals(request.getParameter("optype"))){
				int count = dao.count("rptparam.countDataByType", Integer.parseInt(typeid));
				if(count > 0){
					ret = -2;
					j.put("msg", "该参数类型下仍有数据，不能删除！");
				}else{
					dao.delete("rptparam.delType", Integer.parseInt(typeid));
					ret = 0;
					j.put("optype", "delete");
					j.put("typeid", typeid);
				}
			}else{
				ParamType pt = RequestUtils.requestToObject(request, ParamType.class);
				Map<String, Object> hm = new HashMap<String, Object>();
				hm.put("typeid", pt.getTypeid());
				hm.put("name", pt.getName());
				hm.put("datatype", pt.getDatatype());
				hm.put("remarks", pt.getRemarks());
				dao.update("rptparam.updateType", hm);
				ret = 0;
				j = JSONObject.fromObject(pt);
				j.put("optype", "update");
			}
		}catch(Throwable e){
			log.error("failed", e);
		}
		j.put("ret", ret);
		return j.toString(4);
		
		//http://localhost:8081/rom/addtype.do?opCode=PARAMCFG&proId=P001&typeid=0&name=中文&datatype=S&remarks=112
		
	}
	
	
	@ResponseBody
	@RequestMapping(value = "getparamdata.do")
	public String getParamData(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		
		String typeid = request.getParameter("typeid");
		try{
			List<ParamData> list = (List<ParamData>)dao.queryForList("rptparam.qryData", Integer.parseInt(typeid));
			j.put("data", JSONArray.fromObject(list));
			ret = 0;
		}catch(Throwable e){
			ret = -2;
			j.put("msg",  "get  data failed:"+e.getMessage());
		}

		j.put("ret", ret);
		return j.toString(4);
	}

	@ResponseBody
	@RequestMapping(value = "addparamdata.do")
	public String addParamData(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		try{
			String optype = request.getParameter("optype");
			if("add".equals(optype)){
				ParamData pd = RequestUtils.requestToObject(request, ParamData.class);
				pd.setParamid((int)dao.nextval("paramdata"));
				dao.insert("rptparam.addData", pd);
				ret = 0;
				j.put("paramid", pd.getParamid());
				j.put("parentid", pd.getParentid());
			}else if("update".equals(optype)){
				Map<String, String> m = RequestUtils.getMap(request, "paramid", "paramName", "paramValue", 
						"remarks", "parentid", "typeid");
				dao.update("rptparam.updateData", m);
				ret = 0;
				j.put("paramid", m.get("paramid"));
			}else if("delete".equals(optype)){
				int paramid = Integer.parseInt(request.getParameter("paramid"));
				int count = dao.count("rptparam.countDataByParent", paramid);
				if(((Integer)count).longValue() > 0){
					ret = -2;
					j.put("msg", "该节点下仍有子节点，请先删除全部子节点后再删除本节点！");
				}
				dao.delete("rptparam.delData", paramid);
				ret = 0;
				j.put("paramid", paramid);
			}
		}catch(Throwable e){
			ret = -2;
			j.put("msg", "修改数据失败："+e.getMessage());
		}

		j.put("ret", ret);
		return j.toString(4);
	}
	
	// http://localhost:8081/rom/paramusr_main.do?opCode=PARAMUSR&opName=报表0-报表配置-参数与用户关联&proId=P001&provinceCode=-1&tellType=-1
	@RequestMapping(value = "paramusr_main.do")
	public String paramUsrMain(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		request.setAttribute("typelist", dao.queryForList("rptparam.qryType"));
		request.setAttribute("userlist", dao.queryForList("rptparam.selUser"));
		return "rpt/param/paramusr_main";
	}
	
	@ResponseBody
	@RequestMapping(value = "getparamusr.do")
	public String getparamusr(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		
		try{
			int length = Integer.parseInt(request.getParameter("length"));
			int draw = Integer.parseInt(request.getParameter("draw"));
			int start = Integer.parseInt(request.getParameter("start"));
			List<ParamUser> list = (List<ParamUser>)dao.queryForLimitList("rptparam.qryParamUser", start, length);
			j.put("data", JSONArray.fromObject(list));
			j.put("draw", draw);
			int max = start+list.size();
			if(list.size() == length){
				max += length;
			}
			j.put("recordsTotal", max);
			j.put("recordsFiltered",max);
		}catch(Throwable e){
			ret = -2;
			j.put("msg", "Failed"+e.getMessage());
		}
		
		
		j.put("ret", ret);
		return j.toString(4);
	}
	
	@ResponseBody
	@RequestMapping(value = "getparamtree.do")
	public String getparamtree(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		
		String op = request.getParameter("op");
		if("refresh_token_time".equals(op)){
			 // 更新token的访问时间， 避免超时导致弹出登录页面
			ServletContext ctx = session.getServletContext();
			ctx.setAttribute("sersess_time", System.currentTimeMillis());
			j.put("ret", 0);
			return j.toString(4);
		}
		
		try{
		
			ParamData pd = new ParamData();
			pd.setTypeid(Integer.parseInt(request.getParameter("typeid")));
			pd.setLoginno(request.getParameter("login_no"));
			
			List<ParamData> list = (List<ParamData>)dao.queryForList("rptparam.qryParamUserTree", pd);
			j.put("data", JSONArray.fromObject(list));
			
			if(request.getParameter("docid") != null){
				ParamUser pu = new ParamUser();
				pu.setDocid(Integer.parseInt(request.getParameter("docid").trim()));
				pu.setTypeid(pd.getTypeid());
				pu.setLoginno(pd.getLoginno());
	
				List<ParamUser> list1 = (List<ParamUser>)dao.queryForList("rptparam.qryParamUserEx", pu);
				j.put("data1", JSONArray.fromObject(list1));
			}
			
			ret = 0;
		}catch(Throwable e){
			e.printStackTrace();
			ret = -2;
			j.put("msg",  "get  data failed:"+e.getMessage());
		}

		j.put("ret", ret);
		return j.toString(4);
	}
	
	@ResponseBody
	@RequestMapping(value = "getparamusertree.do")
	public String getparamusertree(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		
		ParamData pd = new ParamData();
		pd.setTypeid(Integer.parseInt(request.getParameter("typeid")));
		pd.setLoginno(request.getParameter("login_no"));
		
		ParamUser pu = new ParamUser();
		pu.setDocid(Integer.parseInt(request.getParameter("docid")));
		pu.setTypeid(pd.getTypeid());
		pu.setLoginno(pd.getLoginno());

		try{
			List<ParamData> list = (List<ParamData>)dao.queryForList("rptparam.qryParamUserTree", pd);
			j.put("data", JSONArray.fromObject(list));
			
			List<ParamUser> list1 = (List<ParamUser>)dao.queryForList("rptparam.qryParamUserEx", pu);
			j.put("data1", JSONArray.fromObject(list1));
			ret = 0;
		}catch(Throwable e){
			ret = -2;
			j.put("msg",  "get  data failed:"+e.getMessage());
		}

		j.put("ret", ret);
		return j.toString(4);
	}

	/*
	 设置参数 工号 报表的例外数据
	 */
	@ResponseBody
	@RequestMapping(value = "setparamuserex.do")
	public String setparamuserex(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		
		String login_no = request.getParameter("login_no");
		String typeid = request.getParameter("typeid");
		String docid = request.getParameter("docid");
		String incl = request.getParameter("incl");
		String excl = request.getParameter("excl");
		
		try{
			System.out.printf("incl: %s  excl: %s\n", incl, excl);
			int affected = parSvc.updateParamUserEx(Integer.parseInt(typeid), login_no, Integer.parseInt(docid), incl, excl);
			j.put("affected", affected);
			ret = 0;
		}catch(Throwable e){
			ret = -2;
			j.put("msg",  "get  data failed:"+e.getMessage());
		}

		j.put("ret", ret);
		return j.toString(4);
	}
	
	@ResponseBody
	@RequestMapping(value = "setparamuser.do")
	public String setParamUser(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		
		String login_no = request.getParameter("loginno");
		String typeid = request.getParameter("typeid");
		String newsel = request.getParameter("newsel");
		String morelogins = request.getParameter("morelogins");
		
		try{
			int affected = parSvc.updateParamUser(Integer.parseInt(typeid), login_no, newsel, morelogins);
			ret = 0;
			j.put("affected", affected);
		}catch(Throwable e){
			ret = -2;
			j.put("msg",  "get  data failed:"+e.getMessage());
		}

		j.put("ret", ret);
		return j.toString(4);
	}
	
	private void addChildren(JSONObject jo, String pos, List<JSONObject> list){
		String pcode = jo.getString("id");
		JSONArray ja = null;
		for(JSONObject jo1: list){
			jo1.put("pos", pos+"-"+jo1.getString("text"));
			if(pcode.equals(jo1.getString("parent"))){
				addChildren(jo1, pos+"-"+jo1.getString("text"), list);
				if(ja == null){
					ja = new JSONArray();
				}
				ja.add(jo1);
			}
		}
		if(ja != null){
			jo.put("children", ja);
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "getfuncmenu.do")
	public String getfuncmenu(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		
		JSONObject j = new JSONObject();
		int ret= -1;
		String loginNo = null;
		
		try{
			loginNo = session.getAttribute("loginNo").toString();
			List<RomProCode> proList = dao.queryForList("login.selectRomProCode");
			
			JSONArray ja = new JSONArray();
			for(RomProCode product: proList){
				LoginProBo loginProBo = new LoginProBo();
				loginProBo.setLoginNo(loginNo);
				loginProBo.setProCode(product.getProCode());
				
				String proVersion=product.getProVersion()==null?"":product.getProVersion();
				
				List<RomSysFunction> funcList = dao.queryForList("login.qryFunctionByLoginPro",loginProBo);
				
				String procode = product.getProCode();
				JSONObject jo1 = new JSONObject();
				jo1.put("id", procode+"-0");
				jo1.put("text", product.getProName());
				
				List<JSONObject> list = new ArrayList<JSONObject>();
				//ht1.put(procode+"-0", jo1);
				for(RomSysFunction func: funcList){
					JSONObject jo = new JSONObject();
					String k = procode + "-"+ func.getFunctionCode();
					//System.out.println("====:"+k);
					
					jo.put("id", k);
					jo.put("text", func.getFunctionName());
					jo.put("attr_action", func.getActionName());
					jo.put("attr_proid", procode);
					jo.put("attr_opcode", func.getFunctionCode());
					String pcode = procode + "-"+ func.getParentCode();
					jo.put("parent", pcode);
					list.add(jo);
				}
				if(list.size() > 0) {
					addChildren(jo1, jo1.getString("text"), list); //只能使用递归方式组织json树， 已经加入树的节点取出来再修改对树没有影响
					ja.add(jo1);
				}
			}
			j.put("data", ja);
			ret = 0;
		}catch(Throwable e){
			j.put("msg", "failed:"+e.getMessage());
		}
		
		j.put("ret", ret);
		String rr = "";
		
		String retType = request.getParameter("type");
		if("html".equals(retType)){
			System.out.printf("=====hello\n");
			response.setContentType("text/plain,charset=utf8");
			try{
				if("admin".equals(loginNo))
					rr = json2Html(j.getJSONArray("data")
							.getJSONObject(0).getJSONArray("children"));
				else
					rr = json2Html(j.getJSONArray("data")
						.getJSONObject(0).getJSONArray("children")
						.getJSONObject(0).getJSONArray("children"));
				//System.out.println(rr);
			}catch(Exception ex){
				ex.printStackTrace();
			}
			
		}else{
			response.setContentType("application/json,charset=utf8");
			rr = j.toString(4);
		}
				
		return rr;
	}
	
	private void htmlAddChildren(StringBuffer sb, JSONArray ja){
		sb.append("<ul style='display:none;'>\n");
		for(int i=0; i<ja.size(); i++){
			JSONObject  j = ja.getJSONObject(i);
			if(j.containsKey("children")){
				sb.append("<li> <a class='active' href='#sub2'>").append(j.getString("text")).append("</a>");
				htmlAddChildren(sb, j.getJSONArray("children"));
			}else{
				String call = "void()";
				if(j.containsKey("attr_action"))
					call = String.format("openTab('%s', '%s', '%s', '%s')", 
						j.getString("text"), j.getString("attr_proid"), 
						j.getString("attr_opcode"), j.getString("attr_action"));
				sb.append("<li class='leaf'><a href='#' onclick=\"").append(call).append("\"><em>")
					.append(j.getString("text")).append("</em></a>");
			}
			sb.append("</li>\n");
		}
		sb.append("</ul>\n");
	}
	private String json2Html(JSONArray ja){
		StringBuffer sb = new StringBuffer();
		sb.append("<ul>\n");
		for(int i=0; i<ja.size(); i++){
			JSONObject  j = ja.getJSONObject(i);
			sb.append("<li> <a class='active' href='#sub1'>").append(j.getString("text")).append("</a>");
			if(j.containsKey("children")){
				htmlAddChildren(sb, j.getJSONArray("children"));
			}
			sb.append("</li>\n");
		}
		
		sb.append("</ul>\n");
		return sb.toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "querylogin.do")
	public String querylogin(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		
		StringBuilder sb = new StringBuilder();
		
		String q = request.getParameter("q");
		
		List<String> list = (List<String>)dao.queryForList("rptparam.selUser", q);
		for(String l: list){
			sb.append(l).append('\n');
		}
		
		
		return sb.toString();
	}
}
