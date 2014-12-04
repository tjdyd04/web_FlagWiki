<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>          

<%
request.setCharacterEncoding("UTF-8");

Connection conn=null;
Statement stmt=null;
ResultSet rs =null;

String user = request.getParameter("user");
String pw = request.getParameter("pw");

try{

	Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/jykim","jykim","wjstks25@");


		stmt = conn.createStatement();
		String sql =  "select * from member where user= '" + user+"' and pw = MD5('" + pw + "')";

		rs = stmt.executeQuery(sql);  
		if(rs.first())
		{
			//성공시 세션연결.
			session.setAttribute("user",user);
			session.setMaxInactiveInterval(60*60); //60분유지
			response.sendRedirect("http://www.flagwiki.co.kr/Search/Repositores.jsp"); //로그인성공시 이동

			if(request.getProtocol().equals("HTTP/1.0")){ 
				response.setHeader("Pragma","no-cache"); 
				response.setDateHeader("Expires",0); 
				} else if(request.getProtocol().equals("HTTP/1.1")){ 
				response.setHeader("Cache-Control","no-cache"); 
			}

		}
		else
		{
			out.println("<script language=javascript> alert(\"등록된 아이디가 아니거나, 비밀번호 오류입니다.\"); history.go(-1); </script>");
	//		response.sendRedirect("http://www.flagwiki.co.kr/Login");         

		}




}catch(Exception e){ 	
	out.println(e);
}finally{

	if(stmt!=null)stmt.close();
	if(conn!=null)conn.close();
	if(rs!=null)rs.close();
	
}

%>