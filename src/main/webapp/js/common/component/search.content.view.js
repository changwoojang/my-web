/*
 * function : getView(searchType, callbackFunction(checkedItems))
 * searchType : 검색 타입(program, channel, app ...)
 * callbackFunction : 선택한 항목들을 처리할 함수
 */
define(['windmill','common/util/checkbox'], function(App) {
	'use strict';

	var confirmCallback = '';
	var buttonType = '';
	var selectedCheckbox = [];

	// 검색 옵션으로 사용될 변수 ( ex - 채널 타입 )
	var arg_1 = '';

	App.addRegions({
		vodTable : '#search-vod-body',
		chTable : '#search-channel-body',
		appTable : '#search-app-body',
		noticeTable : '#search-notice-body',
		packageTable : '#search-package-body',
        svodTable : '#search-svod-body',
        fullPackageTable : '#search-full-package-body',
        menuSvodTable : '#search-menu-svod-body',
		schannelTable : '#search-schannel-body',
		ottTable : '#search-ott-body',
		programCategoryTable : '#search-program-category-body',
		programCategoryLimitTable : '#search-program-category-limit-body',
		searchCategoryTable : '#search-category-body',
		searchCategoryDisplayTable : '#search-category-display-body',
		userGroupTable: '#search-usergroup-body',
		promotionGroupTable: '#search-promotiongroup-body',
		contentsPromotionTable: '#search-contents-promotion-body',
		recommendProgramTable: '#search-recommend-program-body',
		menuShortcutTable: '#search-menu-shortcut-body'
	});

	// Program Search View
	var VodCheckboxItemView = Marionette.ItemView.extend({
		tagName: 'tr',
		className: 'pointer',
		template : '#vod-list-item-checkbox-tpl',
	});

	var VodRadioItemView = Marionette.ItemView.extend({
		tagName: 'tr',
		className: 'pointer',
		template : '#vod-list-item-radio-tpl',
	});

	var VodEmptyView = Marionette.ItemView.extend({
		tagName: 'tr',
		template : _.template("<td colspan=9>No search result </td>") 
	});

	var VodTableView = Marionette.CompositeView.extend({

		template : '#vod-list-tpl',

		getChildView: function() {
			console.log("[VodTableView] getChildView : ", buttonType);
			if (buttonType == 'radio') {
				return VodRadioItemView;
			} else {
				return VodCheckboxItemView;
			}
		},

		emptyView : VodEmptyView,

		childViewContainer : '#vod-list-container',

		events : {
			'click #search-btn' : 'search',
			'click #board-nextBlock' : 'nextBlock', 
			'click #board-prevBlock' : 'prevBlock',
			'click #board-page' : 'page',
			'click #delete-btn' : 'deleteItem',
			'click td' : 'checkItem',
			'keypress #search-value' : 'searchOnEnter'
		},

		initialize: function() {
			console.log("[SearchTableView] initialize()");
			App.vodTable.show(this);
		},

		show: function(search, type, format, searchType) {
			console.log("[SearchTableView] show()", search);
			this.render();
			
			$(".checkbox-table input").not('.check-all').click(function(e) {
				e.stopPropagation();
			});
			
			if (search) {
				this.$el.find('#search-value').val(search);
				this.$el.find('#programType').val(type);
				this.$el.find('#format').val(format);
				this.$el.find('#searchType').val(searchType);
			} else {
				$('#search-value').attr('placeholder', $('#searchType option:selected').text());
				$('#searchType').change(function(){
					$('#search-value').attr('placeholder', $('#searchType option:selected').text());
				});
			}
		},

		selectedItems: function(){
			var items = '';
			if (buttonType == 'checkbox'){
				items = $(this.el).find('input:checkbox:checked').not('.check-all').map(function(){
					if($(this).val() != '')
						selectedCheckbox.push($(this).val());
					return $(this).val();
				}).get();
			}else{
				items = $(this.el).find('input:radio:checked').not('.check-all').map(function(){
					if($(this).val() != '')
						selectedCheckbox.push($(this).val());
					return $(this).val();
				}).get();
				
			}
			console.log("[search.content.view] getSelectedCheckBoxItem()", selectedCheckbox);
		},
		
		checkDuplicatedItems: function(){
			var result = [];
			$.each(selectedCheckbox,function(i,val){
				 if ($.inArray(val, result) == -1) result.push(val);
			});
			return result;
			
		},
		getSavedCheckboxItem: function(){
			var result = [];
			this.selectedItems();
			result = this.checkDuplicatedItems();
			return result;
		},
		
		search: function() {
			console.log("[SearchTableView] search()");
			this.selectedItems();
			this.getData();
		},

		nextBlock: function() {
			console.log("[SearchTableView] nextPage()");
			this.selectedItems();
			this.getData(this.model.get('endPage') + 1);
		},

		prevBlock: function() {
			console.log("[SearchTableView] prevPage()");
			this.selectedItems();
			this.getData(this.model.get('startPage') - 1);
		},

		page: function(ev) {
			var num = $(ev.target).data('pagenum');
			console.log("[SearchTableView] page() : " + num);
			this.selectedItems();
			this.getData(num);
		},

		getData : function(page) {
			var param = {
					"page" : page ? page : '',
					"search" : this.$el.find('#search-value').val(),
					"searchType" : $("#program-select-popup #searchType  option:selected").val(),
					"type" :       $("#program-select-popup #programType option:selected").val(),
					"format" :     $("#program-select-popup #format      option:selected").val()
			};

			if (param.search) {
				self = this;
				$.ajax({
					type : "GET",
					url : '/'+App.ctx+'/search/getProgramList',
					data : param,
					success : function(data) {
						console.log("[VodTableView] getData() - success : ", data);
						self.collection = new Backbone.Collection(data.content);
						self.model = new Backbone.Model(data);
						console.log(JSON.stringify(data));

						self.show(param.search, param.type, param.format, param.searchType);
					}
				});

			} else {
				this.show();
			}
		},

		getSelectedItem: function() {
			var items = '';
			var self = this;
			
            var radioCheck = document.getElementsByName('board-check');    
            var radioSeries = document.getElementsByName('isSeriesOnly');
            
			if (buttonType == 'radio') {
				items = $(self.el).find('input:radio:checked').not('.check-all, .except').map(function() {
					return $(this).val();
				}).get();
			} else {
				items = $(this.el).find('input:checkbox:checked').not('.check-all').map(function(){
					return $(this).val();
				}).get();
			}
			//__program_categoey menu type일 경우에만 해당
			if($(this.el).find('select#categoryDisplayLine option:selected').val() != null)
				items += ":"+$(this.el).find('select#categoryDisplayLine option:selected').val();
			if($(this.el).find('select#seriesDisplayType option:selected').val() != null)
				items += ":"+$(this.el).find('select#seriesDisplayType option:selected').val();
			
			if(!radioSeries){
				//선택된 row의 isSeriesOnly 값 가져오기
	            for (var i = 0; i < radioCheck.length; i++) {
	                if (radioCheck[i].checked) {
	                    items += ":"+radioSeries[i].innerHTML;
	                }
	            }
			}
            
			console.log("[search.content.view] getSelectedItem()", items.toString());

			return items;
		},
        
        checkItem : function(e) {
            var isChecked = $(e.target).closest('tr').find('input[type=checkbox]').prop('checked');

            if(isChecked == false)
                $(e.target).closest('tr').find('input[type=checkbox]').prop('checked', true);
            else 
                $(e.target).closest('tr').find('input[type=checkbox]').prop('checked', false);
        },
        
        searchOnEnter : function(e) {
            console.log("searchOnEnter()");
            var self = this;
            var ENTER_KEY = 13;
            if ( e.which === ENTER_KEY ) {
                self.search();
            }
        }

	});

	var vodTableView = '';
	var SearchVodPopup = Marionette.ItemView.extend({

		el : '#program-select-popup',

		events : {
			'click #program-popup-confirm': 'confirm'
		},

		initialize : function() {
			console.log("[SearchVodPopup] initialize()");
		},

		show : function() {
			console.log("[SearchVodPopup] show() ");
			this.$el.modal('show');

			vodTableView = vodTableView || new VodTableView();
			vodTableView.getData();
		},

		confirm: function() {
			console.log("[SearchVodPopup] confirm() ", buttonType);
			var items;
			if(buttonType == "radio")
				items = vodTableView.getSelectedItem();
			else
				items = vodTableView.getSavedCheckboxItem();
			
			if( items.length > 0) {
				confirmCallback(items);
				this.$el.modal('hide');
			} else {
				this.$el.modal('hide');
			}
		}
	});

	// Channel Search View
	var ChCheckboxItemView = Marionette.ItemView.extend({
		tagName: 'tr',
		className: 'pointer',
		template : '#ch-list-item-checkbox-tpl',
	});

	var ChRadioItemView = Marionette.ItemView.extend({
		tagName: 'tr',
		className: 'pointer',
		template : '#ch-list-item-radio-tpl',
	});

	var ChEmptyView = Marionette.ItemView.extend({
		tagName: 'tr',
		template : _.template("<td colspan=8>No search result </td>") 
	});

	var ChTableView = Marionette.CompositeView.extend({

		template : '#ch-list-tpl',

		getChildView: function() {
			if (buttonType === 'radio') {
				return ChRadioItemView;
			} else {
				return ChCheckboxItemView;
			} 
		},

		emptyView : ChEmptyView,

		childViewContainer : '#ch-list-container',

		events : {
			'click #search-btn' : 'search',
			'click #board-nextBlock' : 'nextBlock', 
			'click #board-prevBlock' : 'prevBlock',
			'click #board-page' : 'page',
			'click #delete-btn' : 'deleteItem',
				
			'click td' : 'checkItem',
			'keypress #search-value' : 'searchOnEnter'
		},

		initialize: function() {
			console.log("[ChTableView] initialize()");
		},

		show: function(search) {
			console.log("[ChTableView] show()");
			this.render();
			App.chTable.show(this);

			$(".checkbox-table input").not('.check-all').click(function(e) {
				e.stopPropagation();
			});

			if (search) {
				this.$el.find('#search-value').val(search);
			}
		},

		search: function() {
			console.log("[ChTableView] search()");
			this.getData();
		},

		nextBlock: function() {
			console.log("[ChTableView] nextPage()");
			this.getData(this.model.get('endPage') + 1);
		},

		prevBlock: function() {
			console.log("[ChTableView] prevPage()");
			this.getData(this.model.get('startPage') - 1);
		},

		page: function(ev) {
			var num = $(ev.target).data('pagenum');
			console.log("[ChTableView] page() : " + num);

			this.getData(num);
		},

		getData : function(page) {
			console.log("[ChTableView] getData() > " + page);
			var self = this;
			var search = this.$el.find('#search-value').val() ? this.$el.find('#search-value').val() : '';
			var query = '?search=' + search;
			var pageParam = page ? '&page=' + page : '';
//			var type = arg_1 ? '&type=' + arg_1 : '';
			
			query = pageParam ? query + pageParam : query ;
//			query = type ? query + type : query;
			
			$.getJSON('/'+App.ctx+'/search/getChannelList' + query, function(data) {
				console.log("[ChTableView] getData - Success : ", data);
				self.collection = new Backbone.Collection(data.content);
				self.model = new Backbone.Model(data);
			}).success(function(){
				self.show(search);
			});
		},

		getSelectedItem: function() {
			var items = '';
			if (buttonType == 'radio') {
				items = $(this.el).find('input:radio:checked').not('.check-all').map(function() {
					return $(this).val();
				}).get();
			} else {
				items = $(this.el).find('input:checkbox:checked').not('.check-all').map(function(){
					return $(this).val();
				}).get();
			}

			console.log("[search.content.view] getSelectedItem()", items.toString());

			return items;
		},
		
	    checkItem : function(e) {
            var isChecked = $(e.target).closest('tr').find('input[type=checkbox]').prop('checked');
            if(isChecked == false)
                $(e.target).closest('tr').find('input[type=checkbox]').prop('checked', true);
            else 
                $(e.target).closest('tr').find('input[type=checkbox]').prop('checked', false);
        },
	        
        searchOnEnter : function(e) {
            console.log("searchOnEnter()");
            var self = this;
            var ENTER_KEY = 13;
            if ( e.which === ENTER_KEY ) {
                self.search();
            }
        }
	});

	var TypedChTableView = ChTableView.extend({
		template : '#typed-ch-list-tpl'
	});

	var chTableView = '';
	var SearchChannelPopup = Marionette.ItemView.extend({

		el : '#channel-select-popup',

		events : {
			'click #channel-popup-confirm': 'confirm',
		},

		initialize : function() {
			console.log("[SearchChannelPopup] initialize()");
		},

		show : function() {
			console.log("[SearchChannelPopup] show() type : ", arg_1);
			this.$el.modal('show');
			
			if ( arg_1 == null || arg_1 == '') {
				chTableView = new ChTableView();
			} else {
				chTableView = new TypedChTableView();
			}
			chTableView.getData();
		},

		confirm: function() {
			console.log("[SearchChannelPopup] confirm()");
			var items = chTableView.getSelectedItem();
			if( items.length > 0) {
				confirmCallback(items);
			} else {
				this.$el.modal('hide');
			}
		}
	});

	// App Search View
	var appTableView = '';
	var AppCheckboxItemView = Marionette.ItemView.extend({
		template: '#search-app-list-checkbox-item-tpl',
		tagName: 'tr',
		className: 'pointer',
	});

	var AppRadioItemView = Marionette.ItemView.extend({
		template: '#search-app-list-radio-item-tpl',
		tagName: 'tr',
		className: 'pointer',
	});

	var AppEmptyView = Marionette.ItemView.extend({
		template: _.template('<td colspan=4>No search result </td>'),
		tagName: 'tr'
	});

	var AppTableView = VodTableView.extend({
		template: '#search-app-list-tpl',

		getChildView: function() {
			if (buttonType == 'radio') {
				return AppRadioItemView;
			} else {
				return AppCheckboxItemView;
			}
		},

		emptyView: AppEmptyView,
		childViewContainer: 'tbody',

		initialize: function() {
			console.log("[AppTableView] initialize()");
			App.appTable.show(this);
		},

		show: function(search) {
			console.log("[PromotionTableView] show()");
			this.render();

			if(search) {
				this.$el.find('#search-value').val(search);
			}

			$(".checkbox-table input").click(function(e) {
				e.stopPropagation();
			});
		},

		getData: function(page) {
			var self = this;
			var param = {
					'page' :page ? '?page=' + page : '',
							'search' : this.$el.find('#search-value').val(),
			};

			$.ajax({
				type: 'GET',
				url : '/'+App.ctx+'/search/app',
				data : param,
				success: function(data) {
					console.log("[AppTableView] getData() - success : ", data);
					self.collection = new Backbone.Collection(data.content);
					self.model = new Backbone.Model(data);
					self.show();
				}
			});
		}
	});

	var SearchAppPopup = SearchVodPopup.extend({

		el : '#appstore-select-popup',

		events :  {
			'click #app-popup-confirm': 'confirm',
		},

		show: function() {
			console.log("[SearchVodPopup] show() ");
			this.$el.modal('show');

			appTableView = appTableView || new AppTableView();
			appTableView.getData();
		},

		confirm: function() {
			console.log("[SearchVodPopup] confirm()");
			var items = appTableView.getSelectedItem();
			if( items.length > 0) {
				confirmCallback(items);
			} else {
				this.$el.modal('hide');
			}
		}
	});


	//Notice Search View
	var noticeTableView = '';
	var NoticeCheckboxItemView = Marionette.ItemView.extend({
		template: '#search-notice-list-checkbox-item-tpl',
		tagName: 'tr',
		className: 'pointer'
	});

	var NoticeRadioItemView = Marionette.ItemView.extend({
		template: '#search-notice-list-radio-item-tpl',
		tagName: 'tr',
		className: 'pointer'
	});

	var NoticeEmptyView = Marionette.ItemView.extend({
		template: _.template('<td colspan=5>No search result </td>'),
		tagName: 'tr'
	});

	var NoticeTableView = VodTableView.extend({
		template: '#search-notice-list-tpl',

		getChildView: function() {
			if (buttonType == 'radio') {
				return NoticeRadioItemView;
			} else {
				return NoticeCheckboxItemView;
			}
		},
		emptyView: NoticeEmptyView,

		childViewContainer: 'tbody',

		initialize: function() {
			console.log("[NoticeTableView] initialize()");
			App.noticeTable.show(this);
		},

		getData: function(page) {
			var self = this;
			var param = {
					'page' :page ? page : '',
							'search' : this.$el.find('#search-value').val(),
							'source' : this.$el.find('select#searchType option:selected').val()

			};

			$.ajax({
				type: 'GET',
				url : '/'+App.ctx+'/search/notice',
				data : param,
				success: function(data) {
					console.log("[NoticeTableView] getData() - success : ", data);
					self.collection = new Backbone.Collection(data.content);
					self.model = new Backbone.Model(data);
					self.show();
					self.setSource(param);
				}
			});
		},

		setSource: function(param) {
			if(param.source)
                $('select#searchType option#'+param.source).attr('selected', 'selected');    
			
			this.$el.find('#search-value').val(param.search);
			
            
            $('#searchType').change(function(){
                $('#search-value').attr('placeholder', $('#searchType option:selected').text());
            });

		}
	});

	var SearchNoticePopup = SearchVodPopup.extend({

		el : '#mail-select-popup',

		events :  {
			'click #notice-popup-confirm': 'confirm',
		},

		show: function() {
			console.log("[SearchNoticePopup] show() ");
			this.$el.modal('show');

			noticeTableView = noticeTableView || new NoticeTableView();
			noticeTableView.getData();
		},

		confirm: function() {
			console.log("[SearchNoticePopup] confirm()");
			var items = noticeTableView.getSelectedItem();
			if( items.length > 0) {
				confirmCallback(items);
			} else {
				this.$el.modal('hide');
			}
		}
	});

	// Program Category Search View
	var programCategoryTableView = '';
	var ProgramCategoryCheckboxItemView = Marionette.ItemView.extend({
		template: '#search-program-category-list-checkbox-item-tpl',
		tagName: 'tr',
		className: 'pointer'
	});

	var ProgramCategoryRadioItemView = Marionette.ItemView.extend({
		template: '#search-program-category-list-radio-item-tpl',
		tagName: 'tr',
		className: 'pointer'
	});

	var ProgramCategoryEmptyView = Marionette.ItemView.extend({
		template: _.template('<td colspan=9>No search result </td>'),
		tagName: 'tr'
	});

	var ProgramCategoryTableView = VodTableView.extend({
		template: '#search-program-category-list-tpl',
		getChildView: function() {
			if (buttonType == 'radio') {
				return ProgramCategoryRadioItemView;
			} else {
				return ProgramCategoryCheckboxItemView;
			}
		},
		emptyView: ProgramCategoryEmptyView,
		childViewContainer: 'tbody',

		initialize: function() {
			console.log("[ProgramCategoryTableView] initialize()");
			App.programCategoryTable.show(this);
		},

		getData: function(page) {
			var self = this;
			var params = {
					'page' :page ? page : '',
							'search' : this.$el.find('#search-value').val(),
							'menuGroupId' : searchProgramCategoryPopup.model.get('menuGroupId')
			};

			$.ajax({
				type: 'GET',
				url : '/'+App.ctx+'/search/getProgramCategoryLeafList',
				data : params,
				success: function(data) {
					console.log("[ProgramCategoryTableView] getData() - success : ", data);
					self.collection = new Backbone.Collection(data.content);
					self.model = new Backbone.Model(data);
					self.show(params.search);
				},
	            error: function(data) {
                    showErrorMessage(data);
	            }
			});
		}
	});

	var SearchProgramCategoryPopup = SearchVodPopup.extend({

		el : '#program_category-select-popup',

		events :  {
			'click #program-category-popup-confirm': 'confirm',
		},

		show: function(parameters) {
			console.log("[SearchProgramCategoryPopup] show() ");
			this.model = new Backbone.Model(parameters);
			this.$el.modal('show');

			programCategoryTableView = programCategoryTableView || new ProgramCategoryTableView();
			programCategoryTableView.getData(null);
		},

		confirm: function() {
			console.log("[ProgramCategoryNoticePopup] confirm()");
			var items = programCategoryTableView.getSelectedItem();
			if( items.length > 0) {
				confirmCallback(items);
			} else {
				this.$el.modal('hide');
			}
		}
	});
	
	var ProgramLimitCategoryCheckboxItemView = Marionette.ItemView.extend({
		template: '#search-program-category-limit-list-checkbox-item-tpl',
		tagName: 'tr',
		className: 'pointer'
	});

	var ProgramLimitCategoryRadioItemView = Marionette.ItemView.extend({
		template: '#search-program-category-limit-list-radio-item-tpl',
		tagName: 'tr',
		className: 'pointer'
	});

	var ProgramLimitCategoryEmptyView = Marionette.ItemView.extend({
		template: _.template('<td colspan=9>No search result </td>'),
		tagName: 'tr'
	});

	var programLimitCategoryTableView = '';
	var ProgramLimitCategoryTableView = VodTableView.extend({
		template: '#search-program-category-limit-list-tpl',
		getChildView: function() {
			if (buttonType == 'radio') {
				return ProgramLimitCategoryRadioItemView;
			} else {
				return ProgramLimitCategoryCheckboxItemView;
			}
		},
		emptyView: ProgramLimitCategoryEmptyView,
		childViewContainer: 'tbody',

		initialize: function() {
			console.log("[ProgramCategoryLimitTableView] initialize()");
			App.programCategoryLimitTable.show(this);
		},

		getData: function(page) {
			var self = this;
			var params = {
				'page' :page ? page : '',
				'search' : this.$el.find('#search-value').val(),
				'menuGroupId' : searchLimitProgramCategoryPopup.model.get('menuGroupId'),
				'depth' : searchLimitProgramCategoryPopup.model.get('selectedMenuDepth')
			};

			$.ajax({
				type: 'GET',
				url : '/'+App.ctx+'/search/getProgramLimitCategoryLeafList',
				data : params,
				success: function(data) {
					console.log("[ProgramCategoryLimitTableView] getData() - success : ", data);
					self.collection = new Backbone.Collection(data.content);
					self.model = new Backbone.Model(data);
					self.show(params.search);
				},
	            error: function(data) {
                    showErrorMessage(data);
	            }
			});
		}
	});
	var SearchLimitProgramCategoryPopup = SearchVodPopup.extend({

		el : '#program_category-limit-select-popup',

		events :  {
			'click #program-category-limit-popup-confirm': 'confirm',
		},

		show: function(parameters) {
			console.log("[SearchProgramCategoryLimitPopup] show() ", parameters);
			this.model = new Backbone.Model(parameters);
			this.$el.modal('show');

			programLimitCategoryTableView = programLimitCategoryTableView || new ProgramLimitCategoryTableView();
			programLimitCategoryTableView.getData(null);
		},

		confirm: function() {
			console.log("[ProgramCategoryLimitNoticePopup] confirm()");
			var items = programLimitCategoryTableView.getSelectedItem();
			items += ":null";
			items += ":"+this.model.get('selectedMenuDepth');
			if( items.length > 0) {
				confirmCallback(items);
			} else {
				this.$el.modal('hide');
			}
		}
	});

	// Category Search View
	var categoryTableView = '';
	var categoryDisplayTableView='';
	var CategoryCheckboxItemView = Marionette.ItemView.extend({
		template: '#search-category-list-checkbox-item-tpl',
		tagName: 'tr',
		className: 'pointer'
	});

	var CategoryRadioItemView = Marionette.ItemView.extend({
		template: '#search-category-list-radio-item-tpl',
		tagName: 'tr',
		className: 'pointer'
	});

	var CategoryEmptyView = Marionette.ItemView.extend({
		template: _.template('<td colspan=9>No search result </td>'),
		tagName: 'tr'
	});

	var CategoryTableView = VodTableView.extend({
		template: '#search-category-list-tpl',

		getChildView: function() {
			if (buttonType == 'radio') {
				return CategoryRadioItemView;
			} else {
				return CategoryCheckboxItemView;
			}
		},
		emptyView: CategoryEmptyView,
		childViewContainer: 'tbody',

		initialize: function() {
			console.log("[CategoryTableView] initialize()");
			App.searchCategoryTable.show(this);
		},

		getData: function(page) {
			var self = this;
			var menuGroup ="";
			
			menuGroup = searchCategoryPopup.model.get('menuGroupId');
			var params = {
					'page' :page ? page : '',
							'search' : this.$el.find('#search-value').val(),
							'menuGroupId' : menuGroup
			};

			$.ajax({
				type: 'GET',
				url : '/'+App.ctx+'/search/getProgramCategoryList',
				data : params,
				success: function(data) {
					console.log("[CategoryTableView] getData() - success : ", data);
					self.collection = new Backbone.Collection(data.content);
					self.model = new Backbone.Model(data);
					self.show(params.search);
				}
			});
		}
	});

	var SearchCategoryPopup = SearchVodPopup.extend({

		el : '#category-select-popup',

		events :  {
			'click #category-popup-confirm': 'confirm',
		},

		show: function(parameters) {
			console.log("[CategoryNoticePopup] show() ");
			this.model = new Backbone.Model(parameters);
			this.$el.modal('show');

			categoryTableView = categoryTableView || new CategoryTableView();
			categoryTableView.getData(null);
		},

		confirm: function() {
			console.log("[CategoryNoticePopup] confirm()");
			var items = categoryTableView.getSelectedItem();
			if( items.length > 0) {
				confirmCallback(items);
			} else {
				this.$el.modal('hide');
			}
		}
	});
	
	var CategoryDisplayTableView = VodTableView.extend({
		template: '#search-category-display-list-tpl',

		getChildView: function() {
			if (buttonType == 'radio') {
				return CategoryRadioItemView;
			} else {
				return CategoryCheckboxItemView;
			}
		},
		emptyView: CategoryEmptyView,
		childViewContainer: 'tbody',

		initialize: function() {
			console.log("[CategoryTableView] initialize()");
			App.searchCategoryDisplayTable.show(this);
		},

		getData: function(page) {
			var self = this;
			var menuGroup ="";
			
			menuGroup = searchCategoryDisplayPopup.model.get('menuGroupId')
			
			var params = {
					'page' :page ? page : '',
							'search' : this.$el.find('#search-value').val(),
							'menuGroupId' : menuGroup
			};

			$.ajax({
				type: 'GET',
				url : '/'+App.ctx+'/search/getProgramCategoryList',
				data : params,
				success: function(data) {
					console.log("[CategoryTableView] getData() - success : ", data);
					self.collection = new Backbone.Collection(data.content);
					self.model = new Backbone.Model(data);
					self.show(params.search);
				}
			});
		}
	});
	
	var SearchCategoryDisplayPopup = SearchVodPopup.extend({

		el : '#category-display-select-popup',

		events :  {
			'click #category-popup-confirm': 'confirm',
		},

		show: function(parameters) {
			console.log("[CategoryNoticePopup] show() ");
			this.model = new Backbone.Model(parameters);
			this.$el.modal('show');

			categoryDisplayTableView = categoryDisplayTableView || new CategoryDisplayTableView();
			categoryDisplayTableView.getData(null);
		},

		confirm: function() {
			console.log("[CategoryNoticePopup] confirm()");
			var items = categoryDisplayTableView.getSelectedItem();
			if( items.length > 0) {
				confirmCallback(items);
			} else {
				this.$el.modal('hide');
			}
		}
	});
	


	// User Group Search View
	var userGroupTableView = '';
	var UserGroupCheckboxItemView = Marionette.ItemView.extend({
		template: '#search-usergroup-list-checkbox-item-tpl',
		tagName: 'tr',
		className: 'pointer'
	});

	var UserGroupRadioItemView = Marionette.ItemView.extend({
		template: '#search-usergroup-list-radio-item-tpl',
		tagName: 'tr',
		className: 'pointer'
	});

	var UserGroupEmptyView = Marionette.ItemView.extend({
		template: _.template('<td colspan=4>No search result </td>'),
		tagName: 'tr'
	});

	var UserGroupTableView = VodTableView.extend({
		template: '#search-usergroup-list-tpl',
		getChildView: function() {
			if (buttonType == 'radio') {
				return UserGroupRadioItemView;
			} else {
				return UserGroupCheckboxItemView;
			}
		},
		emptyView: UserGroupEmptyView,
		childViewContainer: 'tbody',

		initialize: function() {
			console.log("[UserGroupTableView] initialize()");
			App.userGroupTable.show(this);
		},

		getData: function(page) {
			var self = this;
			var pageNum = page ? page : 1;
			console.log(pageNum);
			var data = {
					page : pageNum,
					search : this.$el.find('#search-value').val()
			};

			$.ajax({
				type: 'GET',
				url : '/'+App.ctx+'/search/usergroup',
				data : data,
				success: function(data) {
					console.log("[UserGroupTableView] getData() - success : ", data);
					self.collection = new Backbone.Collection(data.content);
					self.model = new Backbone.Model(data);
					self.show();
				}
			});
		}
	});

	var SearchUserGroupPopup = SearchVodPopup.extend({

		el : '#usergroup-select-popup',

		events :  {
			'click #usergroup-popup-confirm': 'confirm',
		},

		show: function() {
			console.log("[UserGroupNoticePopup] show() ");
			this.$el.modal('show');

			userGroupTableView = userGroupTableView || new UserGroupTableView();
			userGroupTableView.getData();
		},

		confirm: function() {
			console.log("[UserGroupNoticePopup] confirm()");
			var items = userGroupTableView.getSelectedItem();
			if( items.length > 0) {
				confirmCallback(items);
			} else {
				this.$el.modal('hide');
			}
		}
	});
	
	// Promotion Group Search View
	
	var promotionGroupTableView = '';
	var PromotionGroupCheckboxItemView = Marionette.ItemView.extend({
		template: '#search-promotiongroup-list-checkbox-item-tpl',
		tagName: 'tr',
		className: 'pointer'
	});

	var PromotionGroupRadioItemView = Marionette.ItemView.extend({
		template: '#search-promotiongroup-list-radio-item-tpl',
		tagName: 'tr',
		className: 'pointer'
	});

	var PromotionGroupEmptyView = Marionette.ItemView.extend({
		template: _.template('<td colspan=7>No search result </td>'),
		tagName: 'tr'
	});

	var PromotionGroupTableView = VodTableView.extend({
		template: '#search-promotiongroup-list-tpl',
		getChildView: function() {
			if (buttonType == 'radio') {
				return PromotionGroupRadioItemView;
			} else {
				return PromotionGroupCheckboxItemView;
			}
		},
		emptyView: PromotionGroupEmptyView,
		childViewContainer: 'tbody',

		initialize: function() {
			console.log("[PromotionGroupTableView] initialize()");
			App.promotionGroupTable.show(this);
		},
		show: function(search) {
			console.log("[promotionTableView] show()");
			this.render();

			if(search) {
				this.$el.find('#search-value').val(search);
			}

			$(".checkbox-table input").click(function(e) {
				e.stopPropagation();
			});
		},

		getData: function(page) {
			var self = this;

			$.ajax({
				type: 'GET',
				url :'/'+App.ctx+'/search/promotion/ip-group',
				success: function(data) {
					console.log("[PromotionGroupTableView] getData() - success : ", data);
					self.collection = new Backbone.Collection(data);
					self.model = new Backbone.Model(data);
					self.show();
				}
			});
		}
	});

	var SearchPromotionGroupPopup = SearchVodPopup.extend({

		el : '#promotiongroup-select-popup',

		events :  {
			'click #promotiongroup-popup-confirm': 'confirm',
		},

		show: function() {
			console.log("[PromotionGroupNoticePopup] show() ");
			this.$el.modal('show');
			promotionGroupTableView = promotionGroupTableView || new PromotionGroupTableView();
			promotionGroupTableView.getData();
		},
		confirm: function() {
			console.log("[promotionGroupNoticePopup] confirm()");
			var items = promotionGroupTableView.getSelectedItem();
			if( items.length > 0) {
				confirmCallback(items);
				this.$el.modal('hide');
			} else {
				this.$el.modal('hide');
			}
		}
	});
	
	var menuPromotionGroupTableView = '';
	var MenuPromotionGroupTableView = VodTableView.extend({
		template: '#search-promotiongroup-list-tpl',
		getChildView: function() {
			if (buttonType == 'radio') {
				return PromotionGroupRadioItemView;
			} else {
				return PromotionGroupCheckboxItemView;
			}
		},
		emptyView: PromotionGroupEmptyView,
		childViewContainer: 'tbody',

		initialize: function() {
			console.log("[PromotionGroupTableView] initialize()");
			App.promotionGroupTable.show(this);
		},
		show: function(search) {
			console.log("[promotionTableView] show()");
			this.render();

			if(search) {
				this.$el.find('#search-value').val(search);
			}

			$(".checkbox-table input").click(function(e) {
				e.stopPropagation();
			});
		},

		getData: function(page) {
			var self = this;
			
			$.ajax({
				type: 'GET',
				url :'/'+App.ctx+'/search/promotion/menu-promotion',
				success: function(data) {
					console.log("[PromotionGroupTableView] getData() - success : ", data);
					self.collection = new Backbone.Collection(data);
					self.model = new Backbone.Model(data);
					self.show();
				}
			});
		}
	});
	var SearchMenuPromotionGroupPopup = SearchVodPopup.extend({

		el : '#promotiongroup-select-popup',

		events :  {
			'click #promotiongroup-popup-confirm': 'confirm',
		},

		show: function() {
			console.log("[PromotionGroupNoticePopup] show() ");
			this.$el.modal('show');
			menuPromotionGroupTableView = menuPromotionGroupTableView || new MenuPromotionGroupTableView();
			menuPromotionGroupTableView.getData();
		},
		confirm: function() {
			console.log("[promotionGroupNoticePopup] confirm()");
			var items = menuPromotionGroupTableView.getSelectedItem();
			if( items.length > 0) {
				confirmCallback(items);
				this.$el.modal('hide');
			} else {
				this.$el.modal('hide');
			}
		}
	});
	


	// Contents Promotion Search View
	var contentsPromotionTableView = '';
	var ContentsPromotionCheckboxItemView = Marionette.ItemView.extend({
		template: '#search-contents-promotion-list-checkbox-item-tpl',
		tagName: 'tr',
		className: 'pointer'
	});

	var ContentsPromotionRadioItemView = Marionette.ItemView.extend({
		template: '#search-contents-promotion-list-radio-item-tpl',
		tagName: 'tr',
		className: 'pointer'
	});

	var ContentsPromotionEmptyView = Marionette.ItemView.extend({
		template: _.template('<td colspan=6>No search result.</td>'),
		tagName: 'tr'
	});

	var ContentsPromotionTableView = VodTableView.extend({
		template: '#search-contents-promotion-list-tpl',
		getChildView: function() {
			if (buttonType == 'radio') {
				return ContentsPromotionRadioItemView;
			} else {
				return ContentsPromotionCheckboxItemView;
			}
		},
		emptyView: ContentsPromotionEmptyView,
		childViewContainer: 'tbody',

		initialize: function() {
			console.log("[ContentsPromotionTableView] initialize()");
			App.contentsPromotionTable.show(this);
		},

		getData: function(page) {
			var self = this;
			var pageNum = page ? page : 1;
			console.log(pageNum);
			var data = {
					page : pageNum,
					search : this.$el.find('#search-value').val()
			};

			$.ajax({
				type: 'GET',
				url : '/'+App.ctx+'/search/promotion',
				data : data,
				success: function(data) {
					console.log("[ContentsPromotionTableView] getData() - success : ", data);
					self.collection = new Backbone.Collection(data.content);
					self.model = new Backbone.Model(data);
					self.show();
				}
			});
		}
	});

	var SearchContentsPromotionPopup = SearchVodPopup.extend({

		el : '#contents-promotion-select-popup',

		events :  {
			'click #contents-promotion-popup-confirm': 'confirm',
		},

		show: function() {
			console.log("[ContentsPromotionNoticePopup] show() ");
			this.$el.modal('show');

			contentsPromotionTableView = contentsPromotionTableView || new ContentsPromotionTableView();
			contentsPromotionTableView.getData();
		},

		confirm: function() {
			console.log("[ContentsPromotionNoticePopup] confirm()");
			var items = contentsPromotionTableView.getSelectedItem();
			if( items.length > 0) {
				confirmCallback(items);
			} else {
				this.$el.modal('hide');
			}
		}
	});

	// Recommend Program Search View
	var recommendProgramTableView = '';

	var RecommendProgramRadioItemView = Marionette.ItemView.extend({
		template: '#search-recommend_program-list-item-tpl',
		tagName: 'tr',
		className: 'pointer'
	});

	var RecommendProgramEmptyView = Marionette.ItemView.extend({
		template: _.template('<td colspan=8>No data </td>'),
		tagName: 'tr'
	});

	var RecommendProgramTableView = VodTableView.extend({
		template: '#recommend_program-list-tpl',
		getChildView: RecommendProgramRadioItemView,

		emptyView: RecommendProgramEmptyView,
		childViewContainer: 'tbody',

		initialize: function() {
			console.log("[RecommendProgramTableView] initialize()");
			App.recommendProgramTable.show(this);
		},

		getData: function(page) {
			var self = this;
			var params = {
					'page' :page ? page : '',
							//'search' : this.$el.find('#search-value').val(),
			};

			$.ajax({
				type: 'GET',
				url : '/'+App.ctx+'/search/recommendPrograms',
				data : params,
				success: function(data) {
					console.log("[RecommendProgramTableView] getData() - success : ", data);
					self.collection = new Backbone.Collection(data.content);
					self.model = new Backbone.Model(data);
					self.show(params.search);
				}
			});
		}
	});

	var SearchRecommendProgramPopup = SearchVodPopup.extend({

		el : '#recommend_program-select-popup',

		events :  {
			'click #recommend_program-popup-confirm': 'confirm',
		},

		show: function(parameters) {
			console.log("[SearchRecommendProgramPopup] show() ");
			this.model = new Backbone.Model(parameters);
			this.$el.modal('show');

			recommendProgramTableView = recommendProgramTableView || new RecommendProgramTableView();
			recommendProgramTableView.getData(null);
		},

		confirm: function() {
			console.log("[SearchRecommendProgramPopup] confirm()");
			var items = recommendProgramTableView.getSelectedItem();
			if( items.length > 0) {
				confirmCallback(items);
			} else {
				this.$el.modal('hide');
			}
		}
	});
  
	// Category Program Search View
	var categoryProgramTableView = '';
	
	var CategoryProgramItemView = Marionette.ItemView.extend({
		template: '#category_program-item-tpl',
		tagName: 'tr',
		className: 'pointer'
	});
	
	var CategoryProgramEmptyView = Marionette.ItemView.extend({
		template: _.template('<td colspan=9>No Data. </td>'),
		tagName: 'tr'
	});
	
	var categoryId = '';
	var CategoryProgramTableView = VodTableView.extend({
		template: '#category_program-list-tpl',
		
		getChildView: function() {
			if (buttonType == 'radio') {
				return CategoryProgramItemView;
			} else {
				return CategoryProgramItemView;
			}
		},
		emptyView: CategoryProgramEmptyView,
		

		initialize: function() {
			console.log("[CategoryProgramTableView] initialize()");
			App.categoryProgramTable.show(this);
			
			categoryId = this.model.get('categoryId');
		},

		show: function() {
			console.log("[CategoryProgramTableView] show()");
			this.render();

			$("input").click(function(e) {
				e.stopPropagation();
			});
		},
		
		getData: function(page) {
			console.log("[CategoryProgramTableView] getData() - categoryId :", categoryId);
			
			var query = '?hideExpired=true';
			var pageQuery = page ? '&page=' + page : '';
			query = pageQuery ? query + pageQuery : query;
			
			var self = this;
			
			loading.show();
			
		}, 
		
	});

	var SearchCategoryProgramPopup = SearchVodPopup.extend({

		el : '#category_program-select-popup',

		events :  {
			'click #category_program-popup-confirm': 'confirm',
		},
		
		show: function(parameters) {
			console.log("[SearchCategoryProgramPopup] show() - parameters :", parameters);
			this.model = new Backbone.Model(parameters);
			this.$el.modal('show');

			categoryProgramTableView = new CategoryProgramTableView({model : this.model});
			categoryProgramTableView.getData();
		},

		confirm: function() {
			console.log("[SearchCategoryProgramPopup] confirm()");
			var items = categoryProgramTableView.getSelectedItem();
			if( items.length > 0) {
				confirmCallback(items);
			} else {
				this.$el.modal('hide');
			}
		}
	});

	var PackageRadioItemView = Marionette.ItemView.extend({
		tagName: 'tr',
		className: 'pointer',
	    template : '#search-vod-package-list-radio-item-tpl',

	});
	var PackageCheckboxItemView = Marionette.ItemView.extend({
		tagName: 'tr',
		className: 'pointer',
	    template : '#search-vod-package-list-checkbox-item-tpl',

	});
	var PackageEmptyView = Marionette.ItemView.extend({
		tagName: 'tr',
	    template : _.template("<td colspan=3>No Search Result</td>") 
	});
	
	var PackageTableView = VodTableView.extend({
		
		template : '#vod-package-list-tpl',
		getChildView: function() {
			if (buttonType === 'radio') {
				return PackageRadioItemView;
			} else {
				return PackageCheckboxItemView;
			} 
		},
	
		emptyView : PackageEmptyView,
		
		childViewContainer : '#vod-package-list-container',
		
		initialize: function() {
			console.log("[PackageTableView] initialize()");
//			App.packageTable.show(this);
		},
		show: function() {
			console.log("[SelectPackagePopup.PackageTableView] show()");
//			this.render();
			App.packageTable.show(this);
			
			$(".checkbox-table input").not('.check-all').click(function(e) {
				e.stopPropagation();
			});
		},

		getData : function() {
			var self = this;	
			
			
			$.ajax({
				type: 'GET',
				url : '/'+App.ctx+'/search/getProgramSeriesList',
				success: function(data) {
					self.collection = new Backbone.Collection(data);
					self.show();
				}
			});
			
			
//			loading.show();
//			$.getJSON(url, function(data) {
//				console.log("[PackageTableView] getData() - success : ", data);
//				self.collection = new Backbone.Collection(data);
//				console.log(JSON.stringify(data));
//				self.show();
//				console.log("[ProgramCategoryTableView] getData() - success : ", data);
//				self.collection = new Backbone.Collection(data.content);
//				self.model = new Backbone.Model(data);
//				self.show();
//			}).success(function(){
//				loading.hide();
//				self.show();
//			});
		},
		
	});
	var packageTableView = '';
	var SearchVodPackagePopup = SearchVodPopup.extend({

		el : '#vod-package-select-popup',

		events : {
			'click #package-select-confirm': 'confirm',
			'click #package-select-cancel': 'cancel'
		},

		show: function(parameters) {
			console.log("[SearchPackagePopup] show() ");
			this.model = new Backbone.Model(parameters);
			this.$el.modal('show');
			
			packageTableView = packageTableView || new PackageTableView();
			packageTableView.getData(null);
		},

		confirm: function() {
			console.log("[SearchNoticePopup] confirm()");
			var items = packageTableView.getSelectedItem();
			if( items.length > 0) {
				confirmCallback(items);
			} else {
				this.$el.modal('hide');
			}
		}
	});
	
	var SvodProductRadioItemView = Marionette.ItemView.extend({
		tagName: 'tr',
		className: 'pointer',
	    template : '#search-svod-product-list-radio-item-tpl',

	});
	var SvodProductCheckboxItemView = Marionette.ItemView.extend({
		tagName: 'tr',
		className: 'pointer',
	    template : '#search-svod-product-list-checkbox-item-tpl',

	});
	var SvodProductEmptyView = Marionette.ItemView.extend({
		tagName: 'tr',
	    template : _.template("<td colspan=3>No Search Result</td>") 
	});
	
	var SvodProductTableView = VodTableView.extend({
		
		template : '#svod-product-list-tpl',
		getChildView: function() {
			if (buttonType === 'radio') {
				return SvodProductRadioItemView;
			} else {
				return SvodProductCheckboxItemView;
			} 
		},
	
		emptyView : SvodProductEmptyView,
		
		childViewContainer : '#svod-product-list-container',
		
		initialize: function() {
			console.log("[SvodPopup.TableView] initialize()");
//			App.svodTable.show(this);
//			this.render();
		},
		show: function() {
			console.log("[SvodPopup.TableView] show()");
//			this.render();
			App.svodTable.show(this);
			
			$(".checkbox-table input").not('.check-all').click(function(e) {
				e.stopPropagation();
			});
		},

		getData : function() {
			var self = this;	
			
			
			$.ajax({
				type: 'GET',
				url : '/'+App.ctx+'/search/getSvodSubscription',
				success: function(data) {
					self.collection = new Backbone.Collection(data);
					self.show();
				}
			});
		},
		
	});
	
	
	
	var svodProductTableView = '';
	var SearchSvodProductPopup = SearchVodPopup.extend({

		el : '#vod-subscription-select-popup',

		events : {
			'click #svod-product-select-confirm': 'confirm',
			'click #svod-product-select-cancel': 'cancel'
		},

		show: function(parameters) {
			console.log("[SearchSvodProductPopup] show() ");
			this.model = new Backbone.Model(parameters);
			this.$el.modal('show');
			
			svodProductTableView = svodProductTableView || new SvodProductTableView();
			svodProductTableView.getData(null);
		},

		confirm: function() {
			console.log("[SearchNoticePopup] confirm()");
			var items = svodProductTableView.getSelectedItem();
			if( items.length > 0) {
				confirmCallback(items);
			} else {
				this.$el.modal('hide');
			}
		}
	});
	

	var FullPackageRadioItemView = Marionette.ItemView.extend({
		tagName: 'tr',
		className: 'pointer',
	    template : '#search-full-package-list-radio-item-tpl',

	});
	var FullPackageCheckboxItemView = Marionette.ItemView.extend({
		tagName: 'tr',
		className: 'pointer',
	    template : '#search-full-package-list-checkbox-item-tpl',

	});
	var FullPackageEmptyView = Marionette.ItemView.extend({
		tagName: 'tr',
	    template : _.template("<td colspan=1>No Search Result</td>") 
	});
	
	var FullPackageTableView = VodTableView.extend({
		
		template : '#full-package-list-tpl',
		getChildView: function() {
			console.info("BUTTON TYPE: {}", buttonType);
			if (buttonType === 'radio') {
				return FullPackageRadioItemView;
			} else {
				return FullPackageCheckboxItemView;
			} 
		},
	
		emptyView : FullPackageEmptyView,
		
		childViewContainer : '#full-package-list-container',
		
		initialize: function() {
			console.log("[FullPackagePopup.TableView] initialize()");
//			App.svodTable.show(this);
//			this.render();
		},
		show: function() {
			console.log("[FullPackagePopup.TableView] show()");
//			this.render();
			App.fullPackageTable.show(this);
			
			$(".checkbox-table input").not('.check-all').click(function(e) {
				e.stopPropagation();
			});
		},

		getData : function() {
			var self = this;	
			
			
			$.ajax({
				type: 'GET',
				url : '/'+App.ctx+'/search/getFullPackage',
				success: function(data) {
					self.collection = new Backbone.Collection(data);
					self.show();
				}
			});
		},
		
	});
	
	
	
	var fullPackageTableView = '';
	var SearchFullPackagePopup = SearchVodPopup.extend({

		el : '#full-package-select-popup',

		events : {
			'click #full-package-select-confirm': 'confirm',
			'click #full-package-select-cancel': 'cancel'
		},

		show: function(parameters) {
			console.log("[SearchFullPackageProductPopup] show() ");
			this.model = new Backbone.Model(parameters);
			this.$el.modal('show');
			
			fullPackageTableView = fullPackageTableView || new FullPackageTableView();
			fullPackageTableView.getData(null);
		},

		confirm: function() {
			console.log("[SearchNoticePopup] confirm()");
			var items = fullPackageTableView.getSelectedItem();
			if( items.length > 0) {
				confirmCallback(items);
			} else {
				this.$el.modal('hide');
			}
		}
	});
	
	var MenuSvodProductRadioItemView = Marionette.ItemView.extend({
		tagName: 'tr',
		className: 'pointer',
	    template : '#search-menu-svod-product-list-radio-item-tpl',

	});
	var MenuSvodProductCheckboxItemView = Marionette.ItemView.extend({
		tagName: 'tr',
		className: 'pointer',
	    template : '#search-menu-svod-product-list-checkbox-item-tpl',

	});
	var MenuSvodProductEmptyView = Marionette.ItemView.extend({
		tagName: 'tr',
	    template : _.template("<td colspan=3>No Search Result</td>") 
	});
	
	var MenuSvodProductTableView = VodTableView.extend({
		
		template : '#menu-svod-product-list-tpl',
		getChildView: function() {
			console.info("BUTTON TYPE: {}", buttonType);
			if (buttonType === 'radio') {
				return MenuSvodProductRadioItemView;
			} else {
				return MenuSvodProductCheckboxItemView;
			} 
		},
	
		emptyView : MenuSvodProductEmptyView,
		
		childViewContainer : '#menu-svod-product-list-container',
		
		initialize: function() {
			console.log("[MenuSvodPopup.TableView] initialize()",this);
//			App.menuSvodTable.show(this);
			this.render();
		},
		show: function() {
			console.log("[MenuSvodPopup.TableView] show()",this);
//			this.render();
			App.menuSvodTable.show(this);
			
			$(".checkbox-table input").not('.check-all').click(function(e) {
				e.stopPropagation();
			});
		},

		getData : function(id) {

			var self =this;
			$.ajax({
				type: 'GET',
				url : '/'+App.ctx+'/search/getMenuSvodSubscription',
				data : { id: id },
				success: function(data) {
					self.collection = new Backbone.Collection(data);
					self.show();
				}
			});
		},
		
	});
	
	var menuSvodProductTableView = '';
	var SearchMenuSvodProductPopup = SearchVodPopup.extend({

		el : '#menu-vod-subscription-select-popup',

		events : {
			'click #menu-svod-product-select-confirm': 'confirm',
			'click #menu-svod-product-select-cancel': 'cancel'
		},

		show: function(parameters) {
			console.log("[SearchMenuSvodProductPopup] show() ", parameters);
			this.model = new Backbone.Model(parameters);
			console.log("[SearchMenuSvodProductPopup] show() ", this.model);
			this.$el.modal('show');
			
			menuSvodProductTableView = menuSvodProductTableView || new MenuSvodProductTableView();
			menuSvodProductTableView.getData(this.model.id);
		},

		confirm: function() {
			console.log("[SearchNoticePopup] confirm()");
			var items = menuSvodProductTableView.getSelectedItem();
			if( items.length > 0) {
				confirmCallback(items);
			} else {
				this.$el.modal('hide');
			}
		}
	});


	var SchannelProductRadioItemView = Marionette.ItemView.extend({
		tagName: 'tr',
		className: 'pointer',
	    template : '#search-schannel-product-list-radio-item-tpl',

	});
	var SchannelProductCheckboxItemView = Marionette.ItemView.extend({
		tagName: 'tr',
		className: 'pointer',
	    template : '#search-schannel-product-list-checkbox-item-tpl',

	});
	var SchannelProductEmptyView = Marionette.ItemView.extend({
		tagName: 'tr',
	    template : _.template("<td colspan=3>No Search Result</td>") 
	});
	
	var SchannelProductTableView = VodTableView.extend({
		
		template : '#schannel-product-list-tpl',
		getChildView: function() {
			console.info("BUTTON TYPE: {}", buttonType);
			if (buttonType === 'radio') {
				return SchannelProductRadioItemView;
			} else {
				return SchannelProductCheckboxItemView;
			} 
		},
	
		emptyView : SchannelProductEmptyView,
		
		childViewContainer : '#schannel-product-list-container',
		
		initialize: function() {
			console.log("[SvodPopup.TableView] initialize()");
//			App.svodTable.show(this);
//			this.render();
		},
		show: function() {
			console.log("[SchannelPopup.TableView] show()");
//			this.render();
			App.schannelTable.show(this);
			
			$(".checkbox-table input").not('.check-all').click(function(e) {
				e.stopPropagation();
			});
		},

		getData : function() {
			var self = this;	
			
			
			$.ajax({
				type: 'GET',
				url : '/'+App.ctx+'/search/getSchannelSubscription',
				success: function(data) {
					self.collection = new Backbone.Collection(data);
					self.show();
				}
			});
		},
		
	});
	
	
	
	var schannelProductTableView = '';
	var SearchSchannelProductPopup = SearchVodPopup.extend({

		el : '#channel-subscription-select-popup',

		events : {
			'click #schannel-product-select-confirm': 'confirm',
			'click #schannel-product-select-cancel': 'cancel'
		},

		show: function(parameters) {
			console.log("[SearchSchannelProductPopup] show() ");
			this.model = new Backbone.Model(parameters);
			this.$el.modal('show');
			
			schannelProductTableView = schannelProductTableView || new SchannelProductTableView();
			schannelProductTableView.getData(null);
		},

		confirm: function() {
			console.log("[SearchNoticePopup] confirm()");
			var items = schannelProductTableView.getSelectedItem();
			if( items.length > 0) {
				confirmCallback(items);
			} else {
				this.$el.modal('hide');
			}
		}
	});
	
	var OttProductRadioItemView = Marionette.ItemView.extend({
		tagName: 'tr',
		className: 'pointer',
	    template : '#search-ott-product-list-radio-item-tpl',

	});
	var OttProductCheckboxItemView = Marionette.ItemView.extend({
		tagName: 'tr',
		className: 'pointer',
	    template : '#search-ott-product-list-checkbox-item-tpl',

	});
	var OttProductEmptyView = Marionette.ItemView.extend({
		tagName: 'tr',
	    template : _.template("<td colspan=3>No Search Result</td>") 
	});
	
	var OttProductTableView = VodTableView.extend({
		
		template : '#ott-product-list-tpl',
		getChildView: function() {
			console.info("BUTTON TYPE: {}", buttonType);
			if (buttonType === 'radio') {
				return OttProductRadioItemView;
			} else {
				return OttProductCheckboxItemView;
			} 
		},
	
		emptyView : OttProductEmptyView,
		
		childViewContainer : '#ott-product-list-container',
		
		initialize: function() {
			console.log("[OttPopup.TableView] initialize()");
//			App.svodTable.show(this);
//			this.render();
		},
		show: function() {
			console.log("[OttPopup.TableView] show()");
//			this.render();
			App.ottTable.show(this);
			
			$(".checkbox-table input").not('.check-all').click(function(e) {
				e.stopPropagation();
			});
		},

		getData : function() {
			var self = this;	
			
			$.ajax({
				type: 'GET',
				url : '/'+App.ctx+'/additional-product/ott/search?search=',
				success: function(data) {
					self.collection = new Backbone.Collection(data);
					self.show();
				}
			});
		},
		
	});
	
	
	
	var ottProductTableView = '';
	var SearchOttProductPopup = SearchVodPopup.extend({

		el : '#ott-select-popup',

		events : {
			'click #ott-product-select-confirm': 'confirm',
			'click #ott-product-select-cancel': 'cancel'
		},

		show: function(parameters) {
			console.log("[SearchOttProductPopup] show() ");
			this.model = new Backbone.Model(parameters);
			this.$el.modal('show');
			
			ottProductTableView = ottProductTableView || new OttProductTableView();
			ottProductTableView.getData(null);
		},

		confirm: function() {
			console.log("[SearchNoticePopup] confirm()");
			var items = ottProductTableView.getSelectedItem();
			if( items.length > 0) {
				confirmCallback(items);
			} else {
				this.$el.modal('hide');
			}
		}
	});
	
	var MenuShortcutRadioItemView = Marionette.ItemView.extend({
		tagName: 'tr',
		className: 'pointer',
	    template : '#search-menu-shortcut-list-radio-item-tpl',

	});
	var MenuShortcutCheckboxItemView = Marionette.ItemView.extend({
		tagName: 'tr',
		className: 'pointer',
	    template : '#search-menu-shortcut-list-checkbox-item-tpl',

	});
	var MenuShortcutEmptyView = Marionette.ItemView.extend({
		tagName: 'tr',
	    template : _.template("<td colspan=7>No Search Result</td>") 
	});
	
	var MenuShortcutTableView = VodTableView.extend({
		
		template : '#menu-shortcut-list-tpl',
		getChildView: function() {
			if (buttonType === 'radio') {
				return MenuShortcutRadioItemView;
			} else {
				return MenuShortcutCheckboxItemView;
			} 
		},
	
		emptyView : MenuShortcutEmptyView,
		
		childViewContainer : '#menu-shortcut-list-container',
		
		initialize: function() {
			console.log("[MenuShortcutPopup.TableView] initialize()",this);
			App.menuShortcutTable.show(this);
			this.render();
		},
		show: function() {
			console.log("[MenuShortcutPopup.TableView] show()",this);
			this.render();
			App.menuShortcutTable.show(this);
			$(".checkbox-table input").not('.check-all').click(function(e) {
				e.stopPropagation();
			});
		},

		getData : function(id) {

			var self =this;
			$.ajax({
				type: 'GET',
				url : '/'+App.ctx+'/search/getMenuShortcut',
				data : { id: id },
				success: function(data) {
					self.collection = new Backbone.Collection(data);
					self.show();
				}
			});
		},
		
	});
	
	var menuShortcutTableView = '';
	var SearchMenuShortcutPopup = SearchVodPopup.extend({

		el : '#menu-shortcut-select-popup',

		events : {
			'click #menu-shortcut-select-confirm': 'confirm',
			'click #menu-shortcut-select-cancel': 'cancel'
		},

		show: function(parameters) {
			console.log("[SearchMenuShortcutPopup] show() ", parameters);
			this.model = new Backbone.Model(parameters);
			console.log("[SearchMenuShortcutPopup] show() ", this.model);
			this.$el.modal('show');
			
			menuShortcutTableView = menuShortcutTableView || new MenuShortcutTableView();
			menuShortcutTableView.getData(parameters);
		},

		confirm: function() {
			console.log("[SearchMenuShortcutPopup] confirm()");
			var items = menuShortcutTableView.getSelectedItem();
			if( items.length > 0) {
				confirmCallback(items);
			} else {
				this.$el.modal('hide');
			}
		}
	});
	
	var searchVodPopup = '';
	var searchChannelPopup = '';
	var searchAppPopup = '';
	var searchNoticePopup = '';
	var searchVodPackagePopup = '';
	var searchSvodProductPopup = '';
	var searchFullPackagePopup = '';
	var searchMenuSvodProductPopup = '';
	var searchSchannelProductPopup = '';
	var searchOttProductPopup = '';
	var searchCategoryPopup = '';
	var searchCategoryDisplayPopup = '';
	var searchProgramCategoryPopup = '';
	var searchUserGroupPopup = '';
	var searchPromotionGroupPopup = '';
	var searchMenuPromotionGroupPopup = '';
	
	var searchContentsPromotionPopup = '';
	var searchRecommendProgramPopup = '';
    var searchCategoryProgramPopup = '';
    
    var searchLimitProgramCategoryPopup = '';
    var searchMenuShortcutPopup = '';


	var getView = function(action, callback, parameters){
		console.log("[SearchContentView] getView() Type: ", action);
		console.log("[SearchContentView] getView() Parameters: ", parameters);

		confirmCallback = callback;

		if(action == null) {
			action = $("select#action option:selected").val();
		}

		var args = action.split(':');
		var type =args[0];
		buttonType = args[1];
		arg_1 = args[2];
		if (type == "program") {
			selectedCheckbox = [];
			searchVodPopup = searchVodPopup || new SearchVodPopup();
			searchVodPopup.show();
		} else if (type == "channel") {
			searchChannelPopup = searchChannelPopup || new SearchChannelPopup();
			searchChannelPopup.show();
		} else if (type == "mail") {
			searchNoticePopup = searchNoticePopup || new SearchNoticePopup();
			searchNoticePopup.show();
		} else if (type == "vod-subscription") {
			searchSvodProductPopup = searchSvodProductPopup || new SearchSvodProductPopup();
			searchSvodProductPopup.show(parameters);
		} else if (type == "menu-svod"){
			searchMenuSvodProductPopup = searchMenuSvodProductPopup || new SearchMenuSvodProductPopup();
			searchMenuSvodProductPopup.show(parameters);
		} else if (type == "full-package"){
			searchFullPackagePopup = searchFullPackagePopup || new SearchFullPackagePopup();
			searchFullPackagePopup.show(parameters);
		} else if (type == "channel-subscription") {
			searchSchannelProductPopup = searchSchannelProductPopup || new SearchSchannelProductPopup();
			searchSchannelProductPopup.show(parameters);
		} else if (type == "ott") {
			searchOttProductPopup = searchOttProductPopup || new SearchOttProductPopup();
			searchOttProductPopup.show(parameters);
		} else if (type == "vod-package") {
			searchVodPackagePopup = searchVodPackagePopup || new SearchVodPackagePopup();
			searchVodPackagePopup.show(parameters);
		} else if (type == "category") {
			searchCategoryPopup = searchCategoryPopup || new SearchCategoryPopup();
			searchCategoryPopup.show(parameters);
		}else if (type == "category-display") {
			searchCategoryDisplayPopup = searchCategoryDisplayPopup || new SearchCategoryDisplayPopup();
			searchCategoryDisplayPopup.show(parameters);
		} else if (type =="limit_program_category"){
			searchLimitProgramCategoryPopup = searchLimitProgramCategoryPopup || new SearchLimitProgramCategoryPopup();
			searchLimitProgramCategoryPopup.show(parameters);
		} 
		else if (type == "program_category") {
			searchProgramCategoryPopup = searchProgramCategoryPopup || new SearchProgramCategoryPopup();
			searchProgramCategoryPopup.show(parameters);
		} else if (type == "appstore") {
			searchAppPopup = searchAppPopup || new SearchAppPopup();
			searchAppPopup.show();
		} else if(type == "usergroup") {
			searchUserGroupPopup = searchUserGroupPopup || new SearchUserGroupPopup();
			searchUserGroupPopup.show();
		} else if(type == "promotiongroup") {
			searchPromotionGroupPopup = searchPromotionGroupPopup || new SearchPromotionGroupPopup();
			searchPromotionGroupPopup.show();
		} else if(type == "menupromotiongroup") {
			searchMenuPromotionGroupPopup = searchMenuPromotionGroupPopup || new SearchMenuPromotionGroupPopup();
			searchMenuPromotionGroupPopup.show();
		} else if ( type == 'contents-promotion') {
			searchContentsPromotionPopup = searchContentsPromotionPopup || new SearchContentsPromotionPopup();
			searchContentsPromotionPopup.show();
		} else if ( type == 'recommend_program') {
			searchRecommendProgramPopup = searchRecommendProgramPopup || new SearchRecommendProgramPopup();
			searchRecommendProgramPopup.show();
        } else if ( type == 'category_program') {
            searchCategoryProgramPopup = searchCategoryProgramPopup || new SearchCategoryProgramPopup();
            searchCategoryProgramPopup.show(parameters);
		} else if ( type == 'menu-shortcut'){
			searchMenuShortcutPopup = searchMenuShortcutPopup || new SearchMenuShortcutPopup();
			searchMenuShortcutPopup.show(parameters);
		} else if (type == "blank") {
			$("#actionUrl").val("");
			$("#actionName").val("");
			$("#action").val("");
		}
	};

	return {
		getView : getView
	};

});
