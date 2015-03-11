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
import com.sitech.rom.rpt.bo.DBConn;
import com.sitech.rom.rpt.bo.TaskConf;
import com.sitech.rom.rpt.bo.TaskResult;
import com.sitech.rom.util.AjaxResponsePacket;

@Controller
public class TaskController {
	@Resource
	private IMyBaseDao myBaseDao;
	
	List<String> jobRunTimeMList = new ArrayList<String>();
	List<String> jobRunTimeHList = new ArrayList<String>();
	List<String> jobRunTimemList = new ArrayList<String>();
	
	private final Logger log = Logger.getLogger(getClass());
	
	@RequestMapping(value = "taskmain.do")
	public String taskMain(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		initData();
		request.setAttribute("jobRunTimeMList", jobRunTimeMList);
		request.setAttribute("jobRunTimeHList", jobRunTimeHList);
		request.setAttribute("jobRunTimemList", jobRunTimemList);
		request.setAttribute("DBConnList", myBaseDao.queryForList("sdbconns.qryConns",new DBConn()));
		return "rpt/task/task_main";
	}

	@RequestMapping(value = "tasklist.do")
	public String taskList(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		request.setAttribute("DBConnList", myBaseDao.queryForList("sdbconns.qryConns",new DBConn()));
		TaskConf qry = new TaskConf();
		
		String pageNum = request.getParameter("pageNum").trim();
		System.out.println("pageNum:" + pageNum);
		qry.setPageNum(Integer.parseInt(pageNum));
		
	    String job_name = request.getParameter("job_name").trim();
	    String job_mode = request.getParameter("job_mode").trim();
	    String job_run_freq = "0";
	    String job_run_mode = request.getParameter("job_run_mode").trim();
	    String job_enable = request.getParameter("job_enable").trim();
	    String job_type = request.getParameter("job_type").trim();
	    String job_run_time = request.getParameter("job_run_time").trim();
	    String h_order_id = request.getParameter("h_order_id").trim();
	    String s_tab = request.getParameter("s_tab").trim();
	    String d_tab = request.getParameter("d_tab").trim();

	    if(job_name!=null && !"".equals(job_name))qry.setJob_name(job_name);
	    if(job_mode!=null && !"".equals(job_mode))qry.setJob_mode(job_mode);
	    if(job_run_freq!=null && !"".equals(job_run_freq))qry.setJob_run_freq(Integer.parseInt(job_run_freq));
	    if(job_run_mode!=null && !"".equals(job_run_mode))qry.setJob_run_mode(job_run_mode);
	    if(job_enable!=null && !"".equals(job_enable))qry.setJob_enable(job_enable);
	    if(job_type!=null && !"".equals(job_type))qry.setJob_type(job_type);
	    if(job_run_time!=null && !"".equals(job_run_time))qry.setJob_run_time(job_run_time);
	    if(h_order_id!=null && !"".equals(h_order_id))qry.setH_order_id(Integer.parseInt(h_order_id));
	    if(s_tab!=null && !"".equals(s_tab))qry.setS_tab(s_tab);
	    if(d_tab!=null && !"".equals(d_tab))qry.setD_tab(d_tab);
	    createRunTime(qry);
	    List<TaskConf> tempList = myBaseDao.queryForPageList("taskconf.qryTaskConf", qry);
	    List<TaskConf> taskList = new ArrayList<TaskConf>();
	    for(TaskConf tc:tempList){
	    	splitRunTime(tc);
	    	taskList.add(tc);
	    }
		request.setAttribute("rlist", taskList);
		splitRunTime(qry);
		request.setAttribute("bo", qry);
		return "rpt/task/task_list";
	}
	
	@RequestMapping(value = "gotoAddTask.do")
	public String gotoAddTask(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		request.setAttribute("DBConnList", myBaseDao.queryForList("sdbconns.qryConns",new DBConn()));
		
		initData();
		request.setAttribute("jobRunTimeMList", jobRunTimeMList);
		request.setAttribute("jobRunTimeHList", jobRunTimeHList);
		request.setAttribute("jobRunTimemList", jobRunTimemList);
		return "rpt/task/task_add";
	}
	
	@RequestMapping(value = "addTask.do")
	public String addTask(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,@ModelAttribute("TaskConf") TaskConf tc) {
 	
		boolean r = false;
		String err = null;
		
		long job_id = myBaseDao.nextval("taskconf");
		tc.setJob_id((int)job_id);
		
		createRunTime(tc);
		
		try {
			myBaseDao.insert("taskconf.insertTask", tc);
			r = true;
		} catch (RuntimeException e) {
			//throw new  BusiException("1000",e.getMessage());
			//r = false;
			err = e.getMessage();
		}
		
		if(r){
			request.setAttribute("operInfo","新增任务配置成功！");			
		}else{
			request.setAttribute("operInfo","新增任务配置失败！ "+err);
		}
		
		return "forward:gotoAddTask.do";		
	}	

	
	@RequestMapping(value = "gotoUpdateTask.do")
	public String gotoUpdateTask(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		request.setAttribute("DBConnList", myBaseDao.queryForList("sdbconns.qryConns",new DBConn()));
		String job_id = request.getParameter("job_id").trim();
		TaskConf qry = new TaskConf();
		qry.setJob_id(Integer.parseInt(job_id));
		
		initData();
		request.setAttribute("jobRunTimeMList", jobRunTimeMList);
		request.setAttribute("jobRunTimeHList", jobRunTimeHList);
		request.setAttribute("jobRunTimemList", jobRunTimemList);
		TaskConf tc = (TaskConf)myBaseDao.queryForObject("taskconf.qryTaskConf", qry);
		splitRunTime(tc);
		request.setAttribute("task", tc);
		return "rpt/task/task_update";
	}
	
