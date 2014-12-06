<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<!-- include jQuery and jQueryUI libraries -->
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/CheckTree/minified/jquery.tree.min.js"></script>
<script type="text/javascript" src="/CheckTree/minified/bootstrap-switch.js"></script>
<script type="text/javascript" src="/CheckTree/minified/bootstrap-table.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<!-- include plugin -->
<link rel="stylesheet" type="text/css" href="/CheckTree/minified/jquery.tree.min.css" />
<link rel="stylesheet" type="text/css" href="/CheckTree/css/Main.css">
<link rel="stylesheet" type="text/css" href="/CheckTree/css/bootstrap-switch.css"/>
<link rel="stylesheet" type="text/css" href="/CheckTree/minified/bootstrap-table.min.css"/>
<jsp:include page="rank_comp.jsp" flush="false" />
<!-- initialize checkboxTree plugin -->
<script type="text/javascript" src="/CheckTree/tree/main_tree.js"></script>
<script type="text/javascript" src="/CheckTree/option/main_option.js"></script>
</head>    
<body>
	<div id="left">
	<div id="tree"></div>    
	<div id="option"></div>
	</div>
	<div id="right"></div>
</body>    
</html>    
