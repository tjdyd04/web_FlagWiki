<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>                   
<%
	request.setCharacterEncoding("utf-8");
	String user = (String)session.getAttribute("user");
	String b_user = request.getParameter("b_user");
	String tree = request.getParameter("tree");
	String version = request.getParameter("flag_version");

	String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                               
    String pw = "wjstks25@";

	String tree_version="";
	String change_ver_sql = "UPDATE tree SET current_flag=? WHERE title=? AND user=?"; 
	String insert_history = "INSERT INTO history(tree,b_user,user,content,type) VALUES(?,?,?,?,?)";
	String templete="";
	
	Connection conn = null;                   
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try{
	    Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,id,pw);
		pstmt = conn.prepareStatement(change_ver_sql);
		pstmt.setString(1,version);
		pstmt.setString(2,tree);
		pstmt.setString(3,b_user);
		pstmt.executeUpdate();

		pstmt.close();

		templete= "<span class=\"label label-default\">" +user + "</span>님이 <span class=\"label label-success\">" + tree + "</span>를 " + version + "번째 깃발로 <strong>전환</strong> 하였습니다.";
		pstmt = conn.prepareStatement(insert_history);
		pstmt.setString(1,tree);
		pstmt.setString(2,b_user);
		pstmt.setString(3,user);
		pstmt.setString(4,templete);
		pstmt.setString(5,"flag");
		pstmt.executeUpdate();

	}catch(SQLException e){

	}finally{
		if(conn != null) try{conn.close();}catch(SQLException e){}   
		if(pstmt != null) try{pstmt.close();}catch(SQLException e){}   
		if(rs != null) try{rs.close();}catch(SQLException e){}   
	}
%>	

