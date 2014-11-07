<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
	String idx = request.getParameter("idx");
%>
<DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var idx="<%=idx%>";
    $.getJSON('json.jsp',{idx:idx}, function(data) {
        var html = '';
        $.each(data, function(entryIndex, entry) {
            html += '<div>';
            html += '<h3>';
			html += '<span>';
			if(entry.branch!=0){
				html+= entry.branch;
				if(entry.branch!=0 && entry.leaf == 0){
					html+= '.';
				}
			}
			if(entry.leaf!=0){
				html+= '-' + entry.leaf + '.';  
			}
			html += entry.title + '</span></h3>';
            html += '<p>' + entry.content + '</p>';
            html += '</div>';
        });
        $('#test').html(html);
    });
});
</script>
</head>
<body>
<div id="test"></div>    
</body>    
</html>
    
