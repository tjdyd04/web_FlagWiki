<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import = "java.sql.*" %>                   
<%
	String user = (String)session.getAttribute("user");
	String val = request.getParameter("value");
	String sql ="";
	if(val.equals("all")){
		sql= "SELECT tree.title,tree.user,tree.view,tree_member.rank,tree_member.user FROM tree RIGHT OUTER JOIN tree_member ON tree.idx = tree_member.idx_tree WHERE tree_member.user=?"; 
	}else if(val.equals("private")){
		sql= "SELECT tree.title,tree.user,tree.view,tree_member.rank FROM tree RIGHT OUTER JOIN tree_member ON tree.idx = tree_member.idx_tree WHERE tree.user=? AND tree.view='0' AND tree_member.rank!='2'"; 
	}else if(val.equals("public")){
		sql= "SELECT tree.title,tree.user,tree.view,tree_member.rank FROM tree RIGHT OUTER JOIN tree_member ON tree.idx = tree_member.idx_tree WHERE tree.user=? AND tree.view='1' AND tree_member.rank!='2'"; 
	}
	Connection conn = null;
	ResultSet rs = null; 
	PreparedStatement pstmt = null;

    String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                       
    String pw = "wjstks25@";            
	try{
    Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection(url,id,pw);
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,user);
	rs = pstmt.executeQuery();

	JSONArray itemList = new JSONArray();
    while(rs.next()){    
    	JSONObject obj=new JSONObject();
		obj.put("title",rs.getString(1));
    	obj.put("user",rs.getString(2));
    	obj.put("view",rs.getString(3));
		obj.put("rank",rs.getString(4));
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
