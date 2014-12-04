function show_list(value){
	var folder_icon;
	var html = '';
	html +='<div class="list-group">';
	$.post("/main/list_json.jsp",{value:value},function(data){
		$.each(data,function(entryIndex,entry){
			var title=entry.title;
			if(entry.rank == '1'){
				title= '<strong>' + entry.user + '</strong>/' + entry.title;
			}
			if(entry.rank == '0' || entry.rank == '1'){
				if(entry.view == '0'){
					folder_icon ="glyphicon glyphicon-ban-circle";
				}else if(entry.view =='1'){
					folder_icon ="glyphicon glyphicon-folder-open";
				}
			}else if(entry.rank =='2'){
				folder_icon = "glyphicon glyphicon-link";
			}
			var para = encodeURIComponent(entry.title);
			if(entry.rank =='0' || entry.rank =='1'){
			html +='<a href="/CheckTree/board.jsp?tree=' + para + '&b_user=' + entry.user + '" class="list-group-item">';	
			}else if(entry.rank =='2'){
			html +='<a href="/CheckTree/index.jsp?tree=' + para + '&b_user=' + entry.user + '" class="list-group-item">'; 
			}
			html +='<span class="' + folder_icon + '" aria-hidden="true"></span>';
			html += title + '</a>';

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
		window.location="/main/create.jsp";
	});
});	
