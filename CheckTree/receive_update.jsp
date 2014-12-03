<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>                   

<%
	String idx = request.getParameter("idx");
	String title = request.getParameter("title");
	String data = request.getParameter("data");
	String user = (String)session.getAttribute("user");
	String board_idx = request.getParameter("board_idx");
	
	String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                                      
    String pw = "wjstks25@";                                               
    String sql="UPDATE mainboard SET title=? , content=? WHERE idx=?";
	String select_sql = "SELECT * FROM mainboard WHERE idx=?";
	String insert_history = "INSERT INTO history(tree,b_user,user,content,type) VALUES(?,?,?,?,?)";
	String templete="";
	
	String b_title="";
	String tree="";
	String b_user="";
	
	Connection conn = null;                       
	PreparedStatement pstmt = null;
	ResultSet rs = null;
   
	try{
    Class.forName("com.mysql.jdbc.Driver");   
	conn = DriverManager.getConnection(url,id,pw);
	pstmt = conn.prepareStatement(select_sql);
	pstmt.setString(1,board_idx);
	rs = pstmt.executeQuery();
	
	while(rs.next()){
		b_title =rs.getString(2);
		b_user = rs.getString(8);
		tree = rs.getString(9);
	}
	rs.close();
	pstmt.close();
	
	pstmt = conn.prepareStatement(sql);	
	pstmt.setString(1,title);
	pstmt.setString(2,data);
	pstmt.setString(3,board_idx);
	pstmt.executeUpdate();

	templete= "<span class=\"label label-default\">" +user + "</span>님이 <span class=\"label label-success\">" + tree + "</span> 의 <span class=\"label label-warning\">" + b_title + "</span>에 요청받은 내용을 <strong>적용</strong> 하였습니다";
	pstmt.close();
	pstmt = conn.prepareStatement(insert_history);
	pstmt.setString(1,tree);
	pstmt.setString(2,b_user);
	pstmt.setString(3,user);
	pstmt.setString(4,templete);
	pstmt.setString(5,"update");
	pstmt.executeUpdate();

	
    
	}catch(Exception e){
//
	}finally{
		if(pstmt != null) try{pstmt.close();}catch(SQLException e){}
		if(conn != null) try{conn.close();}catch(SQLException e){}   
		if(rs != null) try{rs.close();}catch(SQLException e){}
	}

  %>
