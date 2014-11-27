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

	String sql = "select * from member where user_id= '" + user_id+"' and pw = '" + pw + "'");

	ResultSet rs = stmt.executeQuery(sql);

	if (rs.next() == true) {
			out.println("success");
	}
	else
	{
		out.println("fail");
	}

	stmt.close();
	conn.close();


}catch(Exception e){ 	
	out.println(e);
}


%>
