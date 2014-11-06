<%@ page contentType="text/html;charset=EUC-KR"%>

<%
    session.invalidate(); // 세션 삭제
    response.sendRedirect("./index.html");
%>