//Filename: ifram.main.views.js

define([ 'windmill', 'promotion/loading/loading.main.views', 'include/navbar', 'include/sidebar'], function(App, MainViews) {

	'use strict';

	console.log("[iframe-paid.app] load...");
	
	var app = App;

	app.addRegions({
    	table : '#loading-list-body'
    });

	app.addInitializer(function(options) {      
		var loadingTableView = new MainViews.LoadingTableView();
		loadingTableView.getData();
    });

    return app;
});