<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page import="org.json.simple.JSONObject"%>
  <%@ page import="org.json.simple.JSONArray"%>
  <%@ page import = "java.sql.*" %>                   

  <%

	String tree = request.getParameter("tree");
	if(tree != null){
		tree = new String(request.getParameter("tree").getBytes("iso-8859-1"), "UTF-8");//get 방식의경우
	}
	String user = (String)session.getAttribute("user");
    String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                                                    
    String pw = "wjstks25@";                                               
	Connection conn = null;                       
	Statement stmt = null;
	ResultSet rs = null;
	
	String sql="select * from jsontest WHERE user='" + user + "'AND tree='" + tree + "' order by branch,leaf";
    
	try{

    Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url,id,pw);
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
		obj.put("branch_num",rs.getInt(6));
		obj.put("leaf_num",rs.getInt(7));
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
