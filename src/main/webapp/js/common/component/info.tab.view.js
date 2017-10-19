//Filename: tabsview.js

define(['windmill'], function(App) {
    
   'use strict';
    
    var TabsView = Marionette.ItemView.extend({
		events: {
			"click a" : 'showContent'
		},
		
		initialize: function(){
			console.log("[Info.TabsView] initialize()");
			
			$('.refresh-btn').click(function(){
				console.log("[Info.TabsView] Refresh Table");
				App.vent.trigger('board:list:view');
			});
		},
		
		setModel : function(item){
			console.log("[Info.TabsView] setModel()");
			this.model = item;
			this.$('#tab1').tab('show');
			this.showContent();
		}
	});

	return TabsView;
});
