<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>                   
<%
	String user = (String)session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="./view.css">
<script src="./view.js"></script>
</head>
<body>
<div class="panel panel-default" id="list">
<div class="panel-heading" id="p_header"><H3>My Repository</H3></div>
<div class="panel-body">
<ol class="breadcrumb">
<li><a href="#" value="all">All</a></li>
<li><a href="#" value="public">Public</a></li>
<li><a href="#" value="private">Private</a></li>
<li><a href="#" value="requestor">Requestor</a></li>
</ol>
<div class="list-group" id="list-group"></div>
</div>
</div>
</body>
</html>

