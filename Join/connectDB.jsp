<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>          

<%

request.setCharacterEncoding("UTF-8");

String user = request.getParameter("user");
String pw = request.getParameter("pw");

Connection conn=null;
Statement stmt = null;
//PreparedStatement pstmt=null;

try{
                                          
//
	Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/jykim","jykim","wjstks25@");

	
	String sql = "INSERT INTO member(user,pw) VALUES('"
	+user
	+"',MD5('"
	+pw+"'))";

	stmt = conn.createStatement();
	int successSQL = stmt.executeUpdate(sql);

	if(successSQL==1)
	{
		response.sendRedirect("http://www.flagwiki.co.kr/Login");
	}

}catch(Exception e){ 	
	out.println(e);
}finally{

	stmt.close();
	//pstmt.close();
	conn.close();

}

%>