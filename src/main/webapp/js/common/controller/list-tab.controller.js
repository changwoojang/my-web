//Filename: list-tab.controller.js

define([ 'windmill' ], function(App) {

	'use strict';

	console.log("[list-tab.controller] load...");
	
	var tabsView ='';
	var listView ='';
	var addPopupView = '';
	
	var ListTabController = Marionette.Controller.extend({

		initialize : function(options) {
			this.ListViews = options.ListViews;
			this.TabsView = options.TabsView;
			
			addPopupView = this.ListViews.AddPopupView ? new this.ListViews.AddPopupView() : '';
		},

		showItems : function(id) {
			listView = new this.ListViews.ListView();
			listView.getData(id);
		},

		showItemDetail : function(item) {
			tabsView = tabsView || new this.TabsView();
			tabsView.setModel(item);
		},

		showAddPopup : function() {
			addPopupView.show();
		}
	});

	return ListTabController;
});
