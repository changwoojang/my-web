// Filename : main.js
// Description : 

require.config({

	baseUrl : '/web-ui/js',

	paths : {
		'jquery' : 'lib/jquery/jquery.min',
		'jquery.form' : 'lib/jquery.form/jquery.form',
		'bootstrap' : 'lib/bootstrap/js/bootstrap.min',
		'bootstrap-editable' : 'lib/bootstrap-editable/js/bootstrap-editable',
		'backbone' : 'lib/backbone/backbone',
		'marionette' : 'lib/backbone.marionette/backbone.marionette',
		'backbone.wreqr' : 'lib/backbone.wreqr/backbone.wreqr',
		'underscore' : 'lib/underscore/underscore',
		'handlebars' : 'lib/handlebars/handlebars.min',
		'bootstrap-multiselect' : 'lib/bootstrap-multiselect/bootstrap-multiselect',
		'nicetree' : 'lib/nicetree/js/jquery-tree-1.0',
		'datepicker': 'lib/bootstrap/js/bootstrap-datepicker',
		'timepicker': 'lib/bootstrap/js/bootstrap-timepicker',
		'dynatree': 'lib/dynatree/jquery.dynatree',
		'load-image': 'lib/load-image/load-image',
		'text': 'lib/text/text',
		'context-menu' : 'lib/jquery-contextmenu/jquery.contextMenu',
		'jquery.ui.position' : 'lib/jquery-contextmenu/jquery.ui.position',
		'validate' : 'lib/jquery-validate/jquery.validate.min',
		'validate_add' : 'lib/jquery-validate/additional-methods.min',
		'loading' : 'common/util/loading',
	    'jquery.nestable' : 'lib/jquery-nestable/jquery.nestable',
	    'sweet-alert' : 'lib/sweet-alert/sweet-alert',
	    'validate_en' : 'lib/jquery-validate/message_en',
	    'datatable-bootstrap' : 'lib/datatable/jquery.dataTables.bootstrap',
	    'datatable' : 'lib/datatable/jquery.dataTables.min',
	},

	shim : {
		
		bootstrap : {
			deps : [ 'jquery' ]
		},
		
		'bootstrap-editable' : {
			deps : ['bootstrap']
		},
		
		backbone : {
			exports : 'Backbone',
			deps : [ 'jquery', 'underscore' ]
		},

		marionette : {
			exports : 'Marionette',
			deps : [ 'backbone', 'handlebars' ]
		},
		
		handlebars: {
            exports: 'Handlebars',
        },
        
		'jquery.form' : {
			deps : ['jquery']
		},

		windmill : {
			deps : [ 'jquery', 'bootstrap' ]
		},
		
		'bootstrap-multiselect' : {
			deps : [ 'bootstrap' ]
		},
		
		'nicetree' : {
			deps : ['jquery']
		},
		
		dynatree: {
            deps: ['lib/jquery-ui/jquery-ui', 'lib/jquery-cookie/jquery.cookie']
        },
        
		datepicker : {
			deps : [ 'bootstrap' ]
		},

		timepicker : {
			deps : [ 'bootstrap' ]
		},

		'load-image': {
			exports: 'loadImage',
			depth: ['jquery']
		},
		
		validate : {
			deps : [ 'jquery' ]
		},
        validate_en : {
            deps : ['jquery', 'validate', 'validate_add']
        },
        'validate_add' :{
        	deps : [ 'jquery' ]
        },
		
		'datatable-bootstrap' : {
			deps : ['datatable']
		}

		
	}
});

define([ 'jquery', 'bootstrap', 'windmill','nicetree', 'sweet-alert'], function($) {

	'use strict';

	console.log("[main] load...");
	
	// toggle function
	$.fn.clickToggle = function(f1, f2) {
		return this.each(function() {
			var clicked = false;
			$(this).bind('click', function() {
				if (clicked) {
					clicked = false;
					return f2.apply(this, arguments);
				}
				clicked = true;
				return f1.apply(this, arguments);
			});
		});

	};
	
	/* set minimum height for the left content wrapper, demo purpose only  */
	if( $('.demo-only-page-blank').length > 0 ) {
		$('.content-wrapper').css('min-height', $('.wrapper').outerHeight(true) - $('.top-bar').outerHeight(true));
	}
	
});
