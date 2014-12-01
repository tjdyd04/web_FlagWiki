<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import = "java.sql.*" %>                   
<% 	
	request.setCharacterEncoding("utf-8");
	String user = (String)session.getAttribute("user");
	String idx = request.getParameter("idx");
	String title = request.getParameter("title");
	String data = request.getParameter("data");
	String r_type = request.getParameter("r_type");
	if(r_type == null){
		r_type = "내용수정요청";
	}else{
		r_type = "건의";
	}
	String b_user="";
	String tree="";

	String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                               
    String pw = "wjstks25@";
	String select_sql = "SELECT * FROM mainboard WHERE idx=?";
	String insert_sql = "INSERT INTO request (board_idx,type,user,title,content,tree,b_user) VALUES(?,?,?,?,?,?,?)";
		
	Connection conn = null;                   
	PreparedStatement pstmt = null;
	ResultSet rs = null;


	try{
	    Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,id,pw);
		pstmt = conn.prepareStatement(select_sql);
		pstmt.setString(1,idx);
		rs = pstmt.executeQuery();
		
		while(rs.next()){
			b_user = rs.getString(8);
			tree = rs.getString(9);
		}
		rs.close();
		pstmt.close();

		conn = DriverManager.getConnection(url,id,pw);
		pstmt = conn.prepareStatement(insert_sql);
		pstmt.setString(1,idx);
		pstmt.setString(2,r_type);
		pstmt.setString(3,user);
		pstmt.setString(4,title);
		pstmt.setString(5,data);
		pstmt.setString(6,tree);
		pstmt.setString(7,b_user);
		pstmt.executeUpdate();


	}catch(SQLException e){

	}finally{
		if(conn != null) try{conn.close();}catch(SQLException e){}   
		if(pstmt != null) try{pstmt.close();}catch(SQLException e){}   
		if(rs != null) try{rs.close();}catch(SQLException e){}   
	}
%>	
