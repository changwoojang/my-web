//Filename: notice.total-notice.js

define(['windmill', 'promotion/product-option/product-option.controller', 'include/navbar', 'include/sidebar'], 
function(BoardApp, Controller) {
    
    'use strict';
    
    console.log("[product-option] load...");
 
    var app = BoardApp;
    app.addInitializer(function(options) {      
    	console.log("[Promotion.Template] addInitializer(), ", options);
    	app.vent.trigger('board:list:view');
    });    
    app.addRegions({
		popularSearchTable : '#product-option-list-body',
		searchRecommendTable: '#search-recommend-list-body'
		
	});
    app.vent.on('board:list:view', function(){
    	Controller.showItems();
    }); 
    

    
//	app.start({controller : Controller});

	return app; 
});
