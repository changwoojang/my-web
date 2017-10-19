(function() {

	//*******************************************
	/*	INPUT APPEND
	/********************************************/

	$(document).on('keypress', 'form.input-append', function(e) { 
		if ( e.which == 13 ) {
			e.preventDefault();
		}
	});

	$(document).on('click', '.input-group-appendable .delete-self', function(e) {
		console.log('input remove');
		$(this).parents('.input-group-appendable').remove();
	});
	
	$(document).on('click', '.input-group-appendable-name .delete-self', function(e) {
		console.log('input remove');
		$(this).parents('.input-group-appendable-name').remove();
	});
	$(document).on('click', '.input-group-appendable-vod-list .delete-self', function(e) {
		console.log('input remove');
		$(this).parents('.input-group-appendable-vod-list').remove();
	});
	$(document).on('click', '.input-group-appendable-subscription-list .delete-self', function(e) {
		console.log('input remove');
		$(this).parents('.input-group-appendable-subscription-list').remove();
	});
	$(document).on('click', '.input-group-appendable-desc .delete-self', function(e) {
		console.log('input remove');
		$(this).parents('.input-group-appendable-desc').remove();
	});
	
	$(document).on('click', '.input-group-appendable-sdesc .delete-self', function(e) {
		console.log('input remove');
		$(this).parents('.input-group-appendable-sdesc').remove();
	});
	
	$(document).on('click', '.input-group-appendable-deregister-desc .delete-self', function(e) {
		console.log('input remove');
		$(this).parents('.input-group-appendable-deregister-desc').remove();
	});
	
	$(document).on('click', '.input-group-appendable .add-more', function(e) { 
		
		$wrapper = $(this).parents('.input-appendable-wrapper');
		$lastItem = $wrapper.find('.input-group-appendable').last(); 
		$newInput = $lastItem.clone(true);

		// change attribute for new item
		$count = $wrapper.find('#count').val();
		
		$count++;
		// change text input and the button
		//$newInput.attr('id', 'input-group-appendable' + $count);
		/*$newInput.find('input[type="text"]').attr({
			id: "linkCategoryPath",
			name: "linkCategoryPath"
		});*/

		//$newInput.find('.btn-append').attr('id', 'btn' + $count);
		$newInput.appendTo($wrapper);
		//change the previous button to remove
		$lastItem.find('.btn-append')
		.removeClass('add-more btn-primary')
		.addClass('delete-self btn-danger')
		.attr('id', 'minus-btn')
		.text('-')
		.off()
		.on('click', function(){
			$(this).parents('.input-group-appendable').remove();
		});
		$lastItem.find('input[type="text"]').val('');
		$wrapper.find('#count').val($count);
	

	});
	$(document).on('click', '.input-group-appendable-deregister-desc .add-more', function(e) { 
		
		$wrapper = $(this).parents('.input-appendable-wrapper-deregister-desc');
		$lastItem = $wrapper.find('.input-group-appendable-deregister-desc').last(); 
		$newInput = $lastItem.clone(true);

		// change attribute for new item
		$count = $wrapper.find('#count').val();
		$count++;
		$newInput.appendTo($wrapper);
		
		//change the previous button to remove
		$lastItem.find('.btn-append')
		.removeClass('add-more btn-primary')
		.addClass('delete-self btn-danger')
		.attr('id', 'minus-btn')
		.text('-')
		.off()
		.on('click', function(){
			$(this).parents('.input-group-appendable-deregister-dsec').remove();
		});
		$lastItem.find('input[type="text"]').val('');
		$lastItem.find('input[type="text"]').attr('readonly',false);
		$wrapper.find('#count').val($count);
		

	});
	$(document).on('click', '.input-group-appendable-sdesc .add-more', function(e) { 
		
		$wrapper = $(this).parents('.input-appendable-wrapper-sdesc');
		$lastItem = $wrapper.find('.input-group-appendable-sdesc').last(); 
		$newInput = $lastItem.clone(true);

		// change attribute for new item
		$count = $wrapper.find('#count').val();
		$count++;

		// change text input and the button
		//$newInput.attr('id', 'input-group-appendable' + $count);
		/*$newInput.find('input[type="text"]').attr({
			id: "linkCategoryPath",
			name: "linkCategoryPath"
		});*/


		//$newInput.find('.btn-append').attr('id', 'btn' + $count);
		$newInput.appendTo($wrapper);
		//change the previous button to remove
		$lastItem.find('.btn-append')
		.removeClass('add-more btn-primary')
		.addClass('delete-self btn-danger')
		.attr('id', 'minus-btn')
		.text('-')
		.off()
		.on('click', function(){
			$(this).parents('.input-group-appendable-sdsec').remove();
		});
		$lastItem.find('input[type="text"]').val('');
//			if(lastItem.find('input[type="text]') != null)
		$lastItem.find('input[type="text"]').attr('readonly',false);
		$wrapper.find('#count').val($count);
		

	});
	$(document).on('click', '.input-group-appendable-name .add-more', function(e) { 
		
		$wrapper = $(this).parents('.input-appendable-wrapper-name');
		$lastItem = $wrapper.find('.input-group-appendable-name').last(); 
		$newInput = $lastItem.clone(true);

		// change attribute for new item
		$count = $wrapper.find('#count').val();
		$count++;

		// change text input and the button
		//$newInput.attr('id', 'input-group-appendable' + $count);
		/*$newInput.find('input[type="text"]').attr({
			id: "linkCategoryPath",
			name: "linkCategoryPath"
		});*/


		//$newInput.find('.btn-append').attr('id', 'btn' + $count);
		$newInput.appendTo($wrapper);
		//change the previous button to remove
		$lastItem.find('.btn-append')
		.removeClass('add-more btn-primary')
		.addClass('delete-self btn-danger')
		.attr('id', 'minus-btn')
		.text('-')
		.off()
		.on('click', function(){
			$(this).parents('.input-group-appendable-name').remove();
		});
		$lastItem.find('input[type="text"]').val('');
		if($lastItem.find('input[type="text"]').val() != null )
			$lastItem.find('input[type="text"]').attr('readonly',false);
		$wrapper.find('#count').val($count);
		

	});
	
	$(document).on('click', '.input-group-appendable-desc .add-more', function(e) { 
		
		$wrapper = $(this).parents('.input-appendable-wrapper-desc');
		$lastItem = $wrapper.find('.input-group-appendable-desc').last(); 
		$newInput = $lastItem.clone(true);

		// change attribute for new item
		$count = $wrapper.find('#count').val();
		$count++;

		// change text input and the button
		//$newInput.attr('id', 'input-group-appendable' + $count);
		/*$newInput.find('input[type="text"]').attr({
			id: "linkCategoryPath",
			name: "linkCategoryPath"
		});*/

		//$newInput.find('.btn-append').attr('id', 'btn' + $count);
		$newInput.appendTo($wrapper);
		//change the previous button to remove
		$lastItem.find('.btn-append')
		.removeClass('add-more btn-primary')
		.addClass('delete-self btn-danger')
		.attr('id', 'minus-btn')
		.text('-')
		.off()
		.on('click', function(){
			$(this).parents('.input-group-appendable-desc').remove();
		});
		$lastItem.find('input[type="text"]').val('');
		$lastItem.find('textarea').val('');
		$lastItem.find('input[type="text"]').attr('readonly',false);
		$wrapper.find('#count').val($count);


	});
	

	$(document).on('click', '.input-group-appendable-subscription-list .add-more', function(e) { 
		
		$wrapper = $(this).parents('.input-appendable-wrapper-subscription-list');
		$lastItem = $wrapper.find('.input-group-appendable-subscription-list').last(); 
		$newInput = $lastItem.clone(true);

		// change attribute for new item
		$count = $wrapper.find('#count').val();
		$count++;
		
		$newInput.appendTo($wrapper);
		//change the previous button to remove
		$lastItem.find('.btn-append')
		.removeClass('add-more btn-primary')
		.addClass('delete-self btn-danger')
		.attr('id', 'minus-btn')
		.text('-')
		.off()
		.on('click', function(){
			$(this).parents('.input-group-appendable-subscription-list').remove();
		});
		$lastItem.find('input[type="text"]').val('');
		$lastItem.find('textarea').val('');
		$lastItem.find('input[type="text"]').attr('readonly',false);
		$wrapper.find('#count').val($count);
	});
	
	$(document).on('click', '.input-group-appendable-vod-list .add-more', function(e) { 
		
		$wrapper = $(this).parents('.input-appendable-wrapper-vod-list');
		$lastItem = $wrapper.find('.input-group-appendable-vod-list').last(); 
		$newInput = $lastItem.clone(true);

		// change attribute for new item
		$count = $wrapper.find('#count').val();
		$count++;

		// change text input and the button
		//$newInput.attr('id', 'input-group-appendable' + $count);
		/*$newInput.find('input[type="text"]').attr({
			id: "linkCategoryPath",
			name: "linkCategoryPath"
		});*/

		//$newInput.find('.btn-append').attr('id', 'btn' + $count);
		$newInput.appendTo($wrapper);
		//change the previous button to remove
		$lastItem.find('.btn-append')
		.removeClass('add-more btn-primary')
		.addClass('delete-self btn-danger')
		.attr('id', 'minus-btn')
		.text('-')
		.off()
		.on('click', function(){
			$(this).parents('.input-group-appendable-vod-list').remove();
		});
		$lastItem.find('input[type="text"]').val('');
		$lastItem.find('textarea').val('');
		$lastItem.find('input[type="text"]').attr('readonly',false);
		$wrapper.find('#count').val($count);


	});
	
	
})(); // end ready function

