//Filename: board.js

define(['windmill', 'include/navbar', 'include/sidebar'], 
function(App) {
    
    'use strict';

    console.log("[board] load...");
    
    var app = App;
    var Controller = '';
    
    app.vent.on('board:list:view', function(){
    	Controller.showItems();
    }); 
    
    app.vent.on('show:popup:add', function(){
    	Controller.showAddPopup();
    });
    
    app.vent.on('list:item:clicked', function(item){
    	Controller.showItemDetail(item);
    });
    
    app.addInitializer(function(options) {      
    	console.log("[Board] addInitializer()");
    	Controller = options.controller;
    	app.vent.trigger('board:list:view');
    });

    return app;   
});
