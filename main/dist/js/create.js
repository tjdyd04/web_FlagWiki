$(document).ready(function(){
	var html='';
	$.post('/main/category.jsp',function(data){
		html+='<select class="selectpicker" name="cate"  data-live-search="true">';
		$.each(data,function(entryIndex,entry){
			html +='<option value="' + entry.title + '">'
			html += entry.title;
			html +='</option>';
		});
		html+='</select>';
		$('#cate_area').html(html);
		$('.selectpicker').selectpicker({
			style:'btn-primary',
			size:5	
		});
	},"json");
});

