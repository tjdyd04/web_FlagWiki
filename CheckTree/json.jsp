<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page import="org.json.simple.JSONObject"%>
  <%@ page import="org.json.simple.JSONArray"%>
  <%@ page import = "java.sql.*" %>                   

  <%
  	String idx = request.getParameter("idx");
	String type = request.getParameter("type");
	String tree = request.getParameter("tree");
	String sql="";

	if(type.equals("-1")){
		sql="select * from mainboard where idx = '" + idx + "'";
	}else if(type.equals("0")){
		sql="select * from mainboard WHERE tree='" + tree + "' ORDER BY branch,leaf";
	}else{
		sql="select * from mainboard where branch ='" + type  + "' AND tree='" + tree + "'";
	}	
    Connection conn = null;                       
	ResultSet rs = null;
	Statement stmt = null;

    try{
    String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                                                  
    String pw = "wjstks25@";                                               
    Class.forName("com.mysql.jdbc.Driver");
    
	conn=DriverManager.getConnection(url,id,pw);
    stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);

	JSONArray itemList = new JSONArray();
    while(rs.next()){    
    	JSONObject obj=new JSONObject();
		obj.put("idx", rs.getString(1));
    	obj.put("title",rs.getString(2));
    	obj.put("content",rs.getString(3));
		obj.put("branch",rs.getInt(4));
		obj.put("leaf",rs.getInt(5));
    	itemList.add(obj);
    }
	
    out.print(itemList);
    out.flush();
    }catch(SQLException e){                                   
    	 e.printStackTrace();
	}finally{
		if(conn != null) try{conn.close();} catch(SQLException e){}
		if(stmt != null) try{stmt.close();} catch(SQLException e){}
		if(rs != null) try{rs.close();} catch(SQLException e){}
	}
  %>
