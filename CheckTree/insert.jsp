<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import = "java.sql.*" %>                   
<%
	request.setCharacterEncoding("utf-8");
	String user = (String)session.getAttribute("user");
	int num=0;
	try{
		num = Integer.parseInt(request.getParameter("num"));
	}catch(Exception e){}

	String tree = request.getParameter("tree");
	String Bnum = request.getParameter("Bnum");
	String idx = request.getParameter("idx");
	String type = request.getParameter("type");
	String title = request.getParameter("AddTitle"); 
	String b_user = request.getParameter("b_user");
	num++;
	String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                               
    String pw = "wjstks25@";
	String insert_sql="";
	String update_sql="";

	if(Bnum == null){
		insert_sql = "INSERT INTO mainboard(title,branch,user,tree) VALUES(?,?,?,?)"; 
	}else{
		insert_sql = "INSERT INTO mainboard(title,branch,leaf,user,tree) VALUES(?,?,?,?,?)"; 
	}

	if(Bnum == null){
		update_sql = "UPDATE mainboard SET branch_num =? WHERE idx =?";
	}else{
		update_sql = "UPDATE mainboard SET leaf_num =? WHERE idx =?";
	}

	Connection conn = null;                   
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try{
	    Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,id,pw);
		pstmt = conn.prepareStatement(insert_sql);
		if(Bnum == null){
			pstmt.setString(1,title);
			pstmt.setInt(2,num);
			pstmt.setString(3,b_user);
			pstmt.setString(4,tree);
		}else{
			pstmt.setString(1,title);
			pstmt.setString(2,Bnum);
			pstmt.setInt(3,num);
			pstmt.setString(4,b_user);
			pstmt.setString(5,tree);
		}
		pstmt.executeUpdate();
		pstmt.close();

		pstmt = conn.prepareStatement(update_sql);
		pstmt.setInt(1,num);
		pstmt.setString(2,idx);
		pstmt.executeUpdate();
	}catch(SQLException e){

	}finally{
		if(conn != null) try{conn.close();}catch(SQLException e){}   
		if(pstmt != null) try{pstmt.close();}catch(SQLException e){}   
		if(rs != null) try{rs.close();}catch(SQLException e){}   
	}
%>	
