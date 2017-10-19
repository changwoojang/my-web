
define(['lib/load-image/load-image'], function(loadImage){
	'use strict';
	
	$(document).on('click', '.image-upload', function() {
		console.log('[iframe-image-preview] upload()');
		$(this).parents('.item').find('input[type=file]').trigger('click');
	});

	$(document).on('change', 'input[type=file]', function(e) {
		var self = $(e.target);
		loadImage(
				e.target.files[0],
				function (img) {
					self.parents('.item').find('img').remove();
					$(img).prop('class','list-group-image').insertBefore(self.parents('.item').find('.caption'));
				}
		);
	});
});
