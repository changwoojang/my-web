/**
 * 
 */
(function() {
	$('.source-data .add-data').click( function() {
		var clone =  $('.source-data').find('tbody tr').clone(true);
		
		$.each(clone.find('input'), function(index, obj) {
			var value = obj.value;
			$(obj).replaceWith('<div>' + value + '</div>');
		});
		
		$('.target-data').find('tbody').append(clone);
	});
})();