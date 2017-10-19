//Filename: sidebar.js

define([ 'jquery' ], function($) {

	'use strict';

	console.log("[sidebar] load...");
	
	/************************
	/*	MAIN NAVIGATION
	/************************/

	$('.main-menu .js-sub-menu-toggle').click( function(e){

		e.preventDefault();

		var $li = $(this).parents('li');
		
		if( !$li.hasClass('active')){
			$li.find('.toggle-icon').removeClass('fa-angle-left').addClass('fa-angle-down');
			$li.addClass('active');
		}
		else {
			$li.find('.toggle-icon').removeClass('fa-angle-down').addClass('fa-angle-left');
			$li.removeClass('active');
		} 
	
		// $li.find('.sub-menu').slideToggle(300);
	});

	$('.js-toggle-minified').clickToggle(
		function() {
			$('.left-sidebar').addClass('minified');
			$('.content-wrapper').addClass('expanded');

			$('.left-sidebar .sub-menu')
			.css('display', 'none')
			.css('overflow', 'hidden'); 
			
			$('.sidebar-minified').find('i.fa-angle-left').toggleClass('fa-angle-right');
		},
		function() {
			$('.left-sidebar').removeClass('minified');
			$('.content-wrapper').removeClass('expanded');
			$('.sidebar-minified').find('i.fa-angle-left').toggleClass('fa-angle-right');
		}
	);

	// main responsive nav toggle
	$('.main-nav-toggle').clickToggle(
		function() {
			$('.left-sidebar').slideDown(300);
		},
		function() {
			$('.left-sidebar').slideUp(300);
		}
	);
	
	// 사이드바 메뉴 설정
	$("#main-menu").niceTree({
		allowMultiple : true,
		useCookies : false
	});

	var parser = document.createElement('a');
	parser.href = $(location).attr('href');

	$("#main-menu").niceTree('select', parser.pathname);
});
