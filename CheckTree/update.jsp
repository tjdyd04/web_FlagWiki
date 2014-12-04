<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
 <%@ page import="org.json.simple.JSONObject"%>
  <%@ page import="org.json.simple.JSONArray"%>
  <%@ page import = "java.sql.*" %>                   
	
  <%

  	String idx = request.getParameter("idx");
	String title = request.getParameter("title");
	String data = request.getParameter("data");
	String user = (String)session.getAttribute("user");
	
	String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                                      
    String pw = "wjstks25@";                                               
    String sql="UPDATE mainboard SET title=? , content=? WHERE idx=?";
	
	Connection conn = null;                       
	PreparedStatement pstmt = null;
   
	try{
    Class.forName("com.mysql.jdbc.Driver");   
	conn = DriverManager.getConnection(url,id,pw);
	pstmt = conn.prepareStatement(sql);	
	pstmt.setString(1,title);
	pstmt.setString(2,data);
	pstmt.setString(3,idx);
	pstmt.executeUpdate();
	
    
	}catch(Exception e){
//
	}finally{
		if(pstmt != null) try{pstmt.close();}catch(SQLException e){}
		if(conn != null) try{conn.close();}catch(SQLException e){}   
	}

  %>
