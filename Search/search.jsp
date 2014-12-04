<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>                   
<%
	request.setCharacterEncoding("utf-8");
	String s_cate=request.getParameter("search_cate");
	String s_title=request.getParameter("search_title");
	if(s_title==null){
		s_title="";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/CheckTree/minified/bootstrap-table.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/CheckTree/minified/bootstrap-table.min.css"/>
<link rel="stylesheet" type="text/css" href="search.css">
<script>
var s_cate="<%=s_cate%>";
var s_title="<%=s_title%>";
</script>
<script type="text/javascript" src="search.js"></script>
</head>
<body>
<jsp:include page="../Head_Navigation/head.jsp" flush="false" />
<div id="flag_search">
<a class="link" href="/Search/Repositores.jsp">FlagWiki</a>
	<div id="search_select">
	<select class="form-control">
	<option>제목</option>
	<option>설명</option>
	<option>작성자</option>
	</select>
	</div>
	<div id="search_type">
	<input class="form-control" id="search_input" type="text" placeholder="검색어를 입력 해주세요" value="">
	</div>
	<button type="button" class="btn btn-default" id="btn_search">검색</button>
</div>
<hr>
<div id="center">
<div id="cate"></div>
<div id="search_result"></div>
</div>
</body>
</html>

