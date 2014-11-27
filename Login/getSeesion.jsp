<%@ page language ="java" contentType="text/html; charset=EUC-KR" pageEncoding="utf-8"%>

<% request.setCharacterEncoding("utf-8");%>

<%


try{

	String user_id = (String)session.getAttribute("user_id"); 
//	String pw = request.getParameter("pw");

	if(user_id==null||user_id.equals("")){ // id가 Null 이거나 없을 경우
		response.sendRedirect("./index.html");    // 로그인 페이지로 리다이렉트
	}
	else
	{

//	Object lobj_getdata=session.getAttribute("user_id");

	String ls_getdata=user_id;

	out.println(" 설정된 세션값 [1] : "+ls_getdata+"<br><br>");


		response.sendRedirect("http://www.flagwiki.co.kr/Search");
	}

}

%>