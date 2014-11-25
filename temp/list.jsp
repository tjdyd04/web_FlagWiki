<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>                   
<%
	String user = (String)session.getAttribute("user");
	String sql = "SELECT * FROM jsontest WHERE branch=? AND leaf=? AND user=?";  
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
	pstmt.setString(1,"0");
	pstmt.setString(2,"0");
	pstmt.setString(3,user);

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
	<div><a href="../CheckTree/board.jsp?tree=<%=rs.getString(9)%>"><%=rs.getString(9)%></a></div>

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
