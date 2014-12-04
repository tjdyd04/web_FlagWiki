<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import = "java.sql.*" %>                   
<%
	String user = (String)session.getAttribute("user");
	String value = request.getParameter("value");
	String sql = "SELECT tree.title,tree.user,tree.view,tree_member.rank FROM tree RIGHT OUTER JOIN tree_member ON tree.idx = tree_member.idx_tree WHERE tree.user=?"; 
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
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script>
$(document).ready(function(){
	$('#add').click(function(){
		location.href="add.html";
	});
});
</script>
</head>
<body>
<%
	while(rs.next()){
%>
	<div><a href="/CheckTree/board.jsp?tree=<%=rs.getString(1)%>"><%=rs.getString(1)%></a></div>

<%
	}
%>
<form action="logout.jsp" method="post">
<input type="button" id="add"  value="추가하기">
<input type="submit" id="logout" value="세션아웃">
</form>
</body>
</html>
<%
}catch(SQLException e){
	//
}finally{
	if(conn != null) try{conn.close();} catch(SQLException e){}
	if(rs != null) try{rs.close();} catch(SQLException e){}
	if(pstmt !=null) try{pstmt.close();} catch(SQLException e){}
}
%>
