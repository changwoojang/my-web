/**
 * @Author hm.song 
 */

function cleanForm(formElement) {

	if ( !$(formElement).is('form') ) {
		console.error("[form-cleaner] Not Cleaned - Only form element allowed");
		return false;
	} 

	var _form = $(formElement);

	// text input, textarea 공백설정
	var inputs = _form.find('input[type=text], textarea');
	if ( inputs.length > 0 ) {
		$.each(inputs, function(index, item) {
			$(item).val('');
		});
	}

	// timepicker 0:00 값으로 설정
	var timePickers = _form.find('.timepicker');
	if ( timePickers.length > 0 ) {
		$.each(timePickers, function(index, item) {
			$(item).timepicker({
				minuteStep: 5,
				showInputs: false,
				showMeridian: false,
				defaultTime: "0:00",
				disableMousewheel : true
			});	
			$(item).val('0:00');
		});
	}

	var datePickers = _form.find('.datepicker');
	if ( datePickers.length > 0 ) {
		$.each(datePickers, function(idex, item) {
			$(item).datepicker({
				format: 'yyyy.mm.dd'
			});
		});
	}

	// Select 첫번째 옵션 선택
	var selects = _form.find('select');
	if ( selects.length > 0 ) {
		$.each(selects, function(index, item) {
			var firstOption = $(item).find('option')[0];
			$(firstOption).prop('selected', true);
		});
	}

	// Checkbox 선택 해제
	var checkboxes = _form.find('input[type=checkbox]');
	if ( checkboxes.length > 0 ) {
		$.each(checkboxes, function(index, item) {
			$(item).prop('checked', false);
		});
	}

	// Radio 선택 해제
	var radios = _form.find('input[type=radio]');
	if ( radios.legnth > 0 ) {
		$.each(radios, function(index, item) {
			$(item).prop('checked', false);
		});
	}
}