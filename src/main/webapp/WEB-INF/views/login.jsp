<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@ include file="./includes/taglibs.jsp"%>
<%--<%@page import="nl.captcha.Captcha"%>--%>
<%
    String ctx = request.getContextPath();   //콘텍스트명 얻어오기.    
%>
<!doctype html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="ko" class="no-js"> <!--<![endif]-->
<head>
	<title>SDP | Login</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	
	<!-- CSS -->
	<link href="js/lib/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
	<link href="js/lib/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css">
	<link href="css/_theme/ui-elements.css" rel="stylesheet" type="text/css">
	<link href="css/_theme/main.css" rel="stylesheet" type="text/css">
	<link href="css/login.css" rel="stylesheet" type="text/css">

</head>
<body>
	<div class="wrapper full-page-wrapper page-login text-center">
		<div class="inner-page">
			<div class="login-box center-block">
				<p class="title">LF Product Management</p>
				<hr/>
				<div class="row">
					<div class="col-md-6">
						<div class="row">
							<img class="col-md-12 logo" src="${img}/logo.jpg" alt="logo" />
							<%-- <img class="col-md-12 logo" src="http://placehold.it/300x85&text=VIETTEL" alt="logo" />  --%>
							<%-- <img class="col-md-12 logo" src="${img}/kctv_logo.jpg" alt="logo" /> --%>
						</div>
						<c:if test="${not empty sessionScope.SPRING_SECURITY_LAST_EXCEPTION}">
							<div id="login-error">
								<div class="alert alert-danger alert-dismissable">
									<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
									<label class="error">Not a valid user</label>
								</div>
							</div>
							<c:remove scope="session" var="SPRING_SECURITY_LAST_EXCEPTION"/>
						</c:if>
						<div id="form-error">
							<div class="alert alert-danger alert-dismissable">
								<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<form id="login-form" class="form-horizontal" action="<c:url value="/j_security_check"/>" method="post">
							<sec:csrfInput />
							<div class="form-group">
								<label for="username" class="control-label sr-only">Username</label>
								<div class="col-sm-12">
									<div class="input-group">
										<span class="input-group-addon"><i class="fa fa-user"></i></span><input name="j_username" type="text" placeholder="ID" class="form-control">
									</div>
								</div>
							</div>
							<div class="form-group">
								<label for="password" class="control-label sr-only">Password</label>
								<div class="col-sm-12">
									<div class="input-group">
										<span class="input-group-addon"><i class="fa fa-lock"></i></span><input name="j_password" type="password" placeholder="Password" class="form-control">
									</div>
								</div>
							</div>

							<%--<img style="width: 100%" src="<%=ctx%>/captcha"><br />

							<div class="form-group">
								<div class="col-sm-12">
									<div class="input-group">
							    		<span class="input-group-addon"><i class="fa fa-lock"></i></span><input name="answer" type="text" placeholder="answer" class="form-control">
							    	</div>
							    </div>
							</div>
							--%>
							<!-- reCaptcha function -->
							<!-- <div id="html_element"></div> -->
							<button class="btn btn-default btn-block btn-login">
								<i class="fa fa-arrow-circle-o-right"></i> Login
							</button>
						</form>
						<!-- reCaptcha function -->
						<!-- <script src='https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit&hl=en' async defer ></script> -->
					</div>
				</div>
				<hr/>
			</div>
		</div>
		<div class="push-sticky-footer"></div>
	</div>
	
	<!-- footer -->
	<%@ include file="./includes/footer.jsp"%>

	<!-- javascript -->
	<script data-main="${js}/login/login.app" src="${lib}/requirejs/require.js"></script>

</body>
</html>
