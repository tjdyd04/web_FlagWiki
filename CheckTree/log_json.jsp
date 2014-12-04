<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page import="org.json.simple.JSONObject"%>
  <%@ page import="org.json.simple.JSONArray"%>
  <%@ page import = "java.sql.*" %>                   

  <%

	String user = (String)session.getAttribute("user");
    String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                                                  
    String pw = "wjstks25@";                                               

	Connection conn = null;                   
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String history_sql = "SELECT * FROM history WHERE b_user=?"; 

    try{
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url,id,pw);
	pstmt = conn.prepareStatement(history_sql);
	pstmt.setString(1,user);
	rs = pstmt.executeQuery();

	JSONArray itemList = new JSONArray();
    while(rs.next()){    
    	JSONObject obj=new JSONObject();
		obj.put("tree", rs.getString(2));
    	obj.put("b_user",rs.getString(3));
    	obj.put("content",rs.getString(5));
		obj.put("type",rs.getString(6));
		obj.put("update",rs.getString(7));
    	itemList.add(obj);
    }
	
    out.print(itemList);
    out.flush();
    }catch(SQLException e){                                   
    	 e.printStackTrace();
	}finally{
		if(conn != null) try{conn.close();} catch(SQLException e){}
		if(pstmt != null) try{pstmt.close();} catch(SQLException e){}
		if(rs != null) try{rs.close();} catch(SQLException e){}
	}
  %>
