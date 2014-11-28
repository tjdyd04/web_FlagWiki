
function show_list(value){
	var folder_icon;
	var html = '';
	html +='<div class="list-group">';
	$.post("list_json.jsp",{value:value},function(data){
		$.each(data,function(entryIndex,entry){
			if(entry.view == '0'){
				folder_icon ="glyphicon glyphicon-ban-circle";
			}else if(entry.view =='1'){
				folder_icon ="glyphicon glyphicon-folder-open";
			}
			var para = encodeURIComponent(entry.title);
			html +='<a href="../CheckTree/board.jsp?tree=' + para + '" class="list-group-item">';	
			html +='<span class="' + folder_icon + '" aria-hidden="true"></span>';
			html += entry.title + '</a>';

			num = entryIndex;
		});
		html +='</div>';
		$('#list-group').html(html);	
	},"json");
}

function add_repository(){
	var html ='';
	var button_html = '<button type="button" id="add_rep" class="btn btn-success">';
	var icon_html = '<span class="glyphicon glyphicon-star" aria-hidden="true"></span>Create Repository';
	html += button_html;
	html += icon_html;
	html +='</button>';
	$('#p_header').append(html);
}


$(document).ready(function(){
	var value="all";
	add_repository();
	show_list(value);
	$('.breadcrumb li a').click(function(){
		value = $(this).attr('value');
		show_list(value);
	});
	$('#add_rep').click(function(){
		window.location="create.jsp";
	});
});	
