<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="java.util.*,java.text.*"%>
<%@ page import="java.sql.*"%>                   
<%
	request.setCharacterEncoding("utf-8");
	String user = (String)session.getAttribute("user");
	String b_user = request.getParameter("b_user");
	String tree = request.getParameter("tree");
	String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                               
    String pw = "wjstks25@";

	String search_idx = "SELECT * FROM tree WHERE title=? AND user=?";
	String tree_idx="";
	String tree_version="";
	String search_mem = "SELECT * FROM flag WHERE tree_idx=?"; 
	
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy년 MM월 dd일 HH시mm분ss초 등록");
	
	Connection conn = null;                   
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try{
	    Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,id,pw);
		pstmt = conn.prepareStatement(search_idx);
		pstmt.setString(1,tree);
		pstmt.setString(2,b_user);
		rs = pstmt.executeQuery();
		while(rs.next()){
			tree_idx=rs.getString(1);
			tree_version=rs.getString(8);
		}
		rs.close();
		pstmt.close();

		pstmt = conn.prepareStatement(search_mem);
		pstmt.setString(1,tree_idx);
		rs = pstmt.executeQuery();

		JSONArray itemList = new JSONArray();
   		while(rs.next()){    
   			JSONObject obj=new JSONObject();
			obj.put("tree_ver",tree_version);
			obj.put("version",rs.getString(3));
			obj.put("comment",rs.getString(4));
			obj.put("writer",rs.getString(5));
			String dateStr = formatter.format(rs.getTimestamp("update"));
			obj.put("update",dateStr);
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

