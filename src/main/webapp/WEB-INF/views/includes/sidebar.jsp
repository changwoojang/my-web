<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@ include file="../includes/taglibs.jsp"%>

<nav class="main-nav">
	<ul id="main-menu" class="main-menu">
		<li>
			<a href="#" class="js-sub-menu-toggle">
			<i class="fa fa-home fa-fw"></i><span class="text">플랫폼 정보</span><i class="toggle-icon fa fa-angle-left"></i></a>
			<ul class="sub-menu">
				<li><a href="${ctx}/platform/platform"><span class="text">KCTV</span></a></li>
				<li><a href="${ctx}/platform/user-group"><span class="text">사용자 그룹</span></a></li>
			</ul></li>
		<li>
			<a href="#" class="js-sub-menu-toggle">
			<i class="fa fa-list-ul fa-fw"></i><span class="text">메뉴 관리</span><i class="toggle-icon fa fa-angle-left"></i></a>
			<ul class="sub-menu">
				<li><a href="${ctx}/menu/menu-group"><span class="text">메뉴 그룹</span></a></li>
				<li><a href="${ctx}/menu/menu"><span class="text">메뉴 구성</span></a></li>
			</ul></li>
		<li>
			<a href="#" class="js-sub-menu-toggle">
			<i class="fa fa-film fa-fw"></i><span class="text">컨텐츠 관리</span><i class="toggle-icon fa fa-angle-left"></i></a>
			<ul class="sub-menu">
				<li><a href="${ctx}/content/vod"><span class="text">VOD 정보</span></a></li>
				<li><a href="${ctx}/content/vod-category"><span class="text">VOD 카테고리 </span></a></li>
				<li><a href="${ctx}/content/application"><span class="text">데이터 방송</span></a></li>	
			</ul></li>
		<li>
			<a href="#" class="js-sub-menu-toggle">
			<i class="fa fa-th-large fa-fw"></i><span class="text">채널 관리</span><i class="toggle-icon fa fa-angle-left"></i></a>
			<ul class="sub-menu">
				<li><a href="${ctx}/channel/channel"><span class="text">채널 정보</span></a></li>
			</ul></li>	
		<li><a href="#" class="js-sub-menu-toggle">
			<i class="fa fa-cube fa-fw"></i><span class="text">상품 관리</span><i class="toggle-icon fa fa-angle-left"></i></a>
			<ul class="sub-menu">
				<li><a href="${ctx}/product/vod-package"><span class="text">VOD 패키지 상품</span></a></li>
				<li><a href="${ctx}/product/vod-subscription"><span class="text">VOD 월정액 상품</span></a></li>
				<li><a href="${ctx}/product/channel-subscription"><span class="text">채널 월정액 상품</span></a></li>
				<li><a href="${ctx}/product/bundle-subscription"><span class="text">통합 월정액 상품</span></a></li>
			</ul></li>
		<li><a href="#" class="js-sub-menu-toggle">
			<i class="fa fa-image fa-fw"></i><span class="text">프로모션 관리</span><i class="toggle-icon fa fa-angle-left"></i></a>
			<ul class="sub-menu">
				<li><a href="${ctx}/promotion/template"><span class="text">프로모션 템플릿</span></a></li>
				<li><a href="${ctx}/promotion/banner-promotion"><span class="text">배너 프로모션</span></a></li>
				<li><a href="${ctx}/promotion/package-promotion"><span class="text">패키지 프로모션</span></a></li>
				<li><a href="${ctx}/promotion/iframe"><span class="text">iFrame</span></a></li>
				<!-- <li><a href="${ctx}/promotion/loading"><span class="text">데이터 방송 로딩</span></a></li>   -->
			</ul></li>					
		<li><a href="#" class="js-sub-menu-toggle">
			<i class="fa fa-rss fa-fw"></i><span class="text">공지사항 관리</span><i class="toggle-icon fa fa-angle-left"></i></a>
			<ul class="sub-menu">
				<li><a href="${ctx}/notice/total-notice"><span class="text">전체 공지</span></a></li>
				<li><a href="${ctx}/notice/general-notice"><span class="text">일반 공지</span></a></li>
				<li><a href="${ctx}/notice/event-notice"><span class="text">이벤트 공지</span></a></li>
				<li><a href="${ctx}/notice/channel-notice"><span class="text">채널 공지</span></a></li>
			</ul></li>
		<li><a href="#" class="js-sub-menu-toggle">
			<i class="fa fa-gear fa-fw"></i><span class="text">시스템 관리</span><i class="toggle-icon fa fa-angle-left"></i></a>
			<ul class="sub-menu">
				<li><a href="${ctx}/management/admin"><span class="text">관리자 정보</span></a></li>
				<li><a href="${ctx}/management/authority"><span class="text">관리자 권한 관리</span></a></li>
				<li><a href="${ctx}/management/task"><span class="text">송출 현황</span></a></li>
				<%-- <li><a href="${ctx}/management/new"><span class="text">VOD 입수 현황</span></a></li> --%>
			</ul></li>	
	</ul>
</nav>
