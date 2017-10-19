//Filename: board.controller.js

define(['common/controller/board.controller', 
        'promotion/product-option/product-option.main.views'], 
        function(BoardController, MainViews, DetailViews) {

    'use strict';


    var showItems = function(){
    	var popularSearchTableView = new MainViews.PopularSearchTableView();
    	popularSearchTableView.getData();
   	 
    	var searchRecommendTableView = new MainViews.SearchRecommendTableView();
    	searchRecommendTableView.getData(); 
   };
   
    return {
    	showItems : showItems
    };
});  
