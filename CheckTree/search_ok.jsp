<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>                   
<%
	request.setCharacterEncoding("utf-8");
	String user = (String)session.getAttribute("user");
	String b_user = request.getParameter("b_user");
	String tree = request.getParameter("tree");
	String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                               
    String pw = "wjstks25@";
	
	String search_ok_sql = "UPDATE tree SET view = '1' WHERE title=? AND user=?"; 
	
	Connection conn = null;                   
	PreparedStatement pstmt = null;
	try{
	    Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,id,pw);
		pstmt = conn.prepareStatement(search_ok_sql);
		pstmt.setString(1,tree);
		pstmt.setString(2,b_user);
		pstmt.executeUpdate();

	}catch(SQLException e){

	}finally{
		if(conn != null) try{conn.close();}catch(SQLException e){}   
		if(pstmt != null) try{pstmt.close();}catch(SQLException e){}   
	}
%>	

