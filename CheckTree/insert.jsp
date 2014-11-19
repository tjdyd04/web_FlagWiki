<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import = "java.sql.*" %>                   
<%
	request.setCharacterEncoding("utf-8");
	int num=0;
	try{
		num = Integer.parseInt(request.getParameter("num"));
	}catch(Exception e){}
	String Bnum = request.getParameter("Bnum");
	String idx = request.getParameter("idx");
	String type = request.getParameter("type");
	String title = request.getParameter("title"); 
	
	num++;
    
	String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                               
    String pw = "wjstks25@";

	String insert_sql="";
	String update_sql="";
	if(Bnum == null){
		insert_sql = "INSERT INTO jsontest(title,branch) VALUES('" + title + "','" + num + "')"; 
	}else{
		insert_sql = "INSERT INTO jsontest(title,branch,leaf) VALUES('" + title + "','" + Bnum + "', '" + num + "')"; 
	}

	if(Bnum == null){
		update_sql = "UPDATE jsontest SET branch_num ='" + num + "' WHERE idx = '" + idx + "'";
	}else{
		update_sql = "UPDATE jsontest SET leaf_num ='" + num + "' WHERE idx = '" + idx + "'";
	}

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	try{
	    Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,id,pw);
		stmt = conn.createStatement();
		stmt.executeUpdate(insert_sql);
		stmt.executeUpdate(update_sql);	

	}catch(SQLException e){

	}finally{
		if(conn != null) try{conn.close();}catch(SQLException e){}   
		if(stmt != null) try{stmt.close();}catch(SQLException e){}   
		if(rs != null) try{rs.close();}catch(SQLException e){}   
	}
%>	
