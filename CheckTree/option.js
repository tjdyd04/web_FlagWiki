$(document).ready(function(){
	var html='<ul class="nav nav-pills nav-stacked">';
	var on='<input type="checkbox"  name="my-checkbox" checked>';
	var off='<input type="checkbox" name="my-checkbox">';
	html +='<li class="active"><a>탭펼치기' + off + '</a></li>';
	html +='</ul>';
	var list='';
	list +='<ul class="nav nav-pills nav-statcked" id="option_ul">';
	list +='<li class="active"><a href="#" id="mem_list" class="option_list">참여중인인원</a></li>';
	list +='<li class="active"><a href="#" id="add_mem" class="option_list">협력자추가</a></li>';
	list +='<li class="active"><a href="#" class="option_list">도움요청하기</a></li>';
	list +='<li class="active"><a href="#" class="option_list">깃발항목</a></li>';
	list +='</ul>'
	$('#option').html(html);
	$('#option').append(list);
	$("[name='my-checkbox']").bootstrapSwitch();	
	$('#option_ul').hide();

	$('input[name="my-checkbox"]').on('switchChange.bootstrapSwitch', function(event, state) {
		
		if(state==true){
			$('#option_ul').show();
		}else{
			$('#option_ul').hide();
		}
	});
	$('#mem_list').click(function(){
		show_user();	
	});
	$('#add_mem').click(function(){
		var html='';
		html += '<div id="insert_mem" class="form-group has-error">';
		html += '<label class="control-label" for="inputError1">협력자추가</label>';
		html += '<input type="text" class="form-control" placeholder="아이디입력" id="inputError1">'; 
		html += '<input type="button" class="btn btn-danger" id="add_button" value="추가">';
		html += '</div>'
		$('#right').html(html);
		$('#add_button').click(function(){
			var val=$('#inputError1').val();
			$.post('add_mem.jsp',{tree:tree,b_user:b_user,val:val});		
		});
	});
});

function show_user(){
	var html='';
	$.post('mem_json.jsp',{tree:tree,b_user:b_user},function(data){
		var user_id="";
		$.each(data,function(entryIndex,entry){
			if(entry.rank=='0'){
				user_id="label label-primary";
			}else if(entry.rank=='1'){
				user_id="label label-success";
			}else if(entry.rank=='2'){
				user_id="label label-warning";
			}
			html+='<p><span class="' + user_id + '">' + entry.user + '</span></p>';				
		});
	$('#right').html(html);
	},"json");
}	
