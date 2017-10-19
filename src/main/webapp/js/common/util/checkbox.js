/**
 * 테이블의 헤더에 있는 checkbox를 클릭했을때 하위 checkbox 전체 선택, 선택 해제 동작
 */
(function() {
	console.log('[checkbox] util loaded');
	
	$(document).on('click','.check-all', function(e) { 
		var table = $(e.target).parents('table');
		var status = $(this).prop('checked');
		var checkboxes = $(table).find(':checkbox').not('.check-all');
		
		if(status) {
			$.each(checkboxes, function(index, item){
				if(!$(item).prop('checked')) {
					$(item).prop('checked',true);
				}
			})	;		
		}
		else {
			$.each(checkboxes, function(index, item){
				$(item).prop('checked',false);
			});
		}
	});
	$(document).on('click','.check-channel-catchup', function(e) { 
		var table = $(e.target).parents('table');
		var status = $(this).prop('checked');
		var checkboxes = $(table).find('.check-channel-catchup');
		
		if(status) {
			$.each(checkboxes, function(index, item){
				if(item.id == "targetChannel"){
					$.each(checkboxes, function(findCatchupIndex, findCatchupItem ){
						if(findCatchupItem.id == "targetCatchup"){
							$(findCatchupItem).prop('checked',true);	
						}
					});
						
				}else if(item.id == "targetCatchup"){
					$.each(checkboxes, function(findChannelIndex, findChannelItem){
						if(findChannelItem.id == "targetChannel"){
							$(findChannelItem).prop('checked',true);	
						}
					});			
				}
			});		
		}
		else {
			$.each(checkboxes, function(index, item){
				if(item.id == "targetChannel"){
					$.each(checkboxes, function(findCatchupIndex, findCatchupItem){
						if(findCatchupItem.id == "targetCatchup"){
							$(findCatchupItem).prop('checked',false);	
						}
					});
						
				}else if(item.id == "targetCatchup"){
					$.each(checkboxes, function(findChannelIndex, findChannelItem){
						if(findChannelItem.id == "targetChannel"){
							$(findChannelItem).prop('checked',false);	
						}
					});			
				}
			});		
		}
	});
})();