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
public class ParamController_old {
//	@Resource
//	private IMyBaseDao dao;
//	
//	@Resource
//	private ParamService parSvc;
//	
//	private final Logger log = Logger.getLogger(getClass());
//	
//	// http://localhost:8081/rom/paramcfg_main.do?opCode=PARAMCFG&opName=����0-����������ñ���0-�����������&proId=P001&provinceCode=-1&tellType=-1
//	@RequestMapping(value = "paramcfg_main.do")
//	public String paramMain(HttpServletRequest request,
//			HttpServletResponse response, HttpSession session) {
//		
//		List<ParamType> typelist = (List<ParamType>)dao.queryForList("rptparam.qryType");
//		request.setAttribute("typelist", typelist);
//		request.setAttribute("datatypelist", ParamType.getDataTypeList());
//		return "rpt/param/param_main";
//	}
//	
//	@ResponseBody
//	@RequestMapping(value = "addparamtype.do")
//	public String addType(HttpServletRequest request,
//			HttpServletResponse response, HttpSession session){
//		//�������Ͳ�������typeid, ��� typeid Ϊ 0�� ���������� ���>0, ����Ϊ�޸�
//		// ������� optype=delete && typeid > 0, ��Ϊɾ��
//		
//		/*for(Enumeration enu = request.getParameterNames(); enu.hasMoreElements(); ){
//			String n = (String)enu.nextElement();
//			System.out.printf("%s=%s\n", n, request.getParameter(n));
//		}*/
//		response.setContentType("application/json,charset=utf8");
//		JSONObject j = new JSONObject();
//		int ret= -1;
//		
//		String typeid = request.getParameter("typeid");
//		try{
//			if("0".equals(typeid)){
//				ParamType pt = RequestUtils.requestToObject(request, ParamType.class);
//				pt.setTypeid((int)dao.nextval("paramtype"));
//				dao.insert("rptparam.addType", pt);
//				ret = 0;
//				j = JSONObject.fromObject(pt);
//			}else if("delete".equals(request.getParameter("optype"))){
//				int count = dao.count("rptparam.countDataByType", Integer.parseInt(typeid));
//				if(count > 0){
//					ret = -2;
//					j.put("msg", "�ò����������������ݣ�����ɾ����");
//				}else{
//					dao.delete("rptparam.delType", Integer.parseInt(typeid));
//					ret = 0;
//					j.put("optype", "delete");
//					j.put("typeid", typeid);
//				}
//			}else{
//				ParamType pt = RequestUtils.requestToObject(request, ParamType.class);
//				Map<String, Object> hm = new HashMap<String, Object>();
//				hm.put("typeid", pt.getTypeid());
//				hm.put("name", pt.getName());
//				hm.put("datatype", pt.getDatatype());
//				hm.put("remarks", pt.getRemarks());
//				dao.update("rptparam.updateType", hm);
//				ret = 0;
//				j = JSONObject.fromObject(pt);
//				j.put("optype", "update");
//			}
//		}catch(Throwable e){
//			log.error("failed", e);
//		}
//		j.put("ret", ret);
//		return j.toString(4);
//		
//		//http://localhost:8081/rom/addtype.do?opCode=PARAMCFG&proId=P001&typeid=0&name=����&datatype=S&remarks=112
//		
//	}
//	
//	
//	@ResponseBody
//	@RequestMapping(value = "getparamdata.do")
//	public String getParamData(HttpServletRequest request,
//			HttpServletResponse response, HttpSession session){
//		response.setContentType("application/json,charset=utf8");
//		JSONObject j = new JSONObject();
//		int ret= -1;
//		
//		String typeid = request.getParameter("typeid");
//		try{
//			List<ParamData> list = (List<ParamData>)dao.queryForList("rptparam.qryData", Integer.parseInt(typeid));
//			j.put("data", JSONArray.fromObject(list));
//			ret = 0;
//		}catch(Throwable e){
//			ret = -2;
//			j.put("msg",  "get  data failed:"+e.getMessage());
//		}
//
//		j.put("ret", ret);
//		return j.toString(4);
//	}
//
//	@ResponseBody
//	@RequestMapping(value = "addparamdata.do")
//	public String addParamData(HttpServletRequest request,
//			HttpServletResponse response, HttpSession session){
//		response.setContentType("application/json,charset=utf8");
//		JSONObject j = new JSONObject();
//		int ret= -1;
//		try{
//			String optype = request.getParameter("optype");
//			if("add".equals(optype)){
//				ParamData pd = RequestUtils.requestToObject(request, ParamData.class);
//				pd.setParamid((int)dao.nextval("paramdata"));
//				dao.insert("rptparam.addData", pd);
//				ret = 0;
//				j.put("paramid", pd.getParamid());
//				j.put("parentid", pd.getParentid());
//			}else if("update".equals(optype)){
//				Map<String, String> m = RequestUtils.getMap(request, "paramid", "paramName", "paramValue", 
//						"remarks", "parentid", "typeid");
//				dao.update("rptparam.updateData", m);
//				ret = 0;
//				j.put("paramid", m.get("paramid"));
//			}else if("delete".equals(optype)){
//				int paramid = Integer.parseInt(request.getParameter("paramid"));
//				int count = dao.count("rptparam.countDataByParent", paramid);
//				if(((Integer)count).longValue() > 0){
//					ret = -2;
//					j.put("msg", "�ýڵ��������ӽڵ㣬����ɾ��ȫ���ӽڵ����ɾ�����ڵ㣡");
//				}
//				dao.delete("rptparam.delData", paramid);
//				ret = 0;
//				j.put("paramid", paramid);
//			}
//		}catch(Throwable e){
//			ret = -2;
//			j.put("msg", "�޸�����ʧ�ܣ�"+e.getMessage());
//		}
//
//		j.put("ret", ret);
//		return j.toString(4);
//	}
//	
//	// http://localhost:8081/rom/paramusr_main.do?opCode=PARAMUSR&opName=����0-��������-�������û�����&proId=P001&provinceCode=-1&tellType=-1
//	@RequestMapping(value = "paramusr_main.do")
//	public String paramUsrMain(HttpServletRequest request,
//			HttpServletResponse response, HttpSession session) {
//		
//		request.setAttribute("typelist", dao.queryForList("rptparam.qryType"));
//		request.setAttribute("userlist", dao.queryForList("rptparam.selUser"));
//		return "rpt/param/paramusr_main";
//	}
//	
//	@ResponseBody
//	@RequestMapping(value = "getparamusr.do")
//	public String getparamusr(HttpServletRequest request,
//			HttpServletResponse response, HttpSession session){
//		response.setContentType("application/json,charset=utf8");
//		JSONObject j = new JSONObject();
//		int ret= -1;
//		
//		try{
//			int length = Integer.parseInt(request.getParameter("length"));
//			int draw = Integer.parseInt(request.getParameter("draw"));
//			int start = Integer.parseInt(request.getParameter("start"));
//			List<ParamUser> list = (List<ParamUser>)dao.queryForLimitList("rptparam.qryParamUser", start, length);
//			j.put("data", JSONArray.fromObject(list));
//			j.put("draw", draw);
//			int max = start+list.size();
//			if(list.size() == length){
//				max += length;
//			}
//			j.put("recordsTotal", max);
//			j.put("recordsFiltered",max);
//		}catch(Throwable e){
//			ret = -2;
//			j.put("msg", "Failed"+e.getMessage());
//		}
//		
//		
//		j.put("ret", ret);
//		return j.toString(4);
//	}
//	
//	@ResponseBody
//	@RequestMapping(value = "getparamtree.do")
//	public String getparamtree(HttpServletRequest request,
//			HttpServletResponse response, HttpSession session){
//		response.setContentType("application/json,charset=utf8");
//		JSONObject j = new JSONObject();
//		int ret= -1;
//		
//		String op = request.getParameter("op");
//		if("refresh_token_time".equals(op)){
//			 // ����token�ķ���ʱ�䣬 ���ⳬʱ���µ�����¼ҳ��
//			ServletContext ctx = session.getServletContext();
//			ctx.setAttribute("sersess_time", System.currentTimeMillis());
//			j.put("ret", 0);
//			return j.toString(4);
//		}
//		
//		try{
//		
//			ParamData pd = new ParamData();
//			pd.setTypeid(Integer.parseInt(request.getParameter("typeid")));
//			pd.setLoginno(request.getParameter("login_no"));
//			
//			List<ParamData> list = (List<ParamData>)dao.queryForList("rptparam.qryParamUserTree", pd);
//			j.put("data", JSONArray.fromObject(list));
//			
//			if(request.getParameter("docid") != null){
//				ParamUser pu = new ParamUser();
//				pu.setDocid(Integer.parseInt(request.getParameter("docid").trim()));
//				pu.setTypeid(pd.getTypeid());
//				pu.setLoginno(pd.getLoginno());
//	
//				List<ParamUser> list1 = (List<ParamUser>)dao.queryForList("rptparam.qryParamUserEx", pu);
//				j.put("data1", JSONArray.fromObject(list1));
//			}
//			
//			ret = 0;
//		}catch(Throwable e){
//			e.printStackTrace();
//			ret = -2;
//			j.put("msg",  "get  data failed:"+e.getMessage());
//		}
//
//		j.put("ret", ret);
//		return j.toString(4);
//	}
//	
//	@ResponseBody
//	@RequestMapping(value = "getparamusertree.do")
//	public String getparamusertree(HttpServletRequest request,
//			HttpServletResponse response, HttpSession session){
//		response.setContentType("application/json,charset=utf8");
//		JSONObject j = new JSONObject();
//		int ret= -1;
//		
//		ParamData pd = new ParamData();
//		pd.setTypeid(Integer.parseInt(request.getParameter("typeid")));
//		pd.setLoginno(request.getParameter("login_no"));
//		
//		ParamUser pu = new ParamUser();
//		pu.setDocid(Integer.parseInt(request.getParameter("docid")));
//		pu.setTypeid(pd.getTypeid());
//		pu.setLoginno(pd.getLoginno());
//
//		try{
//			List<ParamData> list = (List<ParamData>)dao.queryForList("rptparam.qryParamUserTree", pd);
//			j.put("data", JSONArray.fromObject(list));
//			
//			List<ParamUser> list1 = (List<ParamUser>)dao.queryForList("rptparam.qryParamUserEx", pu);
//			j.put("data1", JSONArray.fromObject(list1));
//			ret = 0;
//		}catch(Throwable e){
//			ret = -2;
//			j.put("msg",  "get  data failed:"+e.getMessage());
//		}
//
//		j.put("ret", ret);
//		return j.toString(4);
//	}
//
//	/*
//	 ���ò��� ���� �������������
//	 */
//	@ResponseBody
//	@RequestMapping(value = "setparamuserex.do")
//	public String setparamuserex(HttpServletRequest request,
//			HttpServletResponse response, HttpSession session){
//		
//		response.setContentType("application/json,charset=utf8");
//		JSONObject j = new JSONObject();
//		int ret= -1;
//		
//		String login_no = request.getParameter("login_no");
//		String typeid = request.getParameter("typeid");
//		String docid = request.getParameter("docid");
//		String incl = request.getParameter("incl");
//		String excl = request.getParameter("excl");
//		
//		try{
//			System.out.printf("incl: %s  excl: %s\n", incl, excl);
//			int affected = parSvc.updateParamUserEx(Integer.parseInt(typeid), login_no, Integer.parseInt(docid), incl, excl);
//			j.put("affected", affected);
//			ret = 0;
//		}catch(Throwable e){
//			ret = -2;
//			j.put("msg",  "get  data failed:"+e.getMessage());
//		}
//
//		j.put("ret", ret);
//		return j.toString(4);
//	}
//	
//	@ResponseBody
//	@RequestMapping(value = "setparamuser.do")
//	public String setParamUser(HttpServletRequest request,
//			HttpServletResponse response, HttpSession session){
//		
//		response.setContentType("application/json,charset=utf8");
//		JSONObject j = new JSONObject();
//		int ret= -1;
//		
//		String login_no = request.getParameter("loginno");
//		String typeid = request.getParameter("typeid");
//		String newsel = request.getParameter("newsel");
//		String morelogins = request.getParameter("morelogins");
//		
//		try{
//			int affected = parSvc.updateParamUser(Integer.parseInt(typeid), login_no, newsel, morelogins);
//			ret = 0;
//			j.put("affected", affected);
//		}catch(Throwable e){
//			ret = -2;
//			j.put("msg",  "get  data failed:"+e.getMessage());
//		}
//
//		j.put("ret", ret);
//		return j.toString(4);
//	}
//	
//	private void addChildren(JSONObject jo, String pos, List<JSONObject> list){
//		String pcode = jo.getString("id");
//		JSONArray ja = null;
//		for(JSONObject jo1: list){
//			jo1.put("pos", pos+"-"+jo1.getString("text"));
//			if(pcode.equals(jo1.getString("parent"))){
//				addChildren(jo1, pos+"-"+jo1.getString("text"), list);
//				if(ja == null){
//					ja = new JSONArray();
//				}
//				ja.add(jo1);
//			}
//		}
//		if(ja != null){
//			jo.put("children", ja);
//		}
//	}
//	
//	@ResponseBody
//	@RequestMapping(value = "getfuncmenu.do")
//	public String getfuncmenu(HttpServletRequest request,
//			HttpServletResponse response, HttpSession session){
//		
//		response.setContentType("application/json,charset=utf8");
//		JSONObject j = new JSONObject();
//		int ret= -1;
//		
//		try{
//			String loginNo = session.getAttribute("loginNo").toString();
//			List<RomProCode> proList = dao.queryForList("login.selectRomProCode");
//			
//			JSONArray ja = new JSONArray();
//			for(RomProCode product: proList){
//				LoginProBo loginProBo = new LoginProBo();
//				loginProBo.setLoginNo(loginNo);
//				loginProBo.setProCode(product.getProCode());
//				
//				String proVersion=product.getProVersion()==null?"":product.getProVersion();
//				
//				List<RomSysFunction> funcList = dao.queryForList("login.qryFunctionByLoginPro",loginProBo);
//				
//				String procode = product.getProCode();
//				JSONObject jo1 = new JSONObject();
//				jo1.put("id", procode+"-0");
//				jo1.put("text", product.getProName());
//				
//				List<JSONObject> list = new ArrayList<JSONObject>();
//				//ht1.put(procode+"-0", jo1);
//				for(RomSysFunction func: funcList){
//					JSONObject jo = new JSONObject();
//					String k = procode + "-"+ func.getFunctionCode();
//					//System.out.println("====:"+k);
//					
//					jo.put("id", k);
//					jo.put("text", func.getFunctionName());
//					jo.put("attr_action", func.getActionName());
//					jo.put("attr_proid", procode);
//					jo.put("attr_opcode", func.getFunctionCode());
//					String pcode = procode + "-"+ func.getParentCode();
//					jo.put("parent", pcode);
//					list.add(jo);
//				}
//				if(list.size() > 0) {
//					addChildren(jo1, jo1.getString("text"), list); //ֻ��ʹ�õݹ鷽ʽ��֯json���� �Ѿ��������Ľڵ�ȡ�������޸Ķ���û��Ӱ��
//					ja.add(jo1);
//				}
//			}
//			j.put("data", ja);
//			ret = 0;
//		}catch(Throwable e){
//			j.put("msg", "failed:"+e.getMessage());
//		}
//		
//		j.put("ret", ret);
//		return j.toString(4);
//	}
//	
//	@ResponseBody
//	@RequestMapping(value = "querylogin.do")
//	public String querylogin(HttpServletRequest request,
//			HttpServletResponse response, HttpSession session){
//		
//		StringBuilder sb = new StringBuilder();
//		
//		String q = request.getParameter("q");
//		
//		List<String> list = (List<String>)dao.queryForList("rptparam.selUser", q);
//		for(String l: list){
//			sb.append(l).append('\n');
//		}
//		
//		
//		return sb.toString();
//	}
}
