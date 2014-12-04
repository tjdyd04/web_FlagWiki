<%@ page language ="java" contentType="text/html; charset=EUC-KR" pageEncoding="utf-8"%>

<% request.setCharacterEncoding("utf-8");%>

<%


try{

	String user = (String)session.getAttribute("user"); 
//	String pw = request.getParameter("pw");

	if(user==null||user.equals("")){ // id가 Null 이거나 없을 경우
		response.sendRedirect("./index.html");    // 로그인 페이지로 리다이렉트
	}
	else
	{

//	Object lobj_getdata=session.getAttribute("user");

	String ls_getdata=user;

	out.println(" 설정된 세션값 [1] : "+ls_getdata+"<br><br>");


		response.sendRedirect("http://www.flagwiki.co.kr/Search");
	}

}

%>