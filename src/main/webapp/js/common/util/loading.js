/**
 * @author : hm.song 
 */

var loading = (function() {
	var show = function() {
		$('.loading').show();
	};
	
	var hide = function() {
		$('.loading').hide();
	};
	
	return  {
		show : show,
		hide : hide
	};
})();
