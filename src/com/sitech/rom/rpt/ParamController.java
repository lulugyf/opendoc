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
	
	private final Logger log = Logger.getLogger(getClass());
	
	// http://localhost:8081/rom/paramcfg_main.do?opCode=PARAMCFG&opName=报表0-报表参数配置报表0-报表参数配置&proId=P001&provinceCode=-1&tellType=-1
	@RequestMapping(value = "paramcfg_main.do")
	public String paramMain(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		List<ParamType> typelist = dao.queryForList("rptparam.qryType");
		for(int i=0; i<typelist.size(); i++){
			ParamType p = typelist.get(i);
			if(p.getTypeid() == 0){
				typelist.remove(i);
				break;
			}
		}
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
	public String getParamTree(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		
		ParamData pd = new ParamData();
		pd.setTypeid(Integer.parseInt(request.getParameter("typeid")));
		pd.setLoginno(request.getParameter("loginno"));

		try{
			List<ParamData> list = (List<ParamData>)dao.queryForList("rptparam.qryParamUserTree", pd);
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
	@RequestMapping(value = "setparamuser.do")
	public String setParamUser(HttpServletRequest request,
			HttpServletResponse response, HttpSession session){
		
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		
		String login_no = request.getParameter("loginno");
		String newsel = request.getParameter("newsel");
		String oldsel = request.getParameter("oldsel");

		String[] sel_n = newsel.split("\\,");
		String[] sel_o = oldsel.split("\\,");
		Hashtable<String, Integer> ht_n = new Hashtable<String, Integer>();
		for(String n: sel_n) ht_n.put(n, 1);
		Hashtable<String, Integer> ht_o = new Hashtable<String, Integer>();
		for(String n: sel_o) ht_o.put(n, 1);
		ParamUser pu = new ParamUser();
		pu.setLoginno(login_no);
		try{
			int affected = 0;
			for(String n: sel_n){
				if("".equals(n)) continue;
				if(!ht_o.containsKey(n)){
					pu.setParamid(Integer.parseInt(n));
					dao.insert("rptparam.addParamUser", pu);
					affected ++;
				}
			}
			for(String n:sel_o){
				if("".equals(n)) continue;
				if(!ht_n.containsKey(n)){
					pu.setParamid(Integer.parseInt(n));
					dao.delete("rptparam.delParamUser", pu);
					affected++;
				}
			}
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
		
		response.setContentType("application/json,charset=utf8");
		JSONObject j = new JSONObject();
		int ret= -1;
		
		try{
			String loginNo = session.getAttribute("loginNo").toString();
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
					System.out.println("====:"+k);
					
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
		return j.toString(4);
	}
	
}
