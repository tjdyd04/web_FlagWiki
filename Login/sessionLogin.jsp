<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>          

<%
request.setCharacterEncoding("UTF-8");

String user_id = request.getParameter("user_id");
String pw = request.getParameter("pw");

try{
                                          
//
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/jykim","jykim","wjstks25@");

	Statement stmt = conn.createStatement();

	String sql = "select * from member where user_id= '" + user_id+"' and pw = '" + pw + "'";

	ResultSet rs = stmt.executeQuery(sql);

	rs.first();
	boolean idB = user_id.equals(rs.getString("user_id"));
	boolean pwB = pw.equals(rs.getString("pw"));
	if ( idB && pwB) {

		session.setAttribute("user_id",user_id);
		out.println("id : " + user_id);

	//	<a href="sessionLogout.jsp">로그아웃</a>
	}
	else
	{
		out.println("fail");
	}

	stmt.close();
	conn.close();
	rs.close();


}catch(Exception e){ 	
	out.println(e);
}

%>