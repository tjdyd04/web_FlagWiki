<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page import="org.json.simple.JSONObject"%>
  <%@ page import="org.json.simple.JSONArray"%>
  <%@ page import = "java.sql.*" %>                   

  <%
  	String idx = request.getParameter("idx");
    Connection conn = null;                       
	String sql;
	if(idx.equals("0")){
		sql="select * from jsontest order by branch,leaf";
	}else{
		sql="select * from jsontest where idx = '" + idx + "';";
	}
    try{
    String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                                                    
    String pw = "wjstks25@";                                               
    Class.forName("com.mysql.jdbc.Driver");
    conn=DriverManager.getConnection(url,id,pw);
    Statement stmt = conn.createStatement();

	ResultSet rs = stmt.executeQuery(sql);
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
	rs.close();
	stmt.close();
	conn.close();
    }catch(SQLException e){                                   
    	 e.printStackTrace();
	}
  %>
