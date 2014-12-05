<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import = "java.sql.*" %>          

<%

	String user = request.getParameter("user");

	Connection conn=null;
	Statement stmt = null;
//	PreparedStatement pstmt=null;
	ResultSet rs = null;

	try{
	  
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/jykim","jykim","wjstks25@");


		stmt = conn.createStatement();
		String sql =  "select * from member where user='"+user+"'";


		rs = stmt.executeQuery(sql);

		
	}catch(Exception e){ 	
		out.printStackTrace(e);
	}

%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title> check ID </title>
		<script>

		function checkIdClose(user)
		{
			opener.memberForm.user.value= user;
			window.close();
			opener.memberForm.pw.focus();
		}

		</script>

	</head>
	<body>
		<form method="post" action="check_idDB.jsp"> 
		<%

			try{

				if(rs.next() || (user)==null)
				{
		%>
					현재 <%=user %> 사용불가능<br></br>
					아이디 : <input type="text" name="user"></input>
					<input type="submit" value="중복체크"></input>

		<%
				}
				else
				{
		%>
					현재 <%=user %> 사용가능<br></br>
					<a herf="check_idDB.jsp"> 다른아이디 고르기</a><br></br>
					<input type="button" value="현재아이디선택" onClick="javascript:checkIdClose('<%= user %>')">
		<%
				}

		}
		catch(Exception e1){
		e1.printStackTrace();
	}finally{

		try
		{
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
			if(rs!=null) rs.close();
		}
		catch(Exception e2)
		{
			e2.printStackTrace();
		}
	}

	%>


		</form>
	</body>
</html>