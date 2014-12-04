<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
	String idx = request.getParameter("idx");
	String type = request.getParameter("type");
	String tree = request.getParameter("tree");
	String b_user = request.getParameter("b_user");
	String version = request.getParameter("version");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<script type="text/javascript">
$(document).ready(function(){
	var idx="<%=idx%>";
	var type="<%=type%>";
	var tree="<%=tree%>";
	var b_user="<%=b_user%>";
	var version="<%=version%>";
    
	$.post('json.jsp',{idx:idx,type:type,tree:tree,b_user:b_user,version:version}, function(data) {
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
        $('#main').html(html);
    },"json");
});
</script>
</head>
<body>
<div id="main"></div>    
</body>    
</html>
