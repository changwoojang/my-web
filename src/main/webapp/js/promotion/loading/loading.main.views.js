//Filename: iframe.main.views.js

define(['windmill', 'marionette', 'common/component/board.table.view', 'jquery.form', 'bootstrap-multiselect', 'datepicker', 'timepicker',  'common/util/iframe-image-preview'], function(App, Marionette, BoardTableView) {

    'use strict';

    console.log("[loading.main.views] load...");

	var LoadingTableView = BoardTableView.extend({
		
		template : '#loading-list-tpl',
		
		childViewOptions : {template : '#loading-list-item-tpl'},
		emptyViewOptions : {template : _.template("<td colspan=4>No data</td>")},
		
		childViewContainer : '#loading-list-container',
			
		getData : function(page) {
			console.log("[Loading.LoadingTableView] getData() ");
			
			self = this;
			$.getJSON('/'+App.ctx+'/promotion/loading', function(data) {
				self.collection = new Backbone.Collection(data);
	
				console.log(JSON.stringify(data));
			}).success(function(){
				self.show();
			});

		}
	});

	return {
		IFrameTableView : LoadingTableView
	};
});
