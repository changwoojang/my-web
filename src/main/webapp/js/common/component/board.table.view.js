// Filename: board.main.views.js

define(['windmill', 'marionette', 'jquery.form', 'bootstrap-multiselect', 'datepicker', 'timepicker', 'common/util/checkbox'], function(App, Marionette) {

	'use strict';

	console.log("[board.table] load...");

	var ItemView = Marionette.ItemView.extend({
		tagName: 'tr',
		className: 'pointer',
		/* template : '#board-list-item-tpl', */
		
		events: {
			"click": function() {
				App.vent.trigger('list:item:clicked', this.model);
			}
		}

	});

	var EmptyView = Marionette.ItemView.extend({
		tagName: 'tr',
	/* template : _.template("<td colspan=6>No search result.</td>") */
	});

	var TableView = Marionette.CompositeView.extend({
		
		childView : ItemView,
		emptyView : EmptyView,
		 
		events : {
			'click #search-btn' : 'search',
			'click #board-nextBlock' : 'nextBlock', 
			'click #board-prevBlock' : 'prevBlock',
			'click #board-page' : 'page',
			'click #add-btn' : 'add',
			'click #save-btn' : 'saveItem',
			'click #delete-btn' : 'deleteItem',
				'keypress #search-value' :'searchOnEnter'
		},

		initialize: function() {
			console.log("[Board.TableView] initialize()");
		},

		show: function(search) {
			console.log("[Board.TableView] show()");
			this.render();
			App.table.show(this);
			/* this.delegateEvents(this.events); */
			$(".checkbox-table input").not('.check-all').click(function(e) {
				e.stopPropagation();
			});
			
			if (search) {
				$('#search-value').val(search);
			}
		},

		search: function() {
			console.log("[App.TableView] search()");
			this.getData();
		},

		add: function() {
			console.log("[Board.TableView] add()");
			App.vent.trigger('show:popup:add', this.model);
		},

		nextBlock: function() {
			console.log("[Board.TableView] nextPage()");
			this.getData(this.model.get('endPage') + 1);
		},

		prevBlock: function() {
			console.log("[Board.TableView] prevPage()");
			this.getData(this.model.get('startPage') - 1);
		},

		page: function(ev) {
			var num = $(ev.target).data('pagenum');
			console.log("[Board.TableView] page() : " + num);

			this.getData(num);
		},
		searchOnEnter: function(e){
			console.log("searchOnEnter()");
			var self = this;
			var ENTER_KEY=13;
			if(e.which === ENTER_KEY){
				self.search();
			}
		}
	});

	return TableView;
});
