<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@ include file="../includes/taglibs.jsp"%>

<nav class="main-nav">
	<ul id="main-menu" class="main-menu">
		<security:authorize ifNotGranted="ROLE_USER1,ROLE_USER2,ROLE_USER3">
		
		<%-- <li>
			<a href="#" class="js-sub-menu-toggle">
			<i class="fa fa-home fa-fw"></i><span class="text">Platform Information</span><i class="toggle-icon fa fa-angle-left"></i></a>
			<ul class="sub-menu">
			<li><a href="${ctx}/platform/platform"><span class="text">Viettel</span></a></li>
			<li><a href="${ctx}/platform/area"><span class="text">Area</span></a></li>
 			<li><a href="${ctx}/platform/user-group"><span class="text">User Group</span></a></li>
			</ul></li>
		<li>
			<a href="#" class="js-sub-menu-toggle">
			<i class="fa fa-list-ul fa-fw"></i><span class="text">Menu Management</span><i class="toggle-icon fa fa-angle-left"></i></a>
			<ul class="sub-menu">
				<li><a href="${ctx}/menu/menu-group"><span class="text">Menu Group</span></a></li>
				<li><a href="${ctx}/menu/menu"><span class="text">Menu Composition</span></a></li>
			</ul></li>
		<li>
			<a href="#" class="js-sub-menu-toggle">
			<i class="fa fa-film fa-fw"></i><span class="text">Content Management</span><i class="toggle-icon fa fa-angle-left"></i></a>
			<ul class="sub-menu">
				<li><a href="${ctx}/content/content-provider"><span class="text">Content Provider</span></a></li>
				<li><a href="${ctx}/content/vod"><span class="text">VOD Infomation</span></a></li>
				<li><a href="${ctx}/content/vod-category"><span class="text">VOD Category </span></a></li>
				<li><a href="${ctx}/content/application"><span class="text">Data Broadcast</span></a></li>	
			</ul></li>
		</security:authorize>
		<security:authorize ifNotGranted="ROLE_USER2,ROLE_USER3">
		<li>
			<a href="#" class="js-sub-menu-toggle">
			<i class="fa fa-th-large fa-fw"></i><span class="text">Channel Management</span><i class="toggle-icon fa fa-angle-left"></i></a>
			<ul class="sub-menu">
				<li><a href="${ctx}/channel/channel"><span class="text">Channel Information</span></a></li>
				<li><a href="${ctx}/channel/promo"><span class="text">Contents Promotion Channel</span></a></li>
			</ul></li>	
		</security:authorize>
		<security:authorize ifNotGranted="ROLE_USER1,ROLE_USER3">
		<li><a href="#" class="js-sub-menu-toggle">
			<i class="fa fa-cube fa-fw"></i><span class="text">Product Management</span><i class="toggle-icon fa fa-angle-left"></i></a>
			<ul class="sub-menu">
				<li><a href="${ctx}/product/vod-package"><span class="text">VOD Package</span></a></li>
				<li><a href="${ctx}/product/vod-subscription"><span class="text">VOD Monthly Subscription</span></a></li>
				<li><a href="${ctx}/product/channel-package"><span class="text">Channel Package</span></a></li>
				<li><a href="${ctx}/product/channel-subscription"><span class="text">Channel Monthly Subscription</span></a></li>
				<li><a href="${ctx}/product/bundle-subscription"><span class="text">Bundle Monthly Subcription</span></a></li>
				<li><a href="${ctx}/product/full-package"><span class="text">Full Package</span></a></li>
				<li><a href="${ctx}/product/product-3G"><span class="text">3G Product</span></a></li> 
			</ul></li>
		</security:authorize>
		<security:authorize ifNotGranted="ROLE_USER1,ROLE_USER2,ROLE_USER3">
		<li><a href="#" class="js-sub-menu-toggle">
			<i class="fa fa-cube fa-fw"></i><span class="text">Additional-Product Management</span><i class="toggle-icon fa fa-angle-left"></i></a>
			<ul class="sub-menu">
				<li><a href="${ctx}/additional-product/flexi"><span class="text">FLEXI UPSELLING</span></a></li>
				<li><a href="${ctx}/additional-product/catchup"><span class="text">Catch Up</span></a></li>
				<li><a href="${ctx}/additional-product/npvr"><span class="text">NPVR</span></a></li>
				<li><a href="${ctx}/additional-product/ott"><span class="text">OTT</span></a></li>
			</ul></li> --%>
		<li><a href="#" class="js-sub-menu-toggle">
			<i class="fa fa-image fa-fw"></i><span class="text">Product Management</span><i class="toggle-icon fa fa-angle-left"></i></a>
			<ul class="sub-menu">
				<%-- <li><a href="${ctx}/promotion/template"><span class="text">IP Promotion</span></a></li>
				<li><a href="${ctx}/promotion/banner-promotion"><span class="text">Banner Promotion</span></a></li>
				<li><a href="${ctx}/promotion/banner-prev"><span class="text">Banner Promotion (OLD)</span></a></li>
				<li><a href="${ctx}/promotion/package-promotion"><span class="text">Package Promotion</span></a></li>
				<li><a href="${ctx}/promotion/ip-promotion"><span class="text">IP Group Promotion</span></a></li>
				<li><a href="${ctx}/promotion/special-offer"><span class="text">Service Popup</span></a></li> --%>
				<li><a href="${ctx}/promotion/product-option"><span class="text">Product And Option Table</span></a></li>
				<%--<li><a href="${ctx}/promotion/iframe"><span class="text">IFrame</span></a></li> --%>
			</ul></li>	
			</security:authorize>		
		<%-- <security:authorize ifNotGranted="ROLE_USER1,ROLE_USER2">
		<li>
			<a href="#" class="js-sub-menu-toggle">
				<i class="fa fa-rss fa-fw"></i><span class="text">Announcement Management</span><i class="toggle-icon fa fa-angle-left"></i>
			</a>
			<ul class="sub-menu">
				<li><a href="${ctx}/notice/total-notice"><span class="text">All</span></a></li>
				<li><a href="${ctx}/notice/general-notice"><span class="text">General Announcement</span></a></li>
				<li><a href="${ctx}/notice/event-notice"><span class="text">Event Annoucement</span></a></li>
				<li><a href="${ctx}/notice/channel-notice"><span class="text">Channel Annoucement (Event Promotion)</span></a></li>
				<li><a href="${ctx}/notice/faq-notice"><span class="text">FAQ Announcement (User Manual)</span></a></li>
				<li><a href="${ctx}/notice/usage-notice"><span class="text">Usage Announcement (User Guide)</span></a></li>
				<li><a href="${ctx}/notice/custom-notice"><span class="text">Custom Announcement</span></a></li>
			</ul>
		</li>
		</security:authorize>
		
		<security:authorize ifAnyGranted="ROLE_ADMIN">
		<li><a href="#" class="js-sub-menu-toggle">
			<i class="fa fa-gear fa-fw"></i><span class="text">System Management</span><i class="toggle-icon fa fa-angle-left"></i></a>
			<ul class="sub-menu">
				<li><a href="${ctx}/management/admin"><span class="text">Administrator  Information</span></a></li>
				<li><a href="${ctx}/management/authority"><span class="text">Administrator Permission Management</span></a></li>
				<li><a href="${ctx}/management/task"><span class="text">Transmission Status</span></a></li>
				<li><a href="${ctx}/management/job-task"><span class="text">Job Task History Status</span></a></li>
				<li><a href="${ctx}/management/vod-status"><span class="text">VOD Linked status</span></a></li>
				<li><a href="${ctx}/system/property"><span class="text">SDP Property</span></a></li>
				<li><a href="${ctx}/app/security"><span class="text">App Security Property</span></a></li>
				<li><a href="${ctx}/blocked-ip/security"><span class="text">Blocked IP</span></a></li>
				<li><a href="${ctx}/management/sms-message"><span class="text">SMS Message Template</span></a>
				<li><a href="${ctx}/management/new"><span class="text">VOD 입수 현황</span></a></li>
			</ul></li>
		</security:authorize> --%>
	</ul>
</nav>
