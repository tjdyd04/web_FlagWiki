<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>                   
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/CheckTree/minified/bootstrap-table.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<!-- include plugin -->
<link rel="stylesheet" type="text/css" href="/CheckTree/minified/bootstrap-table.min.css"/>
<link rel="stylesheet" type="text/css" href="/Search/css/search.css">

</head>
<body>

<form action="search.jsp" method="post">
<div id="flag_search">
<a class="link" href="/Search/Repositores.jsp">FlagWiki</a>
	<div id="search_select">
	<select class="form-control" name="search_cate">
	<option>제목</option>
	<option>설명</option>
	<option>작성자</option>
	</select>
	</div>
	<div id="search_type">
	<input class="form-control" id="search_input" name="search_title" type="text" placeholder="검색어를 입력 해주세요" value="">
	</div>
	<button type="submit" class="btn btn-default" id="btn_search">검색</button>
</div>
<hr>
</form>
</body>
</html>

