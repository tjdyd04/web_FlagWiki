<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
	String user = (String)session.getAttribute("user");
	String tree = request.getParameter("tree");
	tree = new String(request.getParameter("tree").getBytes("iso-8859-1"), "UTF-8");//get 방식의경우
	String b_user = request.getParameter("b_user");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<!-- include jQuery and jQueryUI libraries -->
<script>
	var user ="<%=user%>";
	var tree ="<%=tree%>";
	var b_user ="<%=b_user%>";
	var jidx;
</script>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<script type="text/javascript" src="minified/jquery.tree.min.js"></script>
<script type="text/javascript" src="minified/bootstrap-switch.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<!-- include plugin -->
<link rel="stylesheet" type="text/css" href="minified/jquery.tree.min.css" />
<link rel="stylesheet" type="text/css" href="css/Main.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap-switch.css"/>
<!-- initialize checkboxTree plugin -->
<script type="text/javascript" src="main_tree.js"></script>
<script type="text/javascript" src="main_option.js"></script>
</head>    
<body>
	<div id="left">
	<div id="tree"></div>    
	<div id="option"></div>
	</div>
	<div id="right"></div>
</body>    
</html>    
