   $(document).ready(function(){
   		$('#button').click(function(){
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
		});
	});
