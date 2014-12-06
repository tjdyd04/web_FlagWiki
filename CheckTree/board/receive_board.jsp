<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String idx = request.getParameter("idx");
	String type = request.getParameter("type");
	String board_idx =request.getParameter("board_idx");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-ｅquiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 등록</title>
<script type="text/javascript" src="/CheckTree/ckeditor/ckeditor.js"></script>
<script src="/Checktree/option/request_button.js"></script>
<script type="text/javascript">
var idx="<%=idx%>";
var type="<%=type%>";
var board_idx="<%=board_idx%>";

$(document).ready(function(){
    $.post('/CheckTree/option/request_json.jsp',{idx:idx,board_idx:board_idx}, function(data) {
		var html = '';
		var copy_html ='';
        $.each(data, function(entryIndex, entry) {
			var title=entry.title;
			var content=entry.content;
			html += '<H3>요청내용</H3>';
			html += '<input type="text" id="main_title" class="form-control" placeholder="Text input" name="title" value="' + title + '">'; 
           	html += '<textarea cols="80" id="contents" name="contents" rows="10">' + content + '</textarea>';
			html += '<script>' + 'CKEDITOR.replace("contents")' + '</' + 'script>';
			if(type=="수정요청"){
				title=entry.copy_title;
				content=entry.copy_content;
				copy_html += '<H3>원본항목</H3><span>(' + entry.version + ' 번째 깃발)</span>';
				copy_html += '<input type="text" id="main_title_copy" class="form-control" placeholder="Text input" name="title_copy" value="' + title + '">'; 
            	copy_html += '<textarea cols="80" id="contents_copy" name="contents_copy" rows="10">' + content + '</textarea>';
				copy_html += '<script>' + 'CKEDITOR.replace("contents_copy")' + '</' + 'script>';
			}
        });
        $('#board').html(html);
		$('#copy_board').html(copy_html);
    },"json");
});
</script>
</head>
<body>
<div id="board"></div>
<input type="button" id="button" value="적용" class="btn btn-default">
<div id="copy_board"></div>
</body>
</html>
