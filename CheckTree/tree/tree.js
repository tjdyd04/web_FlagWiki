   $(document).ready(function() {
		$.post('/CheckTree/tree/tree_json.jsp',{tree:tree,b_user:b_user},function(data){
		var html = '';
		var leaf_num;
        $.each(data, function(entryIndex, entry) {
			if(entry.branch==0){
				html += '<ul>';
				html += '<li class="collapsed"><input type="checkbox"><span idx=' + entry.idx+ '>' + entry.title + '</span><input type="hidden" id="idx' + entry.idx + '"' + ' value=' + entry.idx +'>';
				html += '<button type="button" option="add" class="btn btn-default btn-xs" num="' + entry.branch_num + '" Btype="tree" Btitle="' + entry.title + '" idx="' + entry.idx + '"><span class="glyphicon glyphicon-chevron-down"></span></button>';

			}
			if(entry.branch!=0 && entry.leaf==0){
				leaf_num = entry.leaf_num;
				html += '<ul>';
				html += '<li class="collapsed"><input type="checkbox"><span idx=' + entry.idx+ '>' + entry.title + '</span><input type="hidden" id="idx' + entry.idx + '"' + ' value=' + entry.idx +'>';
				html += '<button type="button" option="add" class="btn btn-default btn-xs" num="' + entry.leaf_num + '" Btype="branch" Btitle="' + entry.title + '" idx="' + entry.idx + '" Bnum="' + entry.branch + '"><span class="glyphicon glyphicon-chevron-down"></span></button>';
				html += '<button type="button" option="delete" class="btn btn-default btn-xs" Btype="branch" idx="' + entry.idx + '"><span class="glyphicon glyphicon-remove"></span></button>';
				if(leaf_num !=0){
					html += '<ul>';
				}else{
					html += '</ul>';
				}
			}
			if(entry.branch!=0 && entry.leaf!=0){
				html += '<li><input type="checkbox"><span idx=' + entry.idx+ '>' + entry.title + '</span><input type="hidden" id="idx' + entry.idx + '"' + ' value=' + entry.idx +'>';

				html += '<button type="button" option="delete" class="btn btn-default btn-xs" idx="' + entry.idx + '"><span class="glyphicon glyphicon-remove"></span></button>';
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
               $.post('/CheckTree/board/js_board.jsp',
                     {idx: $('#idx'+jidx).val()},
                     function(data){
                        $('#right').html(data);
          		     });
            	}
        	});
		$('#tree button[option=add]').click(function(){
				var type = $(this).attr('Btype');
				var num = $(this).attr('num');
				var Bnum = $(this).attr('Bnum');
				var Btitle =$(this).attr('Btitle');
				var idx = $(this).attr('idx');
				html = '<span>선택항목 : ' + Btitle + '</span>';
				html += '<input type="text" class="form-control" placeholder="추가하기" id="AddTree">'; 
				html += '<input type="button" class="btn btn-default" id="AddButton" value="추가">';
				$('#input').html(html).toggle();
				$('#AddButton').bind("click",function(){
					var result = confirm("추가?");
					if(result){
						var AddTitle = $('#AddTree').prop('value');
						$.post("/CheckTree/tree/insert.jsp",
						{idx:idx,AddTitle:AddTitle,num:num,type:type,Bnum:Bnum,tree:tree,b_user:b_user},function(){
						var para = encodeURIComponent(tree);
						window.location='/CheckTree/board.jsp?tree=' + para +'&b_user=' +b_user;
						});
					}else{
						//no
					}
				});
			});

		$('#tree button[option=delete]').click(function(){
			var idx = $(this).attr('idx');
			var type = $(this).attr('Btype');
			var result = confirm("정말 삭제 하시겠습니까?");
			if(result){
				$.post("/CheckTree/tree/delete.jsp",
				{idx:idx,type:type},function(){
				var para = encodeURIComponent(tree);
				window.location='/CheckTree/board.jsp?tree=' + para +'&b_user=' +b_user;
				});
			}else{
				//no
			}
		});
  		},"json");
	});
