   $(document).ready(function() {
		$.getJSON('jsontest.jsp',function(data){
		var html = '';
		var leaf_num;
        $.each(data, function(entryIndex, entry) {
			if(entry.branch==0){
				html += '<ul>';
				html += '<li class="collapsed"><input type="checkbox"><span idx=' + entry.idx+ '>' + entry.title + '</span><input type="hidden" id="idx' + entry.idx + '"' + ' value=' + entry.idx +'>';
			}
			if(entry.branch!=0 && entry.leaf==0){
				leaf_num = entry.leaf_num;
				html += '<ul>';
				html += '<li class="collapsed"><input type="checkbox"><span idx=' + entry.idx+ '>' + entry.title + '</span><input type="hidden" id="idx' + entry.idx + '"' + ' value=' + entry.idx +'>';
				if(leaf_num !=0){
					html += '<ul>';
				}else{
					html += '</ul>';
				}
			}
			if(entry.branch!=0 && entry.leaf!=0){
				html += '<li><input type="checkbox"><span idx=' + entry.idx+ '>' + entry.title + '</span><input type="hidden" id="idx' + entry.idx + '"' + ' value=' + entry.idx +'>';
				if(entry.leaf == leaf_num){
					html += '</ul></ul>';
				}
			}
		});	
		html += '</ul>';
		$('#tree').html(html);
       	$('#tree').tree({
            collapseUiIcon: 'ui-icon-plus',
            expandUiIcon: 'ui-icon-minus',             
            onCheck: {
                node: 'expand',
                ancestors: 'checkIfFull',
                ancestors: 'uncheck',
                descendants: 'check' 
            },
            onUncheck: {
                node: 'collapse',
                
            },
            select: function(event, element) {
               jidx = $(element).find('span.daredevel-tree-label:first').attr('idx');
               $.get('jsBoard.jsp',
                     {idx: $('#idx'+jidx).val()},
                     function(data){
                        $('#right').html(data);
          		     });
                    
            	}
            
        	});
  		});
	});
