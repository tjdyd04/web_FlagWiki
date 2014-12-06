function search_view(){
	$.post('/CheckTree/option/requestor.jsp',{tree:tree,b_user:b_user},function(data){
		var is_ok;
		var check ='';
		check +='<li class="active"><a href="#" id="search_box" class="option_list">검색유무</a></li>'
		$.each(data,function(entryIndex,entry){
			is_ok=entry.view;	
		});
		if(is_ok=="0"){
			$('#option_ul').append(check);
			$('#search_box').click(function(){
				var result = confirm("검색공개로 전환하면 다시 되돌리실수 없습니다. 정말 하시겠습니까?");
				if(result){
					$.post('/CheckTree/option/search_ok.jsp',{tree:tree,b_user:b_user},function(){;
						var para = encodeURIComponent(tree);
						window.location='/CheckTree/board.jsp?tree=' + para +'&b_user=' +b_user;
					});
				}else{
					//
				}
			});
		}
	},"json");	
}


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
	list +='<li class="active"><a href="#" id="mypage" class="option_list">요청항목</a></li>';
	list +='<li class="active"><a href="#" id="save" class="option_list">깃발저장</a></li>';
	list +='<li class="active"><a href="#" id="flag_list" class="option_list">깃발목록</a></li>'
	list +='<li class="active"><a href="#" id="my_rep" class="option_list">나의저장소</a></li>'
	list +='</ul>'
	$('#option').html(html);
	$('#option').append(list);
	search_view();
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
			alert(val + "님을 협력자로 추가하였습니다");
			$.post('add_mem.jsp',{tree:tree,b_user:b_user,val:val});		
		});
	}); 
	$('#save').click(function(){
		var html='';
		html += '<div id="flag_save" class="form-group has-success">';
		html += '<label class="control-label" for="inputSuccess1">깃발을 저장합니다</label>';
		html += '<input type="text" class="form-control" placeholder="깃발이름을 적어주세요" id="flag_text">'; 
		html += '<input type="button" class="btn btn-success" id="save_button" value="저장">';
		html += '</div>'
		$('#right').html(html);
		$('#save_button').click(function(){
			var val=$('#flag_text').val();
			alert("깃발을 저장하였습니다");
			$.post('/CheckTree/option/save_flag.jsp',{tree:tree,b_user:b_user,val:val});
		});
	});
	$('#flag_list').click(function(){
		var html='';
		if(version == null){
			alert(version);
		}
		$.post('/CheckTree/option/list_flag.jsp',{tree:tree,b_user:b_user}, function(data){
			var button_class="";
			$.each(data,function(entryIndex,entry){
				if(entry.tree_ver == entry.version){
					button_class="btn btn-primary";
				}else if(entry.version == version){
					button_class="btn btn-info";
				}else{
					button_class="btn btn-default";
				}
				html +='<div class="flag_option">';
				html +='<button type="button" class="' + button_class + '" data-toggle="popover" title="' + entry.writer + '의글" data-content="' + entry.update + '  ※' + entry.comment + '">';
				html += tree + '의 ' + entry.version + '번째 깃발';
				html +='</button>';
				html +='<button type="button" attribute="change" flag_version="' + entry.version + '" class="btn btn-warning btn-sm"><span class="glyphicon glyphicon-repeat" aria-hidden="true"></span> 전환</button>';
				html +='<button type="button" attribute="view" flag_version="' + entry.version + '" class="btn btn-warning btn-sm"><span class="glyphicon glyphicon-zoom-in" aria-hidden="true"></span> 보기</button>';
				html +='</div>';
				
			});
			$('#right').html(html);
			$('[data-toggle="popover"]').popover();
			$('[attribute="change"]').click(function(){
				var flag_version = $(this).attr("flag_version");
				var para = encodeURIComponent(tree);
				$.post('/CheckTree/option/change_ver.jsp',{tree:tree,b_user:b_user,flag_version:flag_version});
				alert(flag_version + "번쨰 깃발로 전환하였습니다");

				window.location='/CheckTree/board.jsp?tree=' + para +'&b_user=' +b_user;
			});
			$('[attribute="view"]').click(function(){
				var flag_version = $(this).attr("flag_version");
				var para = encodeURIComponent(tree);
				window.location='/CheckTree/board.jsp?tree=' + para +'&b_user=' +b_user +'&version=' + flag_version;

			});
		},"json");
	});
	$('#mypage').click(function(){
			$.post('/CheckTree/option/receive.jsp',{tree:tree,b_user:b_user},function(data){
				var html='<table id="request_table"></table>';
				$('#right').html(html);
				$('#request_table').bootstrapTable({
					data:data,
					height: 400,
					pagination: true,
					search: true,
					columns:[{
						field:'idx',
						title:'번호'
						},{
						field:'user',
						title:'작성자'
						},{
						field:'board_idx',
						title:'요청글번호'
						},{
						field:'title',
						title:'글제목'
						},{
						field:'type',
						title:'요청유형'
						},{
						field:'date',
						title:'작성날짜'
					}]
				}).on('click-row.bs.table', function (e, row, $element) {
          			$.post('/CheckTree/option/receive_board.jsp',{idx:row.idx,type:row.type,board_idx:row.board_idx}, function(data){
                       	$('#right').html(data);
      		     	});
				});	
			},"json");
		});	
	$('#my_rep').click(function(){
		var para = encodeURIComponent(tree);
		window.location='/Search/Repositores.jsp';
	});
});

function show_user(){
	var html='';
	$.post('/CheckTree/option/mem_json.jsp',{tree:tree,b_user:b_user},function(data){
		var user_id="";
		$.each(data,function(entryIndex,entry){
			if(entry.rank=='0'){
				user_id="label label-primary glyphicon glyphicon-home";
			}else if(entry.rank=='1'){
				user_id="label label-success glyphicon glyphicon-flag";
			}else if(entry.rank=='2'){
				user_id="label label-warning glyphicon glyphicon-user";
			}
			html+='<p><span class="' + user_id + '">' + entry.user + '</span></p>';				
		});
	$('#right').html(html);
	},"json");
}	
