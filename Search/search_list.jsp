<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import = "java.sql.*" %>                   
<%
	request.setCharacterEncoding("utf-8");
	String type = request.getParameter("type");
	String value = request.getParameter("value");
	
	String url = "jdbc:mysql://localhost:3306/jykim" ;        
    String id = "jykim";                               
    String pw = "wjstks25@";
	String search_sql="";
	
	if(type.equals("제목")){
		search_sql="SELECT * FROM tree WHERE title LIKE ?";
	}else if(type.equals("설명")){
		search_sql="SELECT * FROM tree WHERE description LIKE ?";
	}else if(type.equals("작성자")){
		search_sql="SELECT * FROM tree WHERE user LIKE ?";
	}


	Connection conn = null;                   
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try{
	    Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,id,pw);
		pstmt = conn.prepareStatement(search_sql);
		pstmt.setString(1,"%" + value +"%");
		rs = pstmt.executeQuery();

		JSONArray itemList = new JSONArray();
   		while(rs.next()){    
   			JSONObject obj=new JSONObject();
			String edge ="<div class=\"edge\"><strong>" + rs.getString(6) + "</strong></div>";
			String title ="<a class=\"search_title\" href=\"/CheckTree/index.jsp?tree=" + rs.getString(2) + "&b_user=" + rs.getString(3) + "\">" + rs.getString(3) + "/" + rs.getString(2) + "</a>";
			String desc ="<div class=\"desc_content\">" + rs.getString(5) + "</div>";
			obj.put("idx",edge);
			obj.put("title",title);
			obj.put("description",desc);
    		itemList.add(obj);
   		}
    out.print(itemList);
	}catch(SQLException e){

	}finally{
		if(conn != null) try{conn.close();}catch(SQLException e){}   
		if(pstmt != null) try{pstmt.close();}catch(SQLException e){}   
		if(rs != null) try{rs.close();}catch(SQLException e){}   
	}
%>	

