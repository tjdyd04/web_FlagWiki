<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>                   
<%
	request.setCharacterEncoding("utf-8");
	String user = (String)session.getAttribute("user");
	String idx = request.getParameter("idx");
	String type = request.getParameter("type");
	
	String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                               
    String pw = "wjstks25@";
	
	String version="";
	String branch="";

	String search_info = "SELECT * FROM mainboard WHERE idx=?";
	String delete_branch_sql = "DELETE FROM mainboard WHERE branch=? AND flag=?";
	String delete_leaf_sql = "DELETE FROM mainboard WHERE idx=?";
	String templete="";
	
	Connection conn = null;                   
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try{
	    Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,id,pw);
		if(type==null){
			pstmt = conn.prepareStatement(delete_leaf_sql);
			pstmt.setString(1,idx);
			pstmt.executeUpdate();
		}else{
			pstmt = conn.prepareStatement(search_info);
			pstmt.setString(1,idx);
			rs = pstmt.executeQuery();
			while(rs.next()){
				branch=rs.getString(4);
				version=rs.getString(10);
			}
			rs.close();
			pstmt.close();
			
			pstmt = conn.prepareStatement(delete_branch_sql);
			pstmt.setString(1,branch);
			pstmt.setString(2,version);
			pstmt.executeUpdate();
		}

	}catch(SQLException e){

	}finally{
		if(conn != null) try{conn.close();}catch(SQLException e){}   
		if(pstmt != null) try{pstmt.close();}catch(SQLException e){}   
		if(rs != null) try{rs.close();}catch(SQLException e){}   
	}
%>	

