<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@ include file="../includes/taglibs.jsp"%>

<%
	String username = (String) session.getAttribute("username");
%>
<div class="top-bar">
	<div class="container">
		<div class="row">
			<div class="col-md-2">
				<a href="${ctx}" class="btn btn-link"><span class="logo">LF product Management</span></a>
			</div>
			<div class="col-md-10">
				<div class="row">
					<div class="col-md-3">
					</div>
					<div class="col-md-9">
						<div class="top-bar-right">
							<!-- responsive menu bar icon -->
							<a href="#" class="hidden-md hidden-lg main-nav-toggle"><i class="fa fa-bars"></i></a>
							<!-- logged user and the menu -->
							<div class="logged-user">
								<div class="btn-group">
									<a href="#" class="btn btn-link dropdown-toggle" data-toggle="dropdown">
									<i class="fa fa-user"></i>&nbsp; <span class="name">ADMIN</span>
									</a>
								</div>
							</div>
							<div>
								<form class="form-horizontal" action="${ctx}/logout" method="post">
									<sec:csrfInput />
									<button class="fa fa-power-off">Logout</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
