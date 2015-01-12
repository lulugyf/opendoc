package com.sitech.rom.rpt.base;

import java.sql.SQLException;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.stereotype.Service;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapExecutor;
import com.sitech.rom.rpt.bo.Doc;
import com.sitech.rom.rpt.bo.DocFunc;
import com.sitech.rom.rpt.bo.DocGroup;
import com.sitech.rom.rpt.bo.DocParam;

@Service("reportDocSvc")
public class DocService {
	
	@Resource
	private IMyBaseDao dao;
	
	public String addGroup(DocGroup grp){
		String baserolename = DaoUtil.getParameter(dao, "doc.defaultrole");
		//String basefunc = DaoUtil.getParameter(dao, "doc.basefunc");
		
		final DocFunc f = (DocFunc)dao.queryForObject("rptconf.getRolePro", baserolename);
		f.setParent_code(grp.getParent_group());
		
		String func_code = String.format("DOCG%04d", DaoUtil.nextval(dao, "rptgroup"));
		f.setFunction_code(func_code);
		
		f.setFunction_name(grp.getGroup_name());
		grp.setGroup_func(func_code);
		f.setRemarks("add report group");
		

		dao.insert("rptconf.addFunc", f);
		dao.insert("rptconf.addFuncPro", f);
		dao.insert("rptconf.addFuncRole", f);

		return func_code;
	}
	
	public void delGroup(DocGroup grp){
		String baserolename = DaoUtil.getParameter(dao, "doc.defaultrole");
		
		DocFunc f = (DocFunc)dao.queryForObject("rptconf.getRolePro", baserolename);
		f.setFunction_code(grp.getGroup_func());

		dao.delete("rptconf.delFunc", f);
		dao.delete("rptconf.delFuncPro", f);
		dao.delete("rptconf.delFuncRole", f);
	}
	
	public void modGroup(DocGroup grp){
		DocFunc f = new DocFunc();
		f.setFunction_code(grp.getGroup_func());
		f.setFunction_name(grp.getGroup_name());
		f.setRemarks("remarks");
		
		dao.update("rptconf.modFunc", f);
	}
	
	// 这里需要返回生成的 docid 和 function_code, 都在原对象中取, 返回function_code
	public String addDoc(Doc doc){
		String baserolename = DaoUtil.getParameter(dao, "doc.defaultrole");
		long docid = DaoUtil.nextval(dao, "t_doc");
		
		doc.setDocid((int)docid);
		
		
		DocFunc func = (DocFunc)dao.queryForObject("rptconf.getRolePro", baserolename);
		if(doc.getGroup_func() == null)
			return null; //必须要设置父节点， 暂时没检查父节点的有效性
		func.setParent_code(doc.getGroup_func());
		
		String func_code = String.format("DOC%04d", DaoUtil.nextval(dao, "rptdoc"));
		func.setFunction_code(func_code);
		String action_name = DaoUtil.getParameter(dao, "doc.defaultaction");
		func.setAction_name(action_name);
		
		func.setFunction_name(doc.getDocname());
		func.setRemarks("add report doc");
		
		doc.setFunction_code(func_code);

		// 添加 t_doc
		dao.insert("rptconf.addDoc", doc);
		
		// 添加功能树
		dao.insert("rptconf.addFunc", func);
		dao.insert("rptconf.addFuncPro", func);
		dao.insert("rptconf.addFuncRole", func);
		
		// 还要添加访问权限 rom_sys_popedom
		String popedoms = DaoUtil.getParameter(dao, "doc.popedoms");
		for(String action: popedoms.split("\\,")){
			func.setAction_name(action);
			dao.insert("rptconf.addPopedom", func);
		}

		return func_code;
	}
	
	public void delDoc(int docid){
		Doc qry = new Doc();
		qry.setDocid(docid);
		Doc doc = (Doc)dao.queryForObject("rptconf.qryDoc", qry);
		
		String baserolename = DaoUtil.getParameter(dao, "doc.defaultrole");
		DocFunc func = (DocFunc)dao.queryForObject("rptconf.getRolePro", baserolename);
		
		func.setFunction_code(doc.getFunction_code());
		dao.delete("rptconf.delFunc", func);
		dao.delete("rptconf.delFuncPro", func);
		dao.delete("rptconf.delFuncRole", func);
		dao.delete("rptconf.delDoc", docid);
		
		// 还要删除访问权限 rom_sys_popedom
		String popedoms = DaoUtil.getParameter(dao, "doc.popedoms");
		for(String action: popedoms.split("\\,")){
			func.setAction_name(action);
			dao.delete("rptconf.delPopedom", func);
		}
		
	}
	
	public void modDoc(Doc doc){
		if(doc.getDocid() <= 0)
			return;
		Doc doc1 = (Doc)dao.queryForObject("rptconf.qryDoc", doc);
		
		if(doc.getBaseurl() == null){
			doc.setBaseurl(doc1.getBaseurl());
		}
		if(doc.getRemarks() == null){
			doc.setRemarks(doc1.getRemarks());
		}
		if(doc.getDocname() == null){
			doc.setDocname(doc1.getDocname());
		}else{
			//修改 rom_sys_function
			DocFunc func = new DocFunc();
			func.setFunction_code(doc1.getFunction_code());
			func.setFunction_name(doc.getDocname());
			dao.update("rptconf.modFunc", func);
		}
		
		dao.update("rptconf.modDoc", doc);
	}
	
	private JSONArray setGroupTree(String group_func, List<DocGroup> lgrp, List<Doc> ldoc){
		JSONArray ret = null;
		for(DocGroup grp: lgrp){
			if(!grp.getParent_group().equals(group_func))
				continue;
			if(ret == null)
				ret = new JSONArray();
			JSONObject jgrp = JSONObject.fromObject(grp);
			JSONArray j = setGroupTree(grp.getGroup_func(), lgrp, ldoc);
			if(j != null){
				jgrp.put("children", j);
			}
			ret.add(jgrp);
		}

		for(Doc d: ldoc){
			if(!d.getGroup_func().equals(group_func))
				continue;
			if(ret == null){
				ret = new JSONArray();
			}
			ret.add(JSONObject.fromObject(d));
		}
		
		return ret;
	}
	
	public JSON getDocTree(IMyBaseDao dao){
		String basefunc = DaoUtil.getParameter(dao, "doc.basefunc");
		JSONObject root = new JSONObject();
		
		try{
			List<DocGroup> lgrp = (List<DocGroup>)dao.queryForList("rptconf.qryDocGroup", "DOCG%");
			List<Doc> ldoc = (List<Doc>)dao.queryForList("rptconf.qryDoc");
			root.put("group_func", basefunc);
			root.put("group_name", "Root");
			JSONArray j = setGroupTree(basefunc, lgrp, ldoc);
			if(j!= null){
				root.put("children", j);
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return root;
	}
	
	public void addDocParam(DocParam dp){
		long paramid = DaoUtil.nextval(dao, "t_docparam");
		dp.setParamid((int)paramid);
		dao.insert("rptconf.addDocParam", dp);
	}
	public void modDocParam(DocParam dp){
		dao.update("rptconf.modDocParam", dp);
	}
	public void delDocParam(DocParam dp){
		dao.delete("rptconf.delDocParam", dp);
	}
	public JSONArray getDocParam(int docid){
		return JSONArray.fromObject(dao.queryForList("rptconf.qryDocParam", docid));
	}

}
