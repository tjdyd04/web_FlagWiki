$(document).ready(function(){
	$.post('log_json.jsp',function(data){
		var html = '';
		$.each(data,function(enteyIndex,entry){
			html +='<div class="panel panel-default">';
			html +='<div class="panel-body">';
			html += entry.content;
			html +='</div>';
			html +='</div>';
		});
		$('#log_content').html(html);
	},"json");
});
