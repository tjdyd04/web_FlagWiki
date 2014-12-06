<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import = "java.sql.*" %>                   
<%
	request.setCharacterEncoding("utf-8");
	String user = (String)session.getAttribute("user");
	String b_user = request.getParameter("b_user");
	String tree = request.getParameter("tree");
	String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                               
    String pw = "wjstks25@";
	
	String search_mem = "SELECT tree.title,tree.user,tree.view,tree_member.user,tree_member.rank FROM tree RIGHT OUTER JOIN tree_member ON tree.idx = tree_member.idx_tree WHERE tree_member.user=? AND tree.title=?"; 
	
	Connection conn = null;                   
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try{
	    Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,id,pw);
		pstmt = conn.prepareStatement(search_mem);
		pstmt.setString(1,user);
		pstmt.setString(2,tree);
		rs = pstmt.executeQuery();

		JSONArray itemList = new JSONArray();
   		while(rs.next()){    
   			JSONObject obj=new JSONObject();
			obj.put("rank",rs.getString(5));
			obj.put("view",rs.getString(3));
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

