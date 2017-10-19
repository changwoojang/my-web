//Filename: board.js

define(['windmill'], 
function(App) {
    
    'use strict';

    console.log("[list-tab] load...");
    
    var app = App;
    var Controller = '';
    
    app.vent.on('list:view', function(id){
    	Controller.showItems(id);
    }); 
	
	app.vent.on('item:selected', function(item){
    	console.log("[vent.on] item:selected");
    	Controller.showItemDetail(item);  	
    });
		
	
	app.vent.on('show:popup:add', function(){
    	Controller.showAddPopup();
    });
	
	app.addInitializer(function(options) {      
    	console.log("[List-Tab.App] addInitializer()");
    	Controller = options.controller;
    	app.vent.trigger('list:view');
    });

    return app;   
});
