<%@ page language="java" import="java.util.*, net.sf.json.*" pageEncoding="UTF-8"%>

<%
response.setContentType("application/json");

// length, draw, start, search[regex]==false, search[value]==
int length = Integer.parseInt(request.getParameter("length"));
int draw = Integer.parseInt(request.getParameter("draw"));
int start = Integer.parseInt(request.getParameter("start"));

int max = 57;
int end = start+length;
if(end > max) end = max;
JSONObject j = new JSONObject();
j.put("draw", draw);
j.put("recordsTotal", 57);
j.put("recordsFiltered",57);
JSONArray a = new JSONArray();

for(int i=start; i<end; i++){
	JSONObject j1 = new JSONObject();
	int x = i;
	j1.put("first_name", "aa"+x);
	j1.put("last_name", "bb"+x);
	j1.put("position", "cc"+x);
	a.add(j1);
}
j.put("data", a);

for(Enumeration<String> it = request.getParameterNames(); it.hasMoreElements(); ){
	String n = it.nextElement();
	String v = request.getParameter(n);
	System.out.println(n+"=="+v);
}

out.write(j.toString(4));
%>
