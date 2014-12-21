package com.sitech.rom.rpt;

import java.util.Enumeration;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sitech.rom.common.dto.RomSysPopedom;
import com.sitech.rom.rpt.base.IMyBaseDao;
import com.sitech.rom.rpt.bo.QueryAll;

@Controller
public class TaskController {
	@Resource
	private IMyBaseDao myBaseDao;
	
	private final Logger log = Logger.getLogger(getClass());
	
	@RequestMapping(value = "taskmain.do")
	public String taskMain(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		//request.setAttribute("typelist", myBaseDao.queryForList("sdbconns.qryDBTypes"));
		return "rpt/task/task_main";
	}

	@ResponseBody
	@RequestMapping(value = "tasklist.do")
	public String taskList(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		
		response.setContentType("application/json");

		// length, draw, start, search[regex]==false, search[value]==
		int length = Integer.parseInt(request.getParameter("length"));
		int draw = Integer.parseInt(request.getParameter("draw"));
		int start = Integer.parseInt(request.getParameter("start"));
		String search = request.getParameter("search[value]");

		List<RomSysPopedom> list = myBaseDao.queryForLimitList(
				"sdbconns.select_test", new QueryAll(search),  start, length);

		
		JSONObject j = new JSONObject();
		j.put("draw", draw);
		int max = start+list.size();
		if(list.size() == length){
			max += length;
		}
		j.put("recordsTotal", max);
		j.put("recordsFiltered",max);
		JSONArray a = new JSONArray();

		for(RomSysPopedom i: list){
			JSONArray j1 = new JSONArray();
			j1.add(i.getActionName());
			j1.add(i.getFunctionCode());
			j1.add(i.getOperationCode());
			a.add(j1);
		}
		j.put("data", a);

//		for(Enumeration<String> it = request.getParameterNames(); it.hasMoreElements(); ){
//			String n = it.nextElement();
//			String v = request.getParameter(n);
//			System.out.println(n+"=="+v);
//		}
		//request.setAttribute("typelist", myBaseDao.queryForList("sdbconns.qryDBTypes"));
		return j.toString(4);
	}
	
	@RequestMapping(value = "gotoAddTask.do")
	public String gotoAddTask(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		return "rpt/task/task_add";
	}
}
