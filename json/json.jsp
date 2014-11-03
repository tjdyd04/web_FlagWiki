<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page import="org.json.simple.JSONObject"%>
  <%@ page import="org.json.simple.JSONArray"%>
  <%@ page import = "java.sql.*" %>                   

  <%
    Connection conn = null;                                       

     try{
     String url = "jdbc:mysql://localhost:3306/jykim";        
     String id = "jykim";                                                    
     String pw = "wjstks25@";                                               

     Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
     conn=DriverManager.getConnection(url,id,pw);
     Statement stmt = conn.createStatement();// DriverManager 객체로부터 Connection 객체를 얻어온다.
     ResultSet rs = stmt.executeQuery("select * from jsontest");
    
    JSONArray itemList = new JSONArray();
    while(rs.next()){    
    	JSONObject obj=new JSONObject();
		obj.put("idx",rs.getString(1));
    	obj.put("title",rs.getString(2));
    	obj.put("cotent",rs.getString(3));
    	itemList.add(obj);
    }
	
    out.print(itemList);
    out.flush();
    }catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.
     e.printStackTrace();
    } 
  %>
