<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
 <%@ page import="org.json.simple.JSONObject"%>
  <%@ page import="org.json.simple.JSONArray"%>
  <%@ page import = "java.sql.*" %>                   
	
  <%
  	String idx = request.getParameter("idx");
	String title = request.getParameter("title");
	String data = request.getParameter("data");
	Connection conn = null;                       
	PreparedStatement pstmt = null;
	try{
    String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                                                    
    String pw = "wjstks25@";                                               
    Class.forName("com.mysql.jdbc.Driver");   
    String sql="UPDATE mainboard SET title ='" + title + "',content = '" + data + "' WHERE idx = '" + idx + "';";
	conn = DriverManager.getConnection(url,id,pw);
	pstmt = conn.prepareStatement(sql);	
	pstmt.executeUpdate();
	
    
	}catch(Exception e){                               // 예외가 발생하면 예외 상황을 처리한다.
     e.printStackTrace();
	}finally{
		if(pstmt != null) try{pstmt.close();}catch(SQLException e){}
		if(conn != null) try{conn.close();}catch(SQLException e){}   
	}

  %>
