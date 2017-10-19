//Filename: general-notice.main.views.js

define(['windmill', 'marionette', 'common/component/board.table.view', 'jquery.form', 'bootstrap-multiselect', 'datepicker', 'timepicker', 'validate_en'], function(App, Marionette, BoardTableView) {

    'use strict';

    console.log("[general-notice.table] load...");
  var token = $("meta[name='_csrf']").attr("content");
  var header = $("meta[name='_csrf_header']").attr("content");
    var ItemView = Marionette.ItemView.extend({
		tagName : 'tr',
		className : 'pointer',
		template : '#product-option-list-item-tpl',
		
		
	});
	
	var EmptyView = Marionette.ItemView.extend({
		tagName : 'tr',
		template : _.template("<td colspan=3>No data</td>")
	});
	
	var PopularSearchTableView = Marionette.CompositeView.extend({
		
		template : '#product-option-list-tpl',
		
		childView : ItemView,
		emptyView : EmptyView,
		
		childViewOptions : {template : '#product-option-list-item-tpl'},
		emptyViewOptions : {template : _.template("<td colspan=3>No search result</td>")},
		
		childViewContainer : '#product-option-list-container',
		
        show : function() {
            console.log("[Template.TableView] show()");
            this.render();
            App.popularSearchTable.show(this);
        },
        
		getData : function(page) {
			
			console.log("[PopularSearch.TableView] getData() page:"+page);
			
			var self = this;
			

			$.getJSON('/'+App.ctx+'/promotion/product-option-list', function(data) {
				self.collection = new Backbone.Collection(data);
				self.model = new Backbone.Model(data);
				console.log(JSON.stringify(data));
			}).success(function(){
				self.show();
				
			});
		}
	});
	
	
    var ItemView = Marionette.ItemView.extend({
		tagName : 'tr',
		className : 'pointer',
		template : '#search-recommend-list-item-tpl',
	});
	
	var EmptyView = Marionette.ItemView.extend({
		tagName : 'tr',
		template : _.template("<td colspan=7>No data</td>")
	});
	
	
	var SearchRecommendTableView = Marionette.CompositeView.extend({
		
		template : '#search-recommend-list-tpl',
		
		childView : ItemView,
		emptyView : EmptyView,
		
		childViewOptions : {template : '#search-recommend-list-item-tpl'},
		emptyViewOptions : {template : _.template("<td colspan=3>No search result</td>")},
		
		childViewContainer : '#search-recommend-list-container',
		
		events : {
			'click #product-option-edit-save' : 'updateItem',
		},
		
		updateItem : function() {
			console.log("[PopularSearch.InfoFormView] update()",this);
			var self = this;
			this.validate(function(){
				$('#search-recommend-info').ajaxForm();
				$('#search-recommend-info').ajaxSubmit({
					url : '/'+App.ctx+'/promotion/product-option/update?_csrf=' +token,
					type : 'GET',
					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		            success : function(data) {
		            	console.info("TTT : ", data);
		            	self.collection = new Backbone.Collection(data);
						self.model = new Backbone.Model(data);
						console.log(JSON.stringify(data))
		                showSuccess( "Succeed updating popular search information", function(){
		                	$('.modal[aria-hidden="false"]').modal('hide');
		                });
						$('#divResults').append('<table  border="1"><tr><td colspan="2" rowspan="11">' + " productId" + '</td></tr><tr><td width="118">' + "productId" + '</td><td width="186">' + "optionId" + '</td></tr></table>');
		                self.show();
		                
						
		               
		            },
		            error: function(data) {
		                showError(data);
		            }
				});
			});
			
			
			
		}, 
		
	    validate : function(callback) {
            console.log( "[PopularSearch.InfoFormView] validate()" , this.model);
        
            $( '#search-recommend-info').validate({
                rules : {
                	/*name: {required: true},
					rank: {required: true},*/
                },
                errorElement: 'span',
                errorClass: 'help-block',
                errorPlacement: function(error, element) {
                if(element.parent('.control-group' ).length)
                     error.insertAfter(element);
                else
                     error.insertAfter(element.closest( '.control-group'));
                },
               
                highlight: function (element, errorClass, validClass) {
                     $(element).closest( '.control-group' ).removeClass('success').addClass( 'has-error' );
                },
               
                unhighlight: function (element, errorClass, validClass) {
                     $(element).closest( '.control-group' ).removeClass('has-error').addClass( 'success' );
                },
              
                submitHandler: function() {                              
                    callback();
                    return false ;
                }
            });
        },
        
        show : function() {
            console.log("[Template.TableView] show()");
            this.render();
            App.searchRecommendTable.show(this);
        },
		getData : function(page) {
			
			console.log("[PopularSearch.TableView] getData() page:"+page);
			
			var self = this;
		
			$.getJSON('/'+App.ctx+'/promotion/product-option-list', function(data) {
				self.collection = new Backbone.Collection(data);
				self.model = new Backbone.Model(data);
				
				console.log(JSON.stringify(data));
			}).success(function(){
				self.show();
				
			});
		}
	});
	
	return {
		PopularSearchTableView : PopularSearchTableView,
		SearchRecommendTableView : SearchRecommendTableView
	};
});
