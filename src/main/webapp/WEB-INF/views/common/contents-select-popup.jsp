<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@ include file="/WEB-INF/views/includes/taglibs.jsp"%>
	
<!-- program 선택 modal-->
<div id="program-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"	aria-hidden="true">&times;</button>
				<h4 class="modal-title">컨텐츠 선택</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-vod-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="program-popup-confirm" type="button" class="btn btn-primary"	>확인</button>
				<button id="" type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<script id="vod-list-tpl" type="text/template"> 
	<div class="row top-content">
		<div class="col-md-2">
			<select id="programType" name="type" class="form-control">
				<option value="">ALL</option>
				<option id="single" value="single">RVOD</option>
				<option id="subscription" value="subscription">월정액</option>
			</select>
		</div>
		<div class="col-md-2">
			<select id="format" name="format" class="form-control">
				<option value="">ALL</option>
				<option id="hd" value="hd">HD</option>
				<option id="sd" value="sd">SD</option>
			</select>
		</div>
		<div class="col-md-2">
			<select id="searchType" name="searchType" class="form-control">
				<option id="vodName" value="vodName">vod 명</option>
				<option id="assetId" value="assetId">asset ID</option>
			</select>
		</div>

		<div class="col-md-3">
			<div id="tour-searchbox" class="input-group searchbox">
				<input id="search-value" type="search" class="form-control"> 
				<span class="input-group-btn">
					<span class="input-group-btn">
						<button id="search-btn" class="btn btn-success" type="button">
							<i class="fa fa-search"></i>
						</button>
				</span>
			</div>
		</div>
	</div>
	<form id="vod-list" class="form-horizontal">
		<table class="table table-hover table-striped table-bordered">
			<thead>
				<tr>
					<th width="20px"></th>
					<th>타입</th>
					<th>타이틀</th>
					<th>포맷</th>
					<th>가격</th>
					<th>라이센스</th>
					<th>공급자</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody id="vod-list-container">

			</tbody>
		</table>
		{{#if content}} 
		<div class="row">
			{{#pagination number startPage endPage totalPages}}
			<div class="dataTables_paginate paging_bootstrap">
				<ul class="pagination borderless">
					{{#if startFromFirstPage}} 
			
					{{/if}} 
					{{#unless startFromFirstPage}}
						<li class="prev"><a href="#" id="board-prevBlock">←</a></li> 
					{{/unless}} 
			
					{{#each pages}} 
						{{#if isCurrent}}
							<li class='active'><a href="#">{{page}}</a></li> 
						{{/if}}
						{{#unless isCurrent}}
							<li><a href="#" id='board-page' data-pageNum='{{page}}'>{{page}}</a></li>
						{{/unless}} 
					{{/each}} 
			
					{{#if endAtLastPage}}
						<li></li> 
					{{/if}} 
					{{#unless endAtLastPage}}
						<li class="next"><a href="#" id="board-nextBlock">→</a></li> 
					{{/unless}}
				</ul>
			</div>
			{{/pagination}}
		</div>
		{{/if}} 
	</form>
</script>

<script id="vod-list-item-checkbox-tpl" type="text/template">
	<td class="checkbox-table"><input name="board-check" id="board-check" type="checkbox" value="{{id}}"></td>
	<td><span class="pull-left">{{type}}</span></td>
	<td><span class="pull-left">{{title}}</span> <br> <span class='pull-left'>[{{assetId}}]</span></td>
	<td><span class="pull-left">{{format}}</span></td>
	<td><span class="pull-left">{{price}}</span></td>
	<td><span class="pull-left">{{license}}</td>
	<td><span class="pull-left">{{providerName}}</td>
	<td><span class="pull-left">{{status}}</td>
</script>

<script id="vod-list-item-radio-tpl" type="text/template">
	<td class="checkbox-table"><input name="board-check" id="board-check" type="radio" value="{{id}}"></td>
	<td><span class="pull-left">{{type}}</span></td>
	<td><span class="pull-left">{{title}}</span> <br> <span class='pull-left'>[{{assetId}}]</span></td>
	<td><span class="pull-left">{{format}}</span></td>
	<td><span class="pull-left">{{price}}</span></td>
	<td><span class="pull-left">{{license}}</td>
	<td><span class="pull-left">{{providerName}}</td>
	<td><span class="pull-left">{{status}}</td>
</script>
	
	
<!-- channel 선택 modal -->
<div id="channel-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title">채널 선택</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-channel-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="channel-popup-confirm" type="button" class="btn btn-primary"> 확인</button>
				<button id="" type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<script id="ch-list-tpl" type="text/templete">
	<div class="row top-content">
		<div class="col-md-4">
			<div id="tour-searchbox" class="input-group searchbox">
				<input id="search-value" type="search" class="form-control" placeholder="채널명"> <span class="input-group-btn">
					<span class="input-group-btn">
						<button id="search-btn" class="btn btn-success" type="button"><i class="fa fa-search"></i> </button>
					</span>
				</span>
			</div>
		</div>
	</div>
	<form id="ch-list">
		<table class="table table-hover table-striped table-bordered">
			<thead>
				<tr>
					<th style="width: 30px;"></th>
					<th width="20%">채널타입</th>
					<th width="40%">채널명</th>
					<th width="20%">채널 ID</th>
					<th width="20%">소스 ID</th>
				</tr>
			</thead>
			<tbody id="ch-list-container">
			</tbody>
		</table>
		<div class="row">
			{{#pagination number startPage endPage totalPages}}
			<div class="dataTables_paginate paging_bootstrap">
				<ul class="pagination borderless">
					{{#if startFromFirstPage}} 
			
					{{/if}} 
					{{#unless startFromFirstPage}}
						<li class="prev"><a href="#" id="board-prevBlock">←</a></li> 
					{{/unless}} 
			
					{{#each pages}} 
						{{#if isCurrent}}
							<li class='active'><a href="#">{{page}}</a></li> 
						{{/if}}
						{{#unless isCurrent}}
							<li><a href="#" id='board-page' data-pageNum='{{page}}'>{{page}}</a></li>
						{{/unless}} 
					{{/each}} 
			
					{{#if endAtLastPage}}
						<li></li> 
					{{/if}} 
					{{#unless endAtLastPage}}
						<li class="next"><a href="#" id="board-nextBlock">→</a></li> 
					{{/unless}}
				</ul>
			</div>
			{{/pagination}}
		</div>
	</form>
</script>

<script id="ch-list-item-radio-tpl" type="text/templete">
	<td><input name="board-check" type="radio" value="{{id}}"></td>
	<td><span class="pull-left">{{type}}</span></td>	
	<td><span class="pull-left">{{name}}</span></td>
	<td><span class="pull-left">{{pid}}</span></td>
	<td><span class="pull-left">{{serviceId}}</span></td>
</script>

<script id="ch-list-item-checkbox-tpl" type="text/templete">
	<td><input name="board-check" type="checkbox" value="{{id}}"></td>
	<td><span class="pull-left">{{type}}</span></td>	
	<td><span class="pull-left">{{name}}</span></td>
	<td><span class="pull-left">{{pid}}</span></td>
	<td><span class="pull-left">{{serviceId}}</span></td>
</script>
	

<!-- App 선택시 팝업 -->
<div id="appstore-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">앱 선택</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-app-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="app-popup-confirm" type="button" class="btn btn-primary">확인</button>
				<button id="" type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<script id="search-app-list-tpl" type="text/templete">
	<div class="row top-content">
		<div class="col-md-4">
			<div id="tour-searchbox" class="input-group searchbox">
				<input id="search-value" type="search" class="form-control" placeholder="app명"> <span class="input-group-btn">
					<span class="input-group-btn">
						<button id="search-btn" class="btn btn-success" type="button"><i class="fa fa-search"></i> </button>
					</span>
				</span>
			</div>
		</div>
	</div>
	<form id="app-list">
		<table class="table table-hover table-striped table-bordered">
			<thead>
				<tr>
					<th style="width: 30px;"></th>
					<th width="25%">App ID</th>
					<th width="50%">App 명</th>
					<th width="25%">장르</th>
				</tr>
			</thead>
			<tbody id="search-app-list-container">
			</tbody>
		</table>
		<div class="row">
			{{#pagination number startPage endPage totalPages}}
			<div class="dataTables_paginate paging_bootstrap">
				<ul class="pagination borderless">
					{{#if startFromFirstPage}} 
			
					{{/if}} 
					{{#unless startFromFirstPage}}
						<li class="prev"><a href="#" id="board-prevBlock">←</a></li> 
					{{/unless}} 
			
					{{#each pages}} 
						{{#if isCurrent}}
							<li class='active'><a href="#">{{page}}</a></li> 
						{{/if}}
						{{#unless isCurrent}}
							<li><a href="#" id='board-page' data-pageNum='{{page}}'>{{page}}</a></li>
						{{/unless}} 
					{{/each}} 
			
					{{#if endAtLastPage}}
						<li></li> 
					{{/if}} 
					{{#unless endAtLastPage}}
						<li class="next"><a href="#" id="board-nextBlock">→</a></li> 
					{{/unless}}
				</ul>
			</div>
			{{/pagination}}
		</div>
	</form>
</script>
	
<script id="search-app-list-checkbox-item-tpl" type="text/templete">
	<td><input name="board-check" type="checkbox" value="{{id}}"></td>
	<td><span class="pull-left">{{pid}}</span></td>	
	<td><span class="pull-left">{{name}}</span></td>
	<td><span class="pull-left">{{genre}}</span></td>
</script>

<script id="search-app-list-radio-item-tpl" type="text/templete">
	<td><input name="board-check" type="radio" value="{{id}}"></td>
	<td><span class="pull-left">{{pid}}</span></td>	
	<td><span class="pull-left">{{name}}</span></td>
	<td><span class="pull-left">{{genre}}</span></td>
</script>


<!-- 공지사항 검색 팝업 -->
<div id="mail-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">공지사항 선택</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-notice-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="notice-popup-confirm" type="button" class="btn btn-primary">확인</button>
				<button id="" type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<script id="search-notice-list-tpl" type="text/templete">
	<div class="row top-content">
		<div class="col-md-4">
			<div id="tour-searchbox" class="input-group searchbox">
				<input id="search-value" type="search" class="form-control" placeholder="공지사항 제목"> <span class="input-group-btn">
					<span class="input-group-btn">
						<button id="search-btn" class="btn btn-success" type="button"><i class="fa fa-search"></i> </button>
					</span>
				</span>
			</div>
		</div>
	</div>
	<form id="notice-list">
		<table class="table table-hover table-striped table-bordered">
			<thead>
				<tr>
					<th style="width: 30px;"></th>
					<th width="25%">타입</th>
					<th width="50%">공지사항 제목</th>
					<th width="25%">노출기간</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<div class="row">
			{{#pagination number startPage endPage totalPages}}
			<div class="dataTables_paginate paging_bootstrap">
				<ul class="pagination borderless">
					{{#if startFromFirstPage}} 
			
					{{/if}} 
					{{#unless startFromFirstPage}}
						<li class="prev"><a href="#" id="board-prevBlock">←</a></li> 
					{{/unless}} 
			
					{{#each pages}} 
						{{#if isCurrent}}
							<li class='active'><a href="#">{{page}}</a></li> 
						{{/if}}
						{{#unless isCurrent}}
							<li><a href="#" id='board-page' data-pageNum='{{page}}'>{{page}}</a></li>
						{{/unless}} 
					{{/each}} 
			
					{{#if endAtLastPage}}
						<li></li> 
					{{/if}} 
					{{#unless endAtLastPage}}
						<li class="next"><a href="#" id="board-nextBlock">→</a></li> 
					{{/unless}}
				</ul>
			</div>
			{{/pagination}}
		</div>
	</form>
</script>
	
<script id="search-notice-list-checkbox-item-tpl" type="text/templete">
	<td><input name="board-check" type="checkbox" value="{{id}}"></td>
	<td><span class="pull-left">{{type}}</span></td>	
	<td><span class="pull-left">{{title}}</span></td>
	<td><span class="pull-left">{{exposureDate_from}} ~ {{exposureDate_to}}</span></td>
</script>

<script id="search-notice-list-radio-item-tpl" type="text/templete">
	<td><input name="board-check" type="radio" value="{{id}}"></td>
	<td><span class="pull-left">{{type}}</span></td>	
	<td><span class="pull-left">{{title}}</span></td>
	<td><span class="pull-left">{{exposureDate_from}} ~ {{exposureDate_to}}</span></td>
</script>


<!-- 프로그램 카테고리 검색 팝업 -->
<div id="program_category-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">카테고리 선택</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-program-category-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="program-category-popup-confirm" type="button" class="btn btn-primary">확인</button>
				<button id="" type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<script id="search-program-category-list-tpl" type="text/templete">
	<div class="row top-content">
		<div class="col-md-4">
			<div id="tour-searchbox" class="input-group searchbox">
				<input id="search-value" type="search" class="form-control" placeholder="카테고리 이름"> <span class="input-group-btn">
					<span class="input-group-btn">
						<button id="search-btn" class="btn btn-success" type="button"><i class="fa fa-search"></i> </button>
					</span>
				</span>
			</div>
		</div>
	</div>
	<form id="program-category-list">
		<table class="table table-hover table-striped table-bordered">
			<thead>
				<tr>
					<th style="width: 30px;"></th>
					<th width="25%">제목</th>
					<th width="50%">경로</th>
					<th width="25%">타입</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<div class="row">
			{{#pagination number startPage endPage totalPages}}
			<div class="dataTables_paginate paging_bootstrap">
				<ul class="pagination borderless">
					{{#if startFromFirstPage}} 
			
					{{/if}} 
					{{#unless startFromFirstPage}}
						<li class="prev"><a href="#" id="board-prevBlock">←</a></li> 
					{{/unless}} 
			
					{{#each pages}} 
						{{#if isCurrent}}
							<li class='active'><a href="#">{{page}}</a></li> 
						{{/if}}
						{{#unless isCurrent}}
							<li><a href="#" id='board-page' data-pageNum='{{page}}'>{{page}}</a></li>
						{{/unless}} 
					{{/each}} 
			
					{{#if endAtLastPage}}
						<li></li> 
					{{/if}} 
					{{#unless endAtLastPage}}
						<li class="next"><a href="#" id="board-nextBlock">→</a></li> 
					{{/unless}}
				</ul>
			</div>
			{{/pagination}}
		</div>
	</form>
</script>
	
<script id="search-program-category-list-checkbox-item-tpl" type="text/templete">
	<td><input name="board-check" type="checkbox" value="{{id}}"></td>
	<td><span class="pull-left">{{name}}</span></td>	
	<td><span class="pull-left">{{path}}</span></td>
	<td><span class="pull-left">{{categoryType}}</span></td>
</script>

<script id="search-program-category-list-radio-item-tpl" type="text/templete">
	<td><input name="board-check" type="radio" value="{{id}}"></td>
	<td><span class="pull-left">{{name}}</span></td>	
	<td><span class="pull-left">{{path}}</span></td>
	<td><span class="pull-left">{{categoryType}}</span></td>
</script>

<!-- 사용자 그룹 검색 팝업 -->
<div id="usergroup-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">사용자 그룹  선택</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-usergroup-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="usergroup-popup-confirm" type="button" class="btn btn-primary">확인</button>
				<button id="" type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<script id="search-usergroup-list-tpl" type="text/templete">
	
	<form id="usergroup-list">
		<table class="table table-hover table-striped table-bordered">
			<thead>
				<tr>
					<th style="width: 30px;"></th>
					<th width="25%">타입</th>
					<th width="50%">이름</th>
					<th width="25%">연결 메뉴그룹</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<div class="row">
			{{#pagination number startPage endPage totalPages}}
			<div class="dataTables_paginate paging_bootstrap">
				<ul class="pagination borderless">
					{{#if startFromFirstPage}} 
			
					{{/if}} 
					{{#unless startFromFirstPage}}
						<li class="prev"><a href="#" id="board-prevBlock">←</a></li> 
					{{/unless}} 
			
					{{#each pages}} 
						{{#if isCurrent}}
							<li class='active'><a href="#">{{page}}</a></li> 
						{{/if}}
						{{#unless isCurrent}}
							<li><a href="#" id='board-page' data-pageNum='{{page}}'>{{page}}</a></li>
						{{/unless}} 
					{{/each}} 
			
					{{#if endAtLastPage}}
						<li></li> 
					{{/if}} 
					{{#unless endAtLastPage}}
						<li class="next"><a href="#" id="board-nextBlock">→</a></li> 
					{{/unless}}
				</ul>
			</div>
			{{/pagination}}
		</div>
	</form>
</script>
	
<script id="search-usergroup-list-checkbox-item-tpl" type="text/templete">
	<td><input name="board-check" type="checkbox" value="{{id}}"></td>
	<td><span class="pull-left">{{type}}</span></td>	
	<td><span class="pull-left">{{name}}</span></td>
	<td><span class="pull-left">{{linkedMenu}}</span></td>
</script>

<script id="search-usergroup-list-radio-item-tpl" type="text/templete">
	<td><input name="board-check" type="radio" value="{{id}}"></td>
	<td><span class="pull-left">{{type}}</span></td>	
	<td><span class="pull-left">{{name}}</span></td>
	<td><span class="pull-left">{{llinkedMenu}}</span></td>
</script>

<!-- 카테고리 검색 팝업 -->
<div id="category-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">카테고리 선택</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-category-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="category-popup-confirm" type="button" class="btn btn-primary">확인</button>
				<button id="" type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<script id="search-category-list-tpl" type="text/templete">
	<div class="row top-content">
		<div class="col-md-4">
			<div id="tour-searchbox" class="input-group searchbox">
				<input id="search-value" type="search" class="form-control" placeholder="카테고리 이름"> <span class="input-group-btn">
					<span class="input-group-btn">
						<button id="search-btn" class="btn btn-success" type="button"><i class="fa fa-search"></i> </button>
					</span>
				</span>
			</div>
		</div>
	</div>
	<form id="category-list">
		<table class="table table-hover table-striped table-bordered">
			<thead>
				<tr>
					<th style="width: 30px;"></th>
					<th width="25%">제목</th>
					<th width="50%">경로</th>
					<th width="25%">타입</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<div class="row">
			{{#pagination number startPage endPage totalPages}}
			<div class="dataTables_paginate paging_bootstrap">
				<ul class="pagination borderless">
					{{#if startFromFirstPage}} 
			
					{{/if}} 
					{{#unless startFromFirstPage}}
						<li class="prev"><a href="#" id="board-prevBlock">←</a></li> 
					{{/unless}} 
			
					{{#each pages}} 
						{{#if isCurrent}}
							<li class='active'><a href="#">{{page}}</a></li> 
						{{/if}}
						{{#unless isCurrent}}
							<li><a href="#" id='board-page' data-pageNum='{{page}}'>{{page}}</a></li>
						{{/unless}} 
					{{/each}} 
			
					{{#if endAtLastPage}}
						<li></li> 
					{{/if}} 
					{{#unless endAtLastPage}}
						<li class="next"><a href="#" id="board-nextBlock">→</a></li> 
					{{/unless}}
				</ul>
			</div>
			{{/pagination}}
		</div>
	</form>
</script>
	
<script id="search-category-list-checkbox-item-tpl" type="text/templete">
	<td><input name="board-check" type="checkbox" value="{{id}}"></td>
	<td><span class="pull-left">{{name}}</span></td>	
	<td><span class="pull-left">{{path}}</span></td>
	<td><span class="pull-left">{{categoryType}}</span></td>
</script>

<script id="search-category-list-radio-item-tpl" type="text/templete">
	<td><input name="board-check" type="radio" value="{{id}}"></td>
	<td><span class="pull-left">{{name}}</span></td>	
	<td><span class="pull-left">{{path}}</span></td>
	<td><span class="pull-left">{{categoryType}}</span></td>
</script>

<!-- 프로모션 검색 팝업 -->
<div id="contents-promotion-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">프로모션 선택 선택</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-contents-promotion-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="contents-promotion-popup-confirm" type="button" class="btn btn-primary">확인</button>
				<button id="" type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<script id="search-contents-promotion-list-tpl" type="text/templete">
	<form id="contents-promotion-list">
		<table class="table table-hover table-striped table-bordered">
			<thead>
				<tr>
					<th style="width: 30px;"></th>
					<th width="20%">ID</th>
					<th width="15%">타입</th>
					<th width="35%">이름</th>
					<th width="15%">현재 스케줄명</th>
					<th width="15%">활설/비활성</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<div class="row">
			{{#pagination number startPage endPage totalPages}}
			<div class="dataTables_paginate paging_bootstrap">
				<ul class="pagination borderless">
					{{#if startFromFirstPage}} 
			
					{{/if}} 
					{{#unless startFromFirstPage}}
						<li class="prev"><a href="#" id="board-prevBlock">←</a></li> 
					{{/unless}} 
			
					{{#each pages}} 
						{{#if isCurrent}}
							<li class='active'><a href="#">{{page}}</a></li> 
						{{/if}}
						{{#unless isCurrent}}
							<li><a href="#" id='board-page' data-pageNum='{{page}}'>{{page}}</a></li>
						{{/unless}} 
					{{/each}} 
			
					{{#if endAtLastPage}}
						<li></li> 
					{{/if}} 
					{{#unless endAtLastPage}}
						<li class="next"><a href="#" id="board-nextBlock">→</a></li> 
					{{/unless}}
				</ul>
			</div>
			{{/pagination}}
		</div>
	</form>
</script>
	
<script id="search-contents-promotion-list-checkbox-item-tpl" type="text/templete">
	<td><input name="board-check" type="checkbox" value="{{id}}"></td>
	<td><span class="pull-left">{{pid}}</span></td>	
	<td><span class="pull-left">{{type}}</span></td>
	<td><span class="pull-left">{{name}}</span></td>
	<td><span class="pull-left">{{schedule.name}}</span></td>
	<td><span class="pull-left">{{status}}</span></td>
</script>

<script id="search-contents-promotion-list-radio-item-tpl" type="text/templete">
	<td><input name="board-check" type="radio" value="{{id}}"></td>
	<td><span class="pull-left">{{pid}}</span></td>
	<td><span class="pull-left">{{type}}</span></td>
	<td><span class="pull-left">{{name}}</span></td>
	<td><span class="pull-left">{{schedule.name}}</span></td>
	<td><span class="pull-left">{{status}}</span></td>
</script>
