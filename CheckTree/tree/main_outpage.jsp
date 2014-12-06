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
    
	$.post('/CheckTree/tree/json.jsp',{idx:idx,type:type,tree:tree,b_user:b_user,version:version}, function(data) {
        var html = '';
		var up_num=0;
		var up_temp_num=0;

		var under_num=0;
        $.each(data, function(entryIndex, entry) {
            html += '<div>';
            html += '<h3>';
			html += '<span>';
			if(entry.branch!=0){
				if(entry.branch > up_temp_num){
					under_num=0;
					up_num++;
				}
				up_temp_num = entry.branch;
				html+= up_num;
				if(entry.branch!=0 && entry.leaf == 0){
					html+= '.';
				}
			}
			if(entry.leaf!=0){
				under_num++;
				html+= '-' + under_num + '.';  
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
