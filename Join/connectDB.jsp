<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>          

<%

request.setCharacterEncoding("UTF-8");

String email = request.getParameter("email");
String user_id = request.getParameter("user_id");
String pw = request.getParameter("pw");


try{
                                          
//
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/jykim","jykim","wjstks25@");

	Statement stmt = conn.createStatement();

	String sql = "INSERT INTO member(email,user_id,pw) VALUES('"
	+email
	+"','"
	+user_id
	+"','"
	+pw+"')";

/*
	stmt.setString(1,email);
	stmt.setString(2,user_id);
	stmt.setString(3,pw);
*/
	stmt.executeUpdate(sql);

	stmt.close();
	conn.close();


	response.sendRedirect("member_list.jsp");

}catch(Exception e){ 	
	out.println(e);
}


%>