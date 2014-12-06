$(document).ready(function(){
	var select=$('#search_select select');
	var target=$('#search_input');
	
	select.val(s_cate);
	target.val(s_title);
	

	$('#btn_search').click(function(){
		var value = target.val();
		var type = select.val();
		$.post('category_list.jsp',{value:value,type:type},function(data){
			var html='';
			$.each(data,function(entryIndex,entry){
			var count = entry.count;
			var cate = entry.category;
			if(entry.count=='0'){
				cate='자료없음';
			}
			html +='<div class="panel panel-default log_panel_top">';
			html +='<div class="panel-body log_panel">';
			html += cate + '/' + count;
			html +='</div>';
			html +='</div>';
			});
			$('#cate').html(html);
		},"json");
		
		$.post('search_list.jsp',{value:value,type:type},function(data){
			var size=$(data).size();
			var html='';
			if(size!=0){
				html +='<div class="panel panel-default log_panel_top">';
				html +='<div class="panel-body log_panel">';
				html +='총 ' + size + '개의 데이터를 찾았습니다.';
				html +='</div>';
				html +='</div>';
			}
			html+='<table id="request_table"></table>';
			$('#search_result').html(html);
			$('#request_table').bootstrapTable({
				data:data,
				pagination: true,
				cardView:true,				
				showHeader: false,
				columns:[{
					field:'idx',
					},{
					field:'title',
					title:'글제목'
					},{
					field:'description',
					title:'설명'
					},{
					field:'last_update',
					title:'업데이트날짜'
				}]
			});	

		},"json");

	});
	$("#btn_search").click();	
	$("#search_input").keyup(function(event){
	    if(event.keyCode == 13){
			$("#btn_search").click();
		}
	});
});
