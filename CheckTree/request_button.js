   $(document).ready(function(){
   		$('#button').click(function(){
			var propose_type = $(this).val();
			if(propose_type=="요청"){
				var result = confirm("요청 하시겠습니까?");
				if(result){
					var m_title = $('#main_title').prop('value');
					var data = CKEDITOR.instances['contents'].getData();
	    			$("span[idx="+idx+"]").html(m_title);   	
					$.post("propose.jsp",
					{idx:idx,title:m_title,data:data,r_type:r_type});			
				}else{
				//no
				}
			}else if(propose_type=="수정"){
				var result = confirm("수정 하시겠습니까?");
				if(result){
					var m_title = $('#main_title').prop('value');
					var data = CKEDITOR.instances['contents'].getData();
	    			$("span[idx="+idx+"]").html(m_title);   	
					$.post("request_update.jsp",
					{idx:idx,title:m_title,data:data});			
					alert("수정되었습니다.");
					var para = encodeURIComponent(tree);
					window.location='index.jsp?tree=' + para +'&b_user=' +b_user;
				}else{
				//no
				}
			}else if(propose_type=="적용"){
				if(type=="건의"){
					alert("건의는 적용이 불가능합니다");
				}else{
					var result = confirm("정말 적용 하시겠습니까?");
					if(result){
						var m_title = $('#main_title').prop('value');
						var data = CKEDITOR.instances['contents'].getData();
	    				$("span[idx="+idx+"]").html(m_title);   	
						$.post("receive_update.jsp",
						{idx:idx,title:m_title,data:data,board_idx:board_idx});			
						alert("적용 되었습니다.");
						var para = encodeURIComponent(tree);
						window.location='board.jsp?tree=' + para +'&b_user=' +b_user;
					}else{
						//
					}
				}
			}
		});
	});
