// Filename: board.controller.js

define(['windmill'], function(App) {

	'use strict';

	console.log("[board.controller] load...");
	
	var addPopupView = '';
	
	var BoardController = Marionette.Controller.extend({

		initialize: function(options) {
			this.MainViews = options.MainViews;
			this.DetailViews = options.DetailViews;
			
			addPopupView = this.MainViews.AddPopupView ? new this.MainViews.AddPopupView() : '';
		},

		showItems: function() {
			var tableView = new this.MainViews.TableView();
			tableView.getData();
		},

		showItemDetail: function(item) {
			var detailView = new this.DetailViews.ItemDetailView({model: item});
			detailView.show();
		},

		showAddPopup: function() {
			addPopupView.show();
		}
	});

	return BoardController;
});