<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page import="org.json.simple.JSONObject"%>
  <%@ page import="org.json.simple.JSONArray"%>
  <%@ page import = "java.sql.*" %>                   

  <%
  	String idx = request.getParameter("idx");
	String board_idx = request.getParameter("board_idx");
	String copy_title="";
	String copy_content="";
	String version="";

    String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                                                  
    String pw = "wjstks25@";                                               

	String sql = "SELECT * FROM request WHERE idx=?";
	String copy_sql = "SELECT * FROM mainboard WHERE idx=?";

	Connection conn = null;                   
	PreparedStatement pstmt = null;
	ResultSet rs = null;

    try{
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url,id,pw);
	pstmt = conn.prepareStatement(copy_sql);
	pstmt.setString(1,board_idx);
	rs = pstmt.executeQuery();
	while(rs.next()){
		copy_title=rs.getString(2);
		copy_content=rs.getString(3);
		version=rs.getString(10);
	}
	rs.close();
	pstmt.close();

	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,idx);
	rs = pstmt.executeQuery();

	JSONArray itemList = new JSONArray();
    while(rs.next()){    
    	JSONObject obj=new JSONObject();
		obj.put("idx", rs.getString(1));
    	obj.put("title",rs.getString(4));
    	obj.put("content",rs.getString(5));
		obj.put("copy_title",copy_title);
		obj.put("copy_content",copy_content);
		obj.put("version", version);
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
