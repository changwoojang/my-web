// Filename : login.js
// Description : 로그인 화면 Validation 체크

require.config({

	baseUrl : '/web-ui/js',

	paths : {
		'jquery' : 'lib/jquery/jquery.min',
		'bootstrap' : 'lib/bootstrap/js/bootstrap.min',
		'validate' : 'lib/jquery-validate/jquery.validate.min'
	},

	shim : {
		bootstrap : {
			deps : [ 'jquery' ]
		},
		validate : {
			deps : [ 'jquery' ]
		}
	}
});

define([ 'jquery', 'bootstrap', 'validate' ], function($) {

	// form validation
	$('#login-form').validate({

		rules : {
			j_username : {
				required : true,
				minlength : 3
			},
			j_password : {
				required : true,
				// minlength : 5
			},
			answer : {
				required : true,
				// minlength : 5
			},
		},

		messages : {
			j_username : {
				required : "Input ID.",
				minlength : "[ID] Input at least three words"
			},
			j_password : {
				required : "Input password",
				// minlength : "최소 5자리 이상 입력하세요."
			},
			answer : {
				required : "Input Captcha",
				// minlength : 5
			},
		},

		highlight : function(element, errorClass, validClass) {
			$(element).parents('.form-group').addClass('has-error');
		},

		unhighlight : function(element, errorClass, validClass) {
			$(element).parents('.form-group').removeClass('has-error');
		},

		errorContainer : $('#form-error'),
		errorLabelContainer : $('div', $('#form-error')),
	});

	// message
	$('.alert').alert();
});