<%@ page language ="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<% request.setCharacterEncoding("euc-kr");%>

<%

String user_id = "";

try{

	user_id = (String)session.getAttribute("user_id"); 

	if(id==null||id.equals(""){ // id가 Null 이거나 없을 경우
		response.sendRedirect("index.html");    // 로그인 페이지로 리다이렉트
	}

}

%>