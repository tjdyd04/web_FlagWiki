<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>                   
<%
	String user = (String)session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="dist/css/bootstrap-select.css">
<link rel="stylesheet" type="text/css" href="create.css">

<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="dist/js/bootstrap-select.js"></script>
<script src="create.js"></script>
</head>
<body>
<fieldset class="well the-fieldset">
<form class="form">
<legend><H1>저장소추가</H1></legend>
<div id="info">
<a class="btn btn-primary" href="#"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> USER <%=user%> </a>
<input type="text" id="rep_text" class="form-control" placeholder="저장소 이름" name="rep">
</div>
<legend class="small"></legend>
<div id="type">
<H3>검색노출여부</H3>
<div class="btn-group" data-toggle="buttons">
<label class="btn btn-primary active">
<input type="radio" name="options" id="option1" value="public" autocomplete="off" checked> YES
</label>
<label class="btn btn-primary">
<input type="radio" name="options" id="option2" value="private" autocomplete="off"> NO
</label>
</div>
<legend class="small"></legend>
</div>
<div id="ref_desc">
<H3>요약글</H3>
<input type="text" width="200px" class="form-control" placeholder="저장소 소개" name="desc">
</div>
<legend class="small"></legend>
<H3>게임 카테고리</H3>
<select class="selectpicker" data-live-search="true">
<option value="one">One</option>
<option value="two">Two</option>
<option value="three">Three</option>
<option value="four">Four</option>
<option value="five">Five</option>
</select>
<div id="last">
<input type="submit" id="rep_submit" class="btn btn-success" value="저장소만들기">
<div>
</form>
</fieldset>
</body>
</html>

