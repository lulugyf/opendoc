package com.sitech.rom.rpt.bo;

public class QueryAll {
	private String query;
	public QueryAll(String q){
		setQuery(q);
	}
	
	public void setQuery(String q) {
		query = null;
		if(q == null ){
			return;
		}
		q = q.trim();
		if("".equals(q))
			return;
		this.query = "%"+q+"%";
	}
	
	public String getQuery() {
		return query;
	}


}
