//Filename: windmill.js

define(['marionette', 'backbone', 'handlebars', 'underscore', 'common/util/loading'], function(Marionette, Backbone, Handlebars, _) {

	"use strict";

	console.log("[windmill] load...");

	var app = new Marionette.Application();
	
	app.ctx = 'web-ui';
	
	app.lang = 'eng';

	// Marionette expects "templateId" to be the ID of a DOM element.
	// But with RequireJS, templateId is actually the full text of the template.
	// https://github.com/marionettejs/backbone.marionette/wiki/Using-marionette-with-requirejs
	/*
    Marionette.TemplateCache.prototype.loadTemplate = function(templateId) {
        // console.log("[windmill] marionette templateCache : load template");
        var template = templateId;
        // Make sure we have a template before trying to compile it
        if (!template || template.length === 0) {
            var msg = "Could not find template: '" + templateId + "'";
            var err = new Error(msg);
            err.name = "NoTemplateError";
            throw err;
        }
        return template;
    };

    */
    
    // Handlebars 사용
    // https://github.com/marionettejs/backbone.marionette/wiki/Using-handlebars-templates-with-marionette
    Marionette.TemplateCache.prototype.compileTemplate = function(rawTemplate) {
        // console.log("[windmill] marionette templateCache : handlebar compile");
        return Handlebars.compile(rawTemplate);
    };

    // 템플릿 변수 사용 시, 기호를 {{ }} 로 변경
    // override default global templates to use MUSTACHE style {{ name }} instead of ERB
    _.templateSettings = {
        interpolate: /\{\{\=(.+?)\}\}/gim,
        evaluate: /\{\{(.+?)\}\}/gim,
        escape: /\{\}\-(.+?)\}\}/gim
    };
    
    Handlebars.registerHelper('pagination', function(currentPage, startPage, endPage, totalPage, options) {
		var context = {
			startFromFirstPage : false,
			pages : [],
			endAtLastPage : false,
		};
		if (startPage === 1) {
			context.startFromFirstPage = true;
		}
		for ( var i = startPage; i <= endPage; i++) {
			context.pages.push({
				page : i,
				isCurrent : i === currentPage,
			});
		}
		if (endPage === totalPage) {
			context.endAtLastPage = true;
		}
	
		return options.fn(context);
		
	});
	// Display Modal
	window.showSuccess = function(message, callback) {
		swal({
			title: 'Success',
			text: message,
			type: 'success'
		}, function() {
			callback();
		});
	};
	
	window.showError = function(data) {
		swal({
			title: 'Fail',
			text: data.responseJSON.message,
			type: 'error'
		});
	};
	window.showErrorText = function(data) {
		swal({
			title: 'Fail',
			text: data,
			type: 'error'
		});
	};
	window.showErrorMessage = function(data) {
		if(data.responseJSON.exception.split(":")[1] !=null){
			swal({
				title: 'Fail',
				text: data.responseJSON.exception.split(":")[1],
				type: 'error'
			});
		}else{
			swal({
				title: 'Fail',
				text: data.responseJSON.exception,
				type: 'error'
			});
		}
	};
	window.showConfirm = function(message, callback) {
		swal({
			title: '',
			text: message,
			type: 'warning',
			showCancelButton: true
		}, function(){
			callback();
		});
	};
	
	window.showInfo = function(message) {
		swal({
			title: '',
			text: message,
			type: 'info',
			showCancelButton: false
		});
	};
    window.Handlebars.registerHelper('select', function( value, options ){
	    var $el = $('<select />').html( options.fn(this) );
	    $el.find('[value=' + value + ']').attr({'selected':'selected'});
	    return $el.html();
	});
	
 // ex ) {{#compare categoryType "program" operator="==="}}
	Handlebars.registerHelper('compare', function(lvalue, rvalue, options) {
		
	    if (arguments.length < 3)
	        throw new Error("Handlerbars Helper 'compare' needs 2 parameters");

	    var operator = options.hash.operator || "==";

	    var operators = {
	        '==':       function(l,r) { return l == r; },
	        '===':      function(l,r) { return l === r; },
	        '!=':       function(l,r) { return l != r; },
	        '<':        function(l,r) { return l < r; },
	        '>':        function(l,r) { return l > r; },
	        '<=':       function(l,r) { return l <= r; },
	        '>=':       function(l,r) { return l >= r; },
	        'typeof':   function(l,r) { return typeof l == r; }
	    };

	    if (!operators[operator])
	        throw new Error("Handlerbars Helper 'compare' doesn't know the operator "+operator);

	    var result = operators[operator](lvalue,rvalue);

	    if( result ) {
	        return options.fn(this);
	    } else {
	        return options.inverse(this);
	    }

	});
	
	// Bootstrap Modal Dialog 용 Region
	// http://twitter.github.com/bootstrap/javascript.html#modals
	// http://lostechies.com/derickbailey/2012/04/17/managing-a-modal-dialog-with-backbone-and-marionette/
	var ModalRegion = Marionette.Region.extend({

		el: '#modal',

		onShow: function(view) {
			// hidden - Bootstrap Modal event fired when the modal has finished being hidden from the user
			console.log("showModal");
			this.$el.on('hidden', this.close);
			view.on('close', this.hideModal, this);
			this.showModal(view);
		},

		showModal: function(view) {
			this.$el.modal('show');
		},

		hideModal: function() {
			this.$el.modal('hide');
		}
	});

	// Region 선언
	app.addRegions({
		modal: ModalRegion
	});
	
	// Global Ajax request callback config
	$(document).ajaxStart(function() {
		loading.show();
	});
	
	$(document).ajaxStop(function() {
		loading.hide();
	});
		
	return app;
});
