<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String idx = request.getParameter("idx");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-ｅquiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 등록</title>
<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
<script src="request_button.js"></script>
<script type="text/javascript">
var idx="<%=idx%>";
$(document).ready(function(){
    $.post('request_json.jsp',{idx:idx}, function(data) {
		var html = '';
        $.each(data, function(entryIndex, entry) {
			var title=entry.title;
			var content=entry.content;
			html += '<input type="text" id="main_title" class="form-control" placeholder="Text input" name="title" value="' + title + '">'; 
            html += '<textarea cols="80" id="contents" name="contents" rows="10">' + content + '</textarea>';
			html += '<script>' + 'CKEDITOR.replace("contents")' + '</' + 'script>';
        });
        $('#board').html(html);
    },"json");
});

</script>
</head>
<body>
<div id="board"></div>
<input type="button" id="button" value="수정" class="btn btn-default">
</body>
</html>
