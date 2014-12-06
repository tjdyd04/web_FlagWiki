<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String user = (String)session.getAttribute("user");
	if(user != null){
%>
	<script>
	location.href="/Search/Repositores.jsp";
	</script>
<%
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"/>
<link rel="stylesheet" type="text/css" href="/Search/css/intro.css" />
</head>
<body>
<jsp:include page="/Head_Navigation/head.jsp" flush="false" />
<div id="center_img"><img src="//lh3.ggpht.com/UJd2DDqEYGe-Z1co3kQl0Erc20K5rv0tWJiBvaZbWdoh2qOltYCOu4_rglQijnPJ-ypXLeosuFP-orUTVyk8u3a4-1BNdYVmjjskGv9I=s660"></div>	
<jsp:include page="/Search/search_init.jsp" flush="true"/>
</body>
</html>
