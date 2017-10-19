<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@ include file="/WEB-INF/views/includes/taglibs.jsp"%>

<!doctype html>
<!--[if IE 9 ]><html class="ie ie9" lang="ko" class="no-js"> <![endif]-->
<!--[if !(IE)]><!-->
 <html lang="en" class="no-js">
 <!--<![endif]-->

<html>
<head>
	<title>SDP | <tiles:getAsString name="title" /></title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<!-- CSS -->
	<link href="js/lib/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
	<link href="js/lib/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css">
	<link href="css/_theme/main.css" rel="stylesheet" type="text/css">
	<link href="css/navbar.css" rel="stylesheet" type="text/css">
</head>
<body class="demo-only-page-blank">
	<!-- wrapper -->
	<div class="wrapper">
		<!-- navbar -->
		<tiles:insertAttribute name="navbar" />
		<div class="bottom">
			<div class="container">
				<div class="row">
					<!-- sidebar -->
					<div class="col-md-2 left-sidebar">
						<!-- main-nav -->
						<tiles:insertAttribute name="sidebar" />
						<div class="sidebar-minified js-toggle-minified">
							<i class="fa fa-angle-left"></i>
						</div>
					</div>
					<!-- content-wrapper -->
					<div class="col-md-10 content-wrapper">
						<!-- breadcrumb / top-content -->
						<!-- main -->
						<div class="content">
							<div class="main-header">
								<h2><tiles:getAsString name="title" /></h2>
								<em><tiles:getAsString name="description" /></em>
							</div>
							<!-- content -->
							<tiles:insertAttribute name="content" />
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="push-sticky-footer"></div>
	</div>
	<!-- footer -->
	<tiles:insertAttribute name="footer" />

	<!-- modal -->
	<tiles:insertAttribute name="add-modal" />
	<tiles:insertAttribute name="alert-modal" />
							
	<!-- javascript -->
	<script src="${lib}/requirejs/require.js"></script>
	<script type="text/javascript">
		// Load common code that includes config, then load the app logic for this page.
		require([ '<tiles:getAsString name="main.js" />' ], function() {
			require([ '<tiles:getAsString name="app.js" />' ], function(App) {
				App.start();
			});
		});
	</script>
</body>
</html>
