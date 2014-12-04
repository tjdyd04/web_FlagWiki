<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>                   
<%
	Connection conn = null;                   
	ResultSet rs = null; 
	PreparedStatement pstmt = null;

	String sql = "SELECT * FROM tree"; 
    String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                       
    String pw = "wjstks25@";            
	
	try{
    Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection(url,id,pw);
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
</head>
<body>
<%
	while(rs.next()){
%>
	<div><a href="../CheckTree/index.jsp?tree=<%=rs.getString(2)%>&b_user=<%=rs.getString(3)%>"><%=rs.getString(2)%></a></div>
<%
	}
%>	
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


