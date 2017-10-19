<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@ include file="/WEB-INF/views/includes/taglibs.jsp"%>

<!doctype html>
<!--[if IE 9 ]><html class="ie ie9" lang="ko" class="no-js"> <![endif]-->
<!--[if !(IE)]><!-->
 <html lang="en" class="no-js"> 
<!--<![endif]-->
<html>

<%-- <c:set var="titleKey"><tiles:getAsString name="titleKey" /></c:set> --%>

<head>
<title>SDP | <tiles:getAsString name="title" /></title>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	
	
	<!-- CSS -->
	<link href="${lib}/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
	<link href="${lib}/bootstrap/css/bootstrap-timepicker.css" rel="stylesheet" type="text/css" />
	<link href="${lib}/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css">
	<link href="${css}/_theme/main.css" rel="stylesheet" type="text/css">
	<link href="${css}/navbar.css" rel="stylesheet" type="text/css">
	<link href="${css}/admin.custom.css" rel="stylesheet" type="text/css">
</head>
<body class="demo-only-page-blank">
	<!-- wrapper -->
	<div class="wrapper full-page-wrapper page-error text-center">
		<div class="inner-page">
			<h1>
				<span class="clearfix title">
					<span class="number"><tiles:getAsString name="code" /></span>
					<span class="text">Sorry...<br/><tiles:getAsString name="title" /></span>
				</span>
			</h1>
			
			<p><tiles:getAsString name="description" /></p>
			<p>Please contact your system administrator.</p><br/>
			<p>
				<a href="javascript:history.go(-1)" class="btn btn-custom-primary"><i class="fa fa-arrow-left"></i>Go Back</a>
				<a href="${ctx}" class="btn btn-primary"><i class="fa fa-home"></i> Home</a>
			</p>
		</div>
		<div class="push-sticky-footer"></div>
	</div>

	<footer class="footer" style="height:34px;"> &copy; 2015 SDP Management </footer>

	<!-- javascript -->
	<script src="${lib}/requirejs/require.js"></script>
	<script src="${lib}/jquery/jquery.js"></script>
	<script src="${lib}/modernizr/modernizr.js"></script>
</body>
</html>
