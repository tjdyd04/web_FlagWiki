<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import = "java.sql.*" %>                   
<%
	request.setCharacterEncoding("utf-8");
	String user = (String)session.getAttribute("user");
	String b_user = request.getParameter("b_user");
	String tree = request.getParameter("tree");
	String url = "jdbc:mysql://localhost:3306/jykim" ;        
    String id = "jykim";                               
    String pw = "wjstks25@";
	String mypage_sql = "SELECT * FROM request WHERE user=? AND tree=? AND b_user=?"; 
	
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy.MM.dd  HH시 mm분");

	Connection conn = null;                   
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try{
	    Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,id,pw);
		pstmt = conn.prepareStatement(mypage_sql);
		pstmt.setString(1,user);
		pstmt.setString(2,tree);
		pstmt.setString(3,b_user);
		rs = pstmt.executeQuery();

		JSONArray itemList = new JSONArray();
   		while(rs.next()){    
   			JSONObject obj=new JSONObject();
			obj.put("idx",rs.getString(1));
			obj.put("user",rs.getString(3));
			obj.put("title",rs.getString(4));
			String dateStr = formatter.format(rs.getTimestamp("date"));
			obj.put("date",dateStr);
			obj.put("type",rs.getString(9));
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

