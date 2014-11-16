<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String idx = request.getParameter("idx");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-ｅquiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 등록</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/ckeditor_full/ckeditor.js"></script>
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<script src="Button.js"></script>
<script type="text/javascript">
var idx="<%=idx%>";
$(document).ready(function(){
    $.getJSON('json.jsp',{idx:idx}, function(data) {
		var html = '';
        $.each(data, function(entryIndex, entry) {
			html += '<input type="text" class="form-control" placeholder="Text input" name="title" value="' + entry.title + '">'; 
            html += '<textarea cols="80" id="contents" name="contents" rows="10">' + entry.content + '</textarea>';
			html += '<script>' + 'CKEDITOR.replace("contents")' + '</' + 'script>';
        });
        $('#board').html(html);
    });
});

</script>
</head>
<body>
<div id="board"></div>
<input type="button" id="button" value="적용" class="btn btn-default">
</body>
</html>
