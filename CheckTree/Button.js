   $(document).ready(function() {
   		$('#button').click(function(){
			var result = confirm("정말 적용 하시겠습니까?");
			if(result){
				var m_title = $('input[type="text"]').prop('value');
				var data = CKEDITOR.instances['contents'].getData();
	    		$("span[idx="+idx+"]").html(m_title);   	
				$.post("update.jsp",
				{idx:idx,title:m_title,data:data});			
			}else{
				//no
			}
		});
	});
