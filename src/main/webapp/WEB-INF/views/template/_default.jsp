<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@ include file="../includes/taglibs.jsp"%>
<!doctype html>
<html lang="en">
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Windmill | <tiles:getAsString name="title" /></title>

        <!-- Le styles -->
        <link href="${lib}/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />
        <link href="${lib}/bootstrap/css/bootstrap-responsive.css" rel="stylesheet" type="text/css" />
        <link href="${lib}/bootstrap/css/bootstrap-datepicker.css" rel="stylesheet" type="text/css" />
        <link href="${lib}/bootstrap/css/bootstrap-timepicker.css" rel="stylesheet" type="text/css" />
        <link href="${css}/unicorn.main.css" rel="stylesheet" type="text/css" />
        <link href="${css}/unicorn.grey.css" rel="stylesheet" type="text/css" />
        <link href="${css}/admin.ui.css" rel="stylesheet" type="text/css" />
        <link href="${css}/admin.ui.gritter.css" rel="stylesheet" type="text/css" />

        <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!-- [if lt IE 9]>
        <script src="${lib}/html5shiv/html5shiv.js"></script>
        <[endif] -->
    </head>
    <body>
        <!-- Header : Top menu -->
        <tiles:insertAttribute name="navigation" />

        <!-- Sidebar : Left menu -->
        <tiles:insertAttribute name="sidebar" />

        <!-- Content -->
        <div id="content">
            <div id="content-header">
				<div class="container-fluid">
					<h1>
						<tiles:getAsString name="menu" />
					</h1>
					<div id="request-date"  class="input-append date" data-provider="datepicker">
						<input size="12" type="text" readonly>
						<span class="add-on"><i class="icon-calendar"></i></span> 
					</div>
				</div>
			</div>
            <div id="breadcrumb">
                <a href="#" title="Go to Home" class="tip-bottom"><i class="icon-home"></i>Home</a>
                <a href="#"><tiles:getAsString name="title" /></a>
                <a href="#" class="current"><tiles:getAsString name="menu" /></a>
            </div>
            <tiles:insertAttribute name="content" />
        </div>

        <!-- Le javascript -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="${lib}/require/require.js"></script>
        <script type="text/javascript">
            // Load common code that includes config, then load the app logic for this page.
            require(['<tiles:getAsString name="main.js" />'], function() {
                require(['<tiles:getAsString name="app.js" />'], function(App) {
                    var appName = '<tiles:getAsString name="app.js" />'.split("/").pop();
                    console.log('[' + appName + '] App start');
                    App.start();
                });
            });
        </script>
    </body>
</html>