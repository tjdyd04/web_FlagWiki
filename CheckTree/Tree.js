   $(document).ready(function() {
		$.getJSON('jsontest.jsp',function(data){
		var html = '';
		var leaf_num;
        $.each(data, function(entryIndex, entry) {
			if(entry.branch==0){
				html += '<ul>';
				html += '<li class="collapsed"><input type="checkbox"><span idx=' + entry.idx+ '>' + entry.title + '</span><input type="hidden" id="idx' + entry.idx + '"' + ' value=' + entry.idx +'>';
				html += '<button type="button"  class="btn btn-default btn-xs" num="' + entry.branch_num + '" Btype="tree" Btitle="' + entry.title + '"><span class="glyphicon glyphicon-chevron-down"></span></button>';
			}
			if(entry.branch!=0 && entry.leaf==0){
				leaf_num = entry.leaf_num;
				html += '<ul>';
				html += '<li class="collapsed"><input type="checkbox"><span idx=' + entry.idx+ '>' + entry.title + '</span><input type="hidden" id="idx' + entry.idx + '"' + ' value=' + entry.idx +'>';
				html += '<button type="button"  class="btn btn-default btn-xs" num="' + entry.leaf_num + '" Btype="branch" Btitle="' + entry.title + '"><span class="glyphicon glyphicon-chevron-down"></span></button>';
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
               $.post('jsBoard.jsp',
                     {idx: $('#idx'+jidx).val()},
                     function(data){
                        $('#right').html(data);
          		     });
            	}
        	});
			
		$('#tree button').click(function(){
			var type = $(this).attr('Btype');
			var num = $(this).attr('num');
			var title =$(this).attr('Btitle');
			html = '<span>선택항목 : ' + title + '</span>';
			html += '<input type="text" class="form-control" placeholder="추가하기" id="AddTree">'; 
			html += '<input type="button" class="btn default" id="AddButton" value="추가">';
			$('#input').html(html).toggle();

			});
  		});
	});