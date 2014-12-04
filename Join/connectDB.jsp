<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>          

<%

request.setCharacterEncoding("UTF-8");

String email = request.getParameter("email");
String user_id = request.getParameter("user_id");
String pw = request.getParameter("pw");

Connection conn=null;
Statement stmt = null;
//PreparedStatement pstmt=null;

try{
                                          
//
	Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/jykim","jykim","wjstks25@");

	
	String sql = "INSERT INTO member(email,user_id,pw) VALUES('"
	+email
	+"','"
	+user_id
	+"',MD5('"
	+pw+"'))";

	stmt = conn.createStatement();
	int successSQL = stmt.executeUpdate(sql);
/*
	pstmt = conn.prepareStatement("INSERT INTO member(email,user_id,pw) VALUES(?,?,?)");

	pstmt.setString(1,email);
	pstmt.setString(2,user_id);
	pstmt.setString(3,pw);

	int successSQL = pstmt.executeUpdate();
*/
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