<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="../Head_Navigation/head.jsp" flush="false" />
<%
	String user = (String)session.getAttribute("user");
	if(user == null){
%>
	<script>
	location.href="/Search/intro.jsp";
	</script>
<%
	}
%>

<!DOCTYPE html>
<html>
<head>
<!-- 부트스트랩 -->
<meta charset=UTF-8"/>
<title>레파지토리 목록</title>
</head>
<body>
	<jsp:include page="/Search/search_init.jsp" flush="true"/>
	<jsp:include page="/main/view.jsp" flush="true"/>
</body>
</html>
