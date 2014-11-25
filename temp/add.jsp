<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>                   
<%
	request.setCharacterEncoding("utf-8");
	String user = (String)session.getAttribute("user");
	String title = request.getParameter("title");
	String sql = "INSERT INTO jsontest(title,user,tree)" + " values(?,?,?)";  
	Connection conn = null;                   
	PreparedStatement pstmt = null;

    String url = "jdbc:mysql://localhost:3306/jykim";        
    String id = "jykim";                       
    String pw = "wjstks25@";            
	try{
    Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection(url,id,pw);
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,title);
	pstmt.setString(2,user);
	pstmt.setString(3,title);
	pstmt.executeUpdate();
	}catch(SQLException e){

	}finally{
		if(conn != null) try{conn.close();} catch(SQLException e){}
		if(pstmt != null) try{pstmt.close();} catch(SQLException e){}
	}
%>
<script>
location.href="list.jsp"
</script>