	@RequestMapping(value = "updateTask.do")
	public String updateTask(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@ModelAttribute("TaskConf") TaskConf tc) {
		boolean r = false;
		String err = null;
		createRunTime(tc);
		try {
			myBaseDao.update("taskconf.updateTask", tc);
			r = true;
		} catch (RuntimeException e) {
			err = e.getMessage();
		}
		
		if(r){
			request.setAttribute("operInfo","修改任务配置成功！");			
		}else{
			request.setAttribute("operInfo","修改任务配置失败！ "+err);
		}
		return "forward:gotoUpdateTask.do";
	}
	

	@ResponseBody
	@RequestMapping(value = "delTask.do")
	public String delTask(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		String job_id = request.getParameter("job_id").trim();
		AjaxResponsePacket responsePacked = new AjaxResponsePacket();
		String err = "none";
		try{
			if(myBaseDao.delete("taskconf.deleteTask", job_id) > 0)
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
	
	@RequestMapping(value = "taskresult.do")
	public String taskResult(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		request.setAttribute("taskConfList", myBaseDao.queryForList("taskconf.qryTaskConf",new TaskConf()));
		return "rpt/task/task_result";
	}

	@RequestMapping(value = "taskresultList.do")
	public String taskResultList(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		TaskResult qry = new TaskResult();
		
		String pageNum = request.getParameter("pageNum").trim();
		System.out.println("pageNum:" + pageNum);
		qry.setPageNum(Integer.parseInt(pageNum));
		
	    String job_id = request.getParameter("job_id").trim();
	    String run_status = request.getParameter("run_status").trim();
	    String start_time = request.getParameter("start_time").trim();
	    String end_time = request.getParameter("end_time").trim();

	    if(job_id!=null && !"".equals(job_id))qry.setJob_id(Integer.parseInt(job_id));
	    if(run_status!=null && !"".equals(run_status))qry.setRun_status(run_status);
	    if(start_time!=null && !"".equals(start_time))qry.setStart_time(start_time);
	    if(end_time!=null && !"".equals(end_time))qry.setEnd_time(end_time);
		request.setAttribute("rlist", myBaseDao.queryForPageList("taskconf.qryTaskResult", qry));
		request.setAttribute("bo", qry);
		return "rpt/task/task_resultList";
	}
	
	private void initData(){
		for(int i=0;i<31;i++){
			String M = "";
			if(i<9){
				M = "0" + (i+1);
			}else{
				M = "" + (i+1);
			}
			jobRunTimeMList.add(M);
		}
		for(int i=0;i<60;i++){
			String H = "";
			if(i<10){
				H = "0" + i;
			}else{
				H = "" + i;
			}
			if(i<24){
				jobRunTimeHList.add(H);
				jobRunTimemList.add(H);
			}else{
				jobRunTimemList.add(H);
			}
		}
	}
	
	private void createRunTime(TaskConf tc){
		String temp = "";
		if("M".equals(tc.getJob_mode())){
			if(tc.getJob_run_time_M() != null && !"".equals(tc.getJob_run_time_M())){
				temp += tc.getJob_run_time_M();
			}
			if(tc.getJob_run_time_H() != null && !"".equals(tc.getJob_run_time_H())){
				temp += tc.getJob_run_time_H();
			}
			if(tc.getJob_run_time_m() != null && !"".equals(tc.getJob_run_time_m())){
				temp += tc.getJob_run_time_m();
			}
			if(tc.getJob_run_time_S() != null && !"".equals(tc.getJob_run_time_S())){
				temp += tc.getJob_run_time_S();
			}
			tc.setJob_run_time(temp);
		}else if("D".equals(tc.getJob_mode())){
			if(tc.getJob_run_time_H() != null && !"".equals(tc.getJob_run_time_H())){
				temp += tc.getJob_run_time_H();
			}
			if(tc.getJob_run_time_m() != null && !"".equals(tc.getJob_run_time_m())){
				temp += tc.getJob_run_time_m();
			}
			if(tc.getJob_run_time_S() != null && !"".equals(tc.getJob_run_time_S())){
				temp += tc.getJob_run_time_S();
			}
			tc.setJob_run_time(temp);
		}
	}
	private void splitRunTime(TaskConf tc){
		if("M".equals(tc.getJob_mode())){
			tc.setJob_run_time_M(tc.getJob_run_time().substring(0,2));
			tc.setJob_run_time_H(tc.getJob_run_time().substring(2,4));
			tc.setJob_run_time_m(tc.getJob_run_time().substring(4,6));
			tc.setJob_run_time_S(tc.getJob_run_time().substring(6,8));
		}else if("D".equals(tc.getJob_mode())){
			tc.setJob_run_time_H(tc.getJob_run_time().substring(0,2));
			tc.setJob_run_time_m(tc.getJob_run_time().substring(2,4));
			tc.setJob_run_time_S(tc.getJob_run_time().substring(4,6));
		}
	}
	
}
