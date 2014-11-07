<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String idx = request.getParameter("idx");
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-ｅquiv="Content-Type" content="text/html; charset=UTF-8">
    <title>게시판 등록</title>
    <script type="text/javascript" src="/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="/ckeditor_full/ckeditor.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var idx="<%=idx%>";
    $.getJSON('json.jsp',{idx:idx}, function(data) {
        var html = '';
        $.each(data, function(entryIndex, entry) {
            html += '<textarea cols="80" id="contents" name="contents" rows="10">' + entry.content + '</textarea>';

        });
        $('#test').html(html);
		CKEDITOR.replace('contents');
    });
});
</script>

</head>
<body>
<div id="test"></div>
</body>
</html>
