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

	String sql =  "select * from member where user_id= '" + user_id+"' and pw = '" + pw + "'";

/*	stmt.setString(1,user_id);
	stmt.setString(2,pw);
*/
	ResultSet rs = stmt.executeQuery(sql);

	rs.first();
	boolean idB = user_id.equals(rs.getString("user_id"));
	boolean pwB = pw.equals(rs.getString("pw"));
	if ( idB && pwB) {

		//성공시 세션연결.
		session.setAttribute("user_id",user_id);
		session.setMaxInactiveInterval(60*60); //60분유지
//		response.sendRedirect("~~~~"); //로그인성공시 이동
		out.println("id : " + user_id +" 로그인했습니다 ");

	//	"sessionLogout.jsp" 로그아웃 세션jsp
	}
	else
	{
		out.println("Login fail");
	}


	stmt.close();
	conn.close();
	rs.close();


}catch(Exception e){ 	
	out.println(e);
}

%>