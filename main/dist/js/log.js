$(document).ready(function(){
	$.post('/main/log_json.jsp',function(data){
		var html = '';
			html +='<div class="panel panel-default log_panel_top">';
			html +='<div class="panel-body log_panel">';
			html +='히스토리 목록';
			html +='</div>';
			html +='</div>';
		$.each(data,function(enteyIndex,entry){
			html +='<div class="panel panel-default log_panel_top">';
			html += '<span class="update_time">' + entry.update + '</span>';
			html +='<div class="panel-body log_panel">';
			html += entry.content;
			html +='</div>';
			html +='</div>';
		});
		$('#log_content').html(html);
	},"json");
});
