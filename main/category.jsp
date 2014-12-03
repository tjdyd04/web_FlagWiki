<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import = "java.sql.*" %>                   
<%
	Connection conn = null;
	ResultSet rs = null; 
	PreparedStatement pstmt = null;
	
    String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                       
    String pw = "wjstks25@";            
	String sql = "SELECT * FROM category ORDER BY content";
	
	try{
    Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection(url,id,pw);
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();

	JSONArray itemList = new JSONArray();
    while(rs.next()){    
    	JSONObject obj=new JSONObject();
		obj.put("title",rs.getString(2));
    	itemList.add(obj);
    }
    out.print(itemList);
    out.flush();
}catch(SQLException e){
	//
}finally{
	if(conn != null) try{conn.close();} catch(SQLException e){}
	if(rs != null) try{rs.close();} catch(SQLException e){}
	if(pstmt !=null) try{pstmt.close();} catch(SQLException e){}
}
%>
