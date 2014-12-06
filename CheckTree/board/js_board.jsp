<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String idx = request.getParameter("idx");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8"/>
<title>게시판 등록</title>
<script type="text/javascript" src="/CheckTree/ckeditor/ckeditor.js"></script>
<script src="/CheckTree/tree/button.js"></script>
<script type="text/javascript">
var idx="<%=idx%>";
$(document).ready(function(){
    $.post('/CheckTree/board/board_json.jsp',{idx:idx}, function(data) {
		var html = '';
        $.each(data, function(entryIndex, entry) {
			html += '<input type="text" id="main_title" class="form-control" placeholder="Text input" name="title" value="' + entry.title + '">'; 
            html += '<textarea cols="80" id="contents" name="contents" rows="10">' + entry.content + '</textarea>';
			html += '<script>' + 'CKEDITOR.replace("contents")' + '</' + 'script>';
        });
        $('#board').html(html);

    },"json");
});

</script>
</head>
<body>
<div id="board"></div>
<input type="button" id="button" value="적용" class="btn btn-default">
</body>
</html>
