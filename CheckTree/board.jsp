<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
	String tree = request.getParameter("tree");
	String user = (String)session.getAttribute("user");
	if(tree != null){
		tree = new String(request.getParameter("tree").getBytes("iso-8859-1"), "UTF-8");//get 방식의경우
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<!-- include jQuery and jQueryUI libraries -->
<script>
	var tree ="<%=tree%>";
</script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<!-- include plugin -->
<script type="text/javascript" src="minified/jquery.tree.min.js"></script>
<link rel="stylesheet" type="text/css" href="minified/jquery.tree.min.css" />
<link rel="stylesheet" type="text/css" href="css/Board.css"/>
<script type="text/javascript" src="tree.js"></script>
<!-- initialize checkboxTree plugin -->
</head>    
<body>
<div id="left">
<div id="tree"></div>
<div id="input"></div>
</div>
<div id="right"></div>    
</body>    
</html>    
