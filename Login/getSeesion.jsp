<%@ page language ="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<% request.setCharacterEncoding("euc-kr");%>

<%

String user_id = "";

try{

	user_id = (String)session.getAttribute("user_id"); 
	String pw = request.getParameter("pw");

	if(user_id==null||user_id.equals("")){ // id가 Null 이거나 없을 경우
		response.sendRedirect("index.html");    // 로그인 페이지로 리다이렉트
	}
	else
	{
		response.sendRedirect("http://www.flagwiki.co.kr/Search");
	}

}

%>