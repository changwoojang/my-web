// Filename: listview.js

define([ 'windmill' ], function(App) {

	'use strict';

	var ItemView = Marionette.ItemView.extend({
		tagName : 'li',
		className : 'list-item',
		/*template : Handlebars.compile(ListItem),*/

		onRender : function() {
			this.$el.attr({
				'data-id' : this.model.get('id')
			});
		}
	});

	var EmptyView = Marionette.ItemView.extend({
		tagName : 'li',
		/*template : _.template("<div>No requested data</div>"),*/
	});

	var ListView = Marionette.CompositeView.extend({

		emptyView : EmptyView,
		childView : ItemView,

		events : {
			'click .list-item' : 'onClick',
			'click .item-delete' : 'onDelete',
			'click #popup' : 'popup'
		},

		initialize : function() {
			console.log('[ListView] initialize');

			// bind event : function() implementation needs
			this.listenTo(this, 'item:selected', this.selectItem);
			this.listenTo(this, 'item:deleted', this.deleteItem);
		},

		onRender : function() {
			this.select(this.current);
		},

		onClick : function(e) {
			var id = $(e.currentTarget).data('id');
			this.select(id);
		},

		onDelete : function(e) {
			var id = $(e.currentTarget).parent('div').parent('li').data('id');
			console.log('[ListView] delete :' + id);
			this.trigger('item:deleted', id);
		},

		select : function(id) {
			if (!id) {
				id = this.$('li:first').data('id');
			}
			console.log('[ListView] select :' + id);

			if (this.current === id) {
				this.$('[data-id="' + id + '"]').addClass('_active');
				return;
			}

			this.$('li').removeClass('_active');
			this.$('[data-id="' + id + '"]').addClass('_active');

			this.trigger('item:selected', id);
			this.current = id;
		}
	});

	return ListView;
});
