$(document).ready(function(){
	var is_ok="-1";
	var check;
	$.post('requestor.jsp',{tree:tree,b_user:b_user},function(data){
		$.each(data,function(entryIndex,entry){
			is_ok=entry.rank;	
		});
		if(is_ok == "2"){
			check='<input type="checkbox" name="my-checkbox" checked>';
		}else{
			check='<input type="checkbox" name="my-checkbox">';
		}
		var html='<ul class="nav nav-pills nav-stacked">';
		html +='<li class="active"><a>관심항목' + check + '</a></li>';
		html +='</ul>';
		var list='';
		list +='<ul class="nav nav-pills nav-statcked" id="option_ul">';
		list +='<li class="active"><a href="#" id="mem_list" class="option_list">참여중인인원</a></li>';
		list +='<li class="active"><a href="#" id="request" class="option_list">요청하기</a></li>';
		list +='<li class="active"><a href="#" id="mypage" class="option_list">마이페이지</a></li>';
		list +='<li class="active"><a href="#" id="flag_list" class="option_list">깃발항목</a></li>';
		list +='</ul>'
		$('#option').html(html);
		$('#option').append(list);
		$("[name='my-checkbox']").bootstrapSwitch();	
		if(is_ok !=2){
		$('#option_ul').hide();
		}
		$('input[name="my-checkbox"]').on('switchChange.bootstrapSwitch', function(event, state) {
			if(state==true){
				$('#option_ul').show();
				$.post('adj.jsp',{tree:tree,b_user:b_user});
			}else{
				$('#option_ul').hide();
				$.post('adj.jsp',{tree:tree,b_user:b_user});
			}
		});
		$('#mem_list').click(function(){
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
		});
		$('#request').click(function(){
			var button='<div id="req_button">';
			button +='<button type="button" id="modified" class="btn btn-success" aria-label="Left Align"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span><strong>수정요청</strong></button>';
			button +='<button type="button" id="propose" class="btn btn-info" aria-label="Left Align"><span class="glyphicon glyphicon-phone-alt" aria-hidden="true"></span><strong>건의</strong></button>';
			button +='</div>';
			$('#right').prepend(button);
			
			$('#modified').click(function(){
               $.post('request_board.jsp',
                     {idx:jidx},
                     function(data){
                        $('#right').html(data);
          		     });
			});
			$('#propose').click(function(){
			   var r_type="propose";
               $.post('request_board.jsp',
                     {idx:jidx,r_type:r_type},
                     function(data){
                        $('#right').html(data);
          		     });
				});
			});

			$('#flag_list').click(function(){
			var html='';
			if(version == null){
				alert(version);
			}	
			$.post('list_flag.jsp',{tree:tree,b_user:b_user}, function(data){
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
					html +='<button type="button" attribute="view" flag_version="' + entry.version + '" class="btn btn-warning btn-sm"><span class="glyphicon glyphicon-zoom-in" aria-hidden="true"></span> 보기</button>';
					html +='</div>';
					
				});	
				$('#right').html(html);
				$('[data-toggle="popover"]').popover();
				$('[attribute="view"]').click(function(){
					var flag_version = $(this).attr("flag_version");
					var para = encodeURIComponent(tree);
					window.location='index.jsp?tree=' + para +'&b_user=' +b_user +'&version=' + flag_version;
				});
			},"json");
		});
		$('#mypage').click(function(){
				$.post('mypage.jsp',{tree:tree,b_user:b_user},function(data){
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
               			$.post('request_list.jsp',{idx:row.idx}, function(data){
                        	$('#right').html(data);
          		     	});
					});	
				},"json");
			});
	},"json");
});
