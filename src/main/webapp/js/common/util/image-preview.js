/**
 * 
 */
define(['lib/load-image/load-image'], function(loadImage){
	'use strict';
	
	$(document).on('click', '.image-upload', function(e) {
		var input = $(e.target).parents('.thumbnail').find('input')[0] || $('input[type=file]')[0];
		$(input).trigger('click');
	});
	
	$(document).on('change', 'input[type=file]', function(e) {
		loadImage(
			e.target.files[0],
			function (img) {
				if ( $(e.target).parents('.thumbnail').find('img')[0]){
					$(e.target).parents('.thumbnail').find('img').remove();
					$(img).prop('class','list-group-image').insertBefore($(e.target).parents('.thumbnail').find('.caption'));
				} else {
					$('.thumbnail').find('img').remove();
					$(img).prop('class','list-group-image').insertBefore($('.caption'));
				}
			}
		);
	});
});
