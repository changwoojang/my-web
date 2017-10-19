<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@ include file="/WEB-INF/views/includes/taglibs.jsp"%>
	
<!-- program 선택 modal-->
<div id="program-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"	aria-hidden="true">&times;</button>
				<h4 class="modal-title">Select Content</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-vod-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="program-popup-confirm" type="button" class="btn btn-primary"><i class="fa fa-check-circle"></i>Ok</button>
				<button id="" type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i>Cancel</button>
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
				<option id="subscription" value="subscription">Monthly Subscription</option>
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
				<option id="vodName" value="vodName">vod name</option>
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
		<table class="table table-hover table-striped table-bordered" style="table-layout: fixed;" >
			<thead>
				<tr>
					
					<th width="5%"></th>
					<th>Type</th>
					<th width="20%">Title</th>
					<th>Format</th>
					<th>Device</th>
					<th>Price</th>
					<th>License</th>
					<th>Supplier</th>
					<th>Status</th>
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
    <td><span class="pull-left"style="display: inline-block; overflow:hidden; white-space:nowrap; width: 100%">{{title}}</span> <br> <span class='pull-left'>[{{assetId}}]</span></td>
	<td><span class="pull-left">{{format}}</span></td>
    <td><span class="pull-left"style="display: inline-block; overflow:hidden; white-space:nowrap; width: 100%">{{device}}</span></td>
	<td><span class="pull-left">{{price}}</span></td>
	<td><span class="pull-left">{{license}}</td>
	<td><span class="pull-left">{{providerName}}</td>
	<td><span class="pull-left">{{status}}</td>
</script>

<script id="vod-list-item-radio-tpl" type="text/template">
	<td class="checkbox-table"><input name="board-check" id="board-check" type="radio" value="{{id}}"></td>
	<td><span class="pull-left">{{type}}</span></td>
    <td><span class="pull-left"style="display: inline-block; overflow:hidden; white-space:nowrap; width: 100%">{{title}}</span> <br> <span class='pull-left'>[{{assetId}}]</span></td>
	<td><span class="pull-left">{{format}}</span></td>
    <td><span class="pull-left"style="display: inline-block; overflow:hidden; white-space:nowrap; width: 100%">{{device}}</span></td>
	<td><span class="pull-left">{{price}}</span></td>
	<td><span class="pull-left">{{license}}</td>
	<td><span class="pull-left">{{providerName}}</td>
	<td><span class="pull-left">{{status}}</td>
</script>
	
<!-- Select SubPackage Modal-->
<div id="vod-package-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title">Select VOD Package</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-package-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="package-select-confirm" type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-check-circle"></i>OK</button>
				<button id="package-select-cancel" type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i>Cancel</button>
			</div>
		</div>
	</div>
</div>
<div id="vod-subscription-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title">Select SVOD Subscription</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-svod-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="svod-product-select-confirm" type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-check-circle"></i>OK</button>
				<button id="svod-product-select-cancel" type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i>Cancel</button>
			</div>
		</div>
	</div>
</div>
<div id="full-package-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title">Select Full Package</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-full-package-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="full-package-select-confirm" type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-check-circle"></i>OK</button>
				<button id="full-package-select-cancel" type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i>Cancel</button>
			</div>
		</div>
	</div>
</div>
<div id="menu-vod-subscription-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title">Select Svod Tagged Menu</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-menu-svod-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="menu-svod-product-select-confirm" type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-check-circle"></i>OK</button>
				<button id="menu-svod-product-select-cancel" type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i>Cancel</button>
			</div>
		</div>
	</div>
</div>
<div id="menu-shortcut-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title">Select Menu</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-menu-shortcut-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="menu-shortcut-select-confirm" type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-check-circle"></i>OK</button>
				<button id="menu-shortcut-select-cancel" type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i>Cancel</button>
			</div>
		</div>
	</div>
</div>
<div id="channel-subscription-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title">Select Channel Subscription</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-schannel-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="schannel-product-select-confirm" type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-check-circle"></i>OK</button>
				<button id="schannel-product-select-cancel" type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i>Cancel</button>
			</div>
		</div>
	</div>
</div>
<div id="ott-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title">Select OTT Product</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-ott-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="ott-product-select-confirm" type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-check-circle"></i>OK</button>
				<button id="ott-product-select-cancel" type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i>Cancel</button>
			</div>
		</div>
	</div>
</div>
<script id="vod-package-list-tpl" type="text/template">
	<form id="package-list" class="form-horizontal">
		<table class="table table-hover table-striped table-bordered">
			<thead>
				<tr>
					<th width="3%"></th>
					<th>Name</th>
					<th>Type</th>
				</tr>

			</thead>
			<tbody id="vod-package-list-container">
	
			</tbody>
		</table>
	</form>
</script>
<script id="full-package-list-tpl" type="text/template">
	<form id="package-list" class="form-horizontal">
		<table class="table table-hover table-striped table-bordered">
			<thead>
				<tr>
					<th width="3%"></th>
					<th>Name</th>
				</tr>

			</thead>
			<tbody id="full-package-list-container">
	
			</tbody>
		</table>
	</form>
</script>
<script id="svod-product-list-tpl" type="text/template">
	<form id="package-list" class="form-horizontal">
		<table class="table table-hover table-striped table-bordered">
			<thead>
				<tr>
					<th width="3%"></th>
					<th>Name</th>
					<th>Type</th>
				</tr>

			</thead>
			<tbody id="svod-product-list-container">
	
			</tbody>
		</table>
	</form>
</script>
<script id="menu-svod-product-list-tpl" type="text/template">
	<form id="package-list" class="form-horizontal">
		<table class="table table-hover table-striped table-bordered">
			<thead>
				<tr>
					<th width="3%"></th>
					<th>Menu Name</th>
					<th>Path ID</th>
					<th>Tag Type</th>
				</tr>

			</thead>
			<tbody id="menu-svod-product-list-container">
	
			</tbody>
		</table>
	</form>
</script>
<script id="menu-shortcut-list-tpl" type="text/template">
	<form id="shortcut-list" class="form-horizontal">
		<table class="table table-hover table-striped table-bordered">
			<thead>
				<tr>
					<th width="3%"></th>
					<th>Menu Name</th>
					<th>Menu Depth</th>
					<th>Menu Path</th>
					<th>Device</th>
					<th>Menu Type</th>
					<th>Menu Tag</th>
				</tr>

			</thead>
			<tbody id="menu-shortcut-list-container">
	
			</tbody>
		</table>
	</form>
</script>
<script id="schannel-product-list-tpl" type="text/template">
	<form id="package-list" class="form-horizontal">
		<table class="table table-hover table-striped table-bordered">
			<thead>
				<tr>
					<th width="3%"></th>
					<th>Name</th>
					<th>Type</th>
				</tr>

			</thead>
			<tbody id="schannel-product-list-container">
	
			</tbody>
		</table>
	</form>
</script>
<script id="ott-product-list-tpl" type="text/template">
	<form id="package-list" class="form-horizontal">
		<table class="table table-hover table-striped table-bordered">
			<thead>
				<tr>
					<th width="3%"></th>
					<th>Name</th>
				</tr>

			</thead>
			<tbody id="ott-product-list-container">
	
			</tbody>
		</table>
	</form>
</script>

<!-- channel 선택 modal -->
<div id="channel-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title">Select Channel</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-channel-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="channel-popup-confirm" type="button" class="btn btn-primary"><i class="fa fa-check-circle"></i></i>Ok</button>
				<button id="" type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i>Cancel</button>
			</div>
		</div>
	</div>
</div>

<script id="ch-list-tpl" type="text/templete">
	<div class="row top-content">
		<div class="col-md-4">
			<div id="tour-searchbox" class="input-group searchbox">
				<input id="search-value" type="search" class="form-control" placeholder="Channel name"> <span class="input-group-btn">
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
					<th class="checkbox-table"><input type="checkbox" class="check-all"></th>
					<th width="20%">Channel Type</th>
					<th width="40%">Channel Name</th>
					<th width="20%">Channel ID</th>
					<th width="20%">Service ID</th>
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

<script id="typed-ch-list-tpl" type="text/templete">
	<div class="row top-content">
		<div class="col-md-4">
			<div id="tour-searchbox" class="input-group searchbox">
				<input id="search-value" type="search" class="form-control" placeholder="Channel name"> <span class="input-group-btn">
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
					<th class="checkbox-table"><input type="checkbox" class="check-all"></th>
					<th width="20%">Channel Type</th>
					<th width="40%">Channel Name</th>
					<th width="25%">Channel ID</th>
					<th width="15%">Service ID</th>
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
	<td class="checkbox-table"><input name="board-check" type="radio" value="{{id}}"></td>
	<td><span class="pull-left">{{type}}</span></td>	
	<td><span class="pull-left">{{name}}</span></td>
	<td><span class="pull-left">{{id}}</span></td>
	<td><span class="pull-left">{{serviceId}}</span></td>
</script>
<script id="ch-list-item-checkbox-tpl" type="text/templete">
	<td class="checkbox-table"><input name="board-check" type="checkbox" value="{{id}}"></td>
	<td><span class="pull-left">{{type}}</span></td>	
	<td><span class="pull-left">{{name}}</span></td>
	<td><span class="pull-left">{{id}}</span></td>
	<td><span class="pull-left">{{serviceId}}</span></td>
</script>

<!-- App 선택시 팝업 -->
<div id="appstore-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">Select App</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-app-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="app-popup-confirm" type="button" class="btn btn-primary"><i class="fa fa-check-circle"></i>Ok</button>
				<button id="" type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i>Cancel</button>
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
					<th width="50%">App Name</th>
					<th width="25%">Genre</th>
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
	<td class="checkbox-table"><input name="board-check" type="checkbox" value="{{id}}"></td>
	<td><span class="pull-left">{{pid}}</span></td>	
	<td><span class="pull-left">{{name}}</span></td>
	<td><span class="pull-left">{{genre}}</span></td>
</script>

<script id="search-app-list-radio-item-tpl" type="text/templete">
	<td class="checkbox-table"><input name="board-check" type="radio" value="{{id}}"></td>
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
				<h4 class="modal-title">Select Announcement</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-notice-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="notice-popup-confirm" type="button" class="btn btn-primary"><i class="fa fa-check-circle"></i>OK</button>
				<button id="" type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i>Cancel</button>
			</div>
		</div>
	</div>
</div>

<script id="search-notice-list-tpl" type="text/templete">
	<div class="row top-content">

        <div class="col-md-2">
            <select id="searchType" name="searchType" class="form-control">
                <option id="admin" value="admin">Hybrid</option>
                <option id="broadcast" value="broadcast">Oneway</option>
				<option id="iptv" value="iptv">IPTV</option>
            </select>
        </div>

		<div class="col-md-4">
			<div id="tour-searchbox" class="input-group searchbox">
				<input id="search-value" type="search" class="form-control" placeholder="Announcement Title"> <span class="input-group-btn">
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
					<th width="25%">Source</th>
					<th width="25%">Type</th>
					<th width="50%">Announcement Title</th>
					<th width="25%">Duration of Announcement</th>
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
	<td><span class="pull-left">{{source}}</span></td>
	<td><span class="pull-left">{{type}}</span></td>	
	<td><span class="pull-left">{{title}}</span></td>
	<td><span class="pull-left">{{exposureDate_from}} ~ {{exposureDate_to}}</span></td>
</script>

<script id="search-notice-list-radio-item-tpl" type="text/templete">
	<td><input name="board-check" type="radio" value="{{id}}"></td>
	<td><span class="pull-left">{{source}}</span></td>
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
				<h4 class="modal-title">Select Category</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-program-category-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="program-category-popup-confirm" type="button" class="btn btn-primary"><i class="fa fa-check-circle"></i>OK</button>
				<button id="" type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i>Cancel</button>
			</div>
		</div>
	</div>
</div>

<div id="program_category-limit-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">Select Category</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-program-category-limit-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="program-category-limit-popup-confirm" type="button" class="btn btn-primary"><i class="fa fa-check-circle"></i>OK</button>
				<button id="" type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i>Cancel</button>
			</div>
		</div>
	</div>
</div>

<script id="search-program-category-list-tpl" type="text/templete">
	<div class="row top-content">
		<div class="col-md-4">
			<div id="tour-searchbox" class="input-group searchbox">
				<input id="search-value" type="search" class="form-control" placeholder="Category Name"> <span class="input-group-btn">
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
					<th width="3%"></th>
					<th width="25%">Title</th>
					<th width="50%">Path</th>
					<th width="22%">Type</th>
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


<script id="search-program-category-limit-list-tpl" type="text/templete">
	<div class="row top-content">
		<div class="col-md-4">
			<div id="tour-searchbox" class="input-group searchbox">
				<input id="search-value" type="search" class="form-control" placeholder="Category Name"> <span class="input-group-btn">
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
					<th width="3%"></th>
					<th width="25%">Title</th>
					<th width="50%">Path</th>
					<th width="12%">Type</th>
					<th width="12%">SubDepth</th>
					<th width="12%">Series</th>
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
<script id="search-program-category-limit-list-checkbox-item-tpl" type="text/templete">
	<td class="checkbox-table"><input name="board-check" id="board-check" type="checkbox" value="{{id}}"></td>
	<td><span class="pull-left">{{name}}</span></td>	
	<td><span class="pull-left">{{path}}</span></td>
	<td><span class="pull-left">{{categoryType}}</span></td>
	<td><span class="pull-left">{{subDepthCnt}}</span></td>
	<td><span class="pull-left"name="isSeriesOnly" id="isSeriesOnly">{{isSeriesOnly}}</span></td>
</script>

<script id="search-program-category-limit-list-radio-item-tpl" type="text/templete">
	<td class="checkbox-table"><input name="board-check" id="board-check" type="radio" value="{{id}}"></td>
	<td><span class="pull-left">{{name}}</span></td>	
	<td><span class="pull-left">{{path}}</span></td>
	<td><span class="pull-left">{{categoryType}}</span></td>
	<td><span class="pull-left">{{subDepthCnt}}</span></td>
	<td><span class="pull-left" name="isSeriesOnly" id="isSeriesOnly">{{isSeriesOnly}}</span></td>
</script>

<script id="search-program-category-list-checkbox-item-tpl" type="text/templete">
	<td class="checkbox-table"><input name="board-check" id="board-check" type="checkbox" value="{{id}}"></td>
	<td><span class="pull-left">{{name}}</span></td>	
	<td><span class="pull-left">{{path}}</span></td>
	<td><span class="pull-left">{{categoryType}}</span></td>
</script>

<script id="search-program-category-list-radio-item-tpl" type="text/templete">
	<td class="checkbox-table"><input name="board-check" id="board-check" type="radio" value="{{id}}"></td>
	<td><span class="pull-left">{{name}}</span></td>	
	<td><span class="pull-left">{{path}}</span></td>
	<td><span class="pull-left">{{categoryType}}</span></td>
</script>
<script id="search-vod-package-list-radio-item-tpl" type="text/templete">
	<td><input name="board-check" type="radio" value="{{id}}"></td>
	<td><span class="pull-left">{{name}}</span></td>
	<td><span class="pull-left">{{type}}</span></td>	

</script>
<script id="search-vod-package-list-checkbox-item-tpl" type="text/templete">
	<td class="checkbox-table"><input name="board-check" id="board-check" type="checkbox"  value="{{id}}"></td>
	<td><span class="pull-left">{{name}}</span></td>
	<td><span class="pull-left">{{type}}</span></td>	

</script>

<script id="search-svod-product-list-radio-item-tpl" type="text/templete">
	<td><input name="board-check" type="radio" value="{{id}}"></td>
	<td><span class="pull-left">{{name}}</span></td>
	<td><span class="pull-left">{{type}}</span></td>	

</script>
<script id="search-svod-product-list-checkbox-item-tpl" type="text/templete">
	
	<td class="checkbox-table"><input name="board-check" id="board-check" type="checkbox"  value="{{id}}"></td>
	<td><span class="pull-left">{{name}}</span></td>
	<td><span class="pull-left">{{type}}</span></td>	

</script>

<script id="search-full-package-list-radio-item-tpl" type="text/templete">
	<td><input name="board-check" type="radio" value="{{id}}"></td>
	<td><span class="pull-left">{{name}}</span></td>

</script>
<script id="search-full-package-list-checkbox-item-tpl" type="text/templete">
	
	<td class="checkbox-table"><input name="board-check" id="board-check" type="checkbox"  value="{{id}}"></td>
	<td><span class="pull-left">{{name}}</span></td>

</script>

<script id="search-menu-svod-product-list-radio-item-tpl" type="text/templete">
	<td><input name="board-check" type="radio" value="{{pathId}}"></td>
	<td><span class="pull-left">{{name}}</span></td>
	<td><span class="pull-left">{{pathId}}</span></td>
	<td><span class="pull-left">{{tag}}</span></td>	

</script>
<script id="search-menu-svod-product-list-checkbox-item-tpl" type="text/templete">
	
	<td class="checkbox-table"><input name="board-check" id="board-check" type="checkbox"  value="{{pathId}}"></td>
	<td><span class="pull-left">{{name}}</span></td>
	<td><span class="pull-left">{{pathId}}</span></td>
	<td><span class="pull-left">{{tag}}</span></td>	

</script>

<script id="search-menu-shortcut-list-radio-item-tpl" type="text/templete">
	<td><input name="board-check" type="radio" value="{{id}}"></td>
	<td><span class="pull-left">{{name}}</span></td>
	<td>{{#compare depth "1" operator="==="}} <span class="badge element-bg-color-green">1 Depth</span>  {{/compare}} 
		{{#compare depth "2" operator="==="}} <span class="badge element-bg-color-green">2 Depth</span> {{/compare}}
		{{#compare depth "3" operator="==="}} <span class="badge element-bg-color-green">3 Depth</span> {{/compare}}</td>
	<td><span class="pull-left">{{pathId}}</span></td>
	<td><span class="pull-left">{{devices}}</span></td>
	<td><span class="pull-left">{{type}}</span></td>
	<td><span class="pull-left">{{tag}}</span></td>	

</script>

<script id="search-menu-shortcut-list-checkbox-item-tpl" type="text/templete">
	
	<td class="checkbox-table"><input name="board-check" id="board-check" type="checkbox"  value="{{id}}"></td>
	<td><span class="pull-left">{{name}}</span></td>
		<td>{{#compare depth "1" operator="==="}} <span class="badge element-bg-color-green">1 Depth</span>  {{/compare}} 
		{{#compare depth "2" operator="==="}} <span class="badge element-bg-color-green">2 Depth</span> {{/compare}}
		{{#compare depth "3" operator="==="}} <span class="badge element-bg-color-green">3 Depth</span> {{/compare}}</td>
	<td><span class="pull-left">{{pathId}}</span></td>
	<td><span class="pull-left">{{devices}}</span></td>
	<td><span class="pull-left">{{type}}</span></td>
	<td><span class="pull-left">{{tag}}</span></td>	

</script>

<script id="search-schannel-product-list-radio-item-tpl" type="text/templete">
	<td><input name="board-check" type="radio" value="{{id}}"></td>
	<td><span class="pull-left">{{name}}</span></td>
	<td><span class="pull-left">{{type}}</span></td>	

</script>
<script id="search-schannel-product-list-checkbox-item-tpl" type="text/templete">
	
	<td class="checkbox-table"><input name="board-check" id="board-check" type="checkbox"  value="{{id}}"></td>
	<td><span class="pull-left">{{name}}</span></td>
	<td><span class="pull-left">{{type}}</span></td>	

</script>

<script id="search-ott-product-list-radio-item-tpl" type="text/templete">
	<td><input name="board-check" type="radio" value="{{productId}}"></td>
	<td><span class="pull-left">{{productName}}</span></td>

</script>
<script id="search-ott-product-list-checkbox-item-tpl" type="text/templete">
	
	<td class="checkbox-table"><input name="board-check" id="board-check" type="checkbox"  value="{{productId}}"></td>
	<td><span class="pull-left">{{productName}}</span></td>

</script>

<div id="promotiongroup-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">Select IP Promotion</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-promotiongroup-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="promotiongroup-popup-confirm" type="button" class="btn btn-primary"><i class="fa fa-check-circle"></i>Ok</button>
				<button id="" type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i>Cancel</button>
			</div>
		</div>
	</div>
</div>


<script id="search-promotiongroup-list-tpl" type="text/templete">
	<form id="template-list" class="form-horizontal">
		<table class="table table-hover table-striped table-bordered">
			<thead>
				<tr>
					<th width="5%"></th>
					<th>ID</th>
					<th>Type</th>
					<th>Name</th>
					<th>Schedule</th>
					<th>Status</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</form>
</script>

<script id="search-promotiongroup-list-checkbox-item-tpl" type="text/templete">
	<td class="checkbox-table"><input name="board-check" id="board-check" type="checkbox"  value="{{id}}"></td>
	<td><span class="pull-left">{{pid}}</span></td>
	<td><span class="pull-left">{{type}}</span></td>
	<td><span class="pull-left">{{name}}</span></td>
	<td><span class="pull-left">{{exposePeriod}}</td>
	<td><span class="pull-left">{{status}}</td>

</script>
<script id="search-promotiongroup-list-radio-item-tpl" type="text/templete">
	<td><input name="board-check" type="radio" value="{{id}}"></td>
	<td><span class="pull-left">{{pid}}</span></td>
	<td><span class="pull-left">{{type}}</span></td>
	<td><span class="pull-left">{{name}}</span></td>
	<td><span class="pull-left">{{exposePeriod}}</td>
	<td><span class="pull-left">{{status}}</td>
</script>


<!-- 사용자 그룹 검색 팝업 -->
<div id="usergroup-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">Select User Group</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-usergroup-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="usergroup-popup-confirm" type="button" class="btn btn-primary"><i class="fa fa-check-circle"></i>Ok</button>
				<button id="" type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i>Cancel</button>
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
					<th width="25%">Type</th>
					<th width="50%">Name</th>
					<th width="25%">Linked Menu Group</th>
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
				<h4 class="modal-title">Select Category</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-category-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="category-popup-confirm" type="button" class="btn btn-primary"><i class="fa fa-check-circle"></i>Ok</button>
				<button id="" type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i>Cancel</button>
			</div>
		</div>
	</div>
</div>

<div id="category-display-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">Select Category</h4>
				<!-- <h4 class="modal-title">Select Category & Display Type</h4> -->
			</div>
			<div class="modal-body">
				
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-category-display-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="category-popup-confirm" type="button" class="btn btn-primary"><i class="fa fa-check-circle"></i>Ok</button>
				<button id="" type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i>Cancel</button>
			</div>
		</div>
	</div>
</div>

<script id="search-category-list-tpl" type="text/templete">
	<div class="row top-content">
		<div class="col-md-4">
			<div id="tour-searchbox" class="input-group searchbox">
				<input id="search-value" type="search" class="form-control" placeholder="Category Name"> <span class="input-group-btn">
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
					<th ></th>
					<th width="25%">Title</th>
					<th width="50%">Path</th>
					<th width="25%">Type</th>
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

<script id="search-category-display-list-tpl" type="text/templete">
	<div class="row top-content">
		<div class="col-md-4">
			<div id="tour-searchbox" class="input-group searchbox">
				<input id="search-value" type="search" class="form-control" placeholder="Category Name"> <span class="input-group-btn">
					<span class="input-group-btn">
						<button id="search-btn" class="btn btn-success" type="button"><i class="fa fa-search"></i> </button>
					</span>
				</span>
			</div>
		</div>
		<!--
		<div class="col-md-3">
			<select id="categoryDisplayLine" name="type" class="form-control">
				<option value="1" selected="selected">1 Line</option>
				<option value="2">2 Line</option>
			</select>
			<label>Category Display Line</label>
		</div>
		<div class="col-md-3">
			<select id="seriesDisplayType" name="type" class="form-control">
				<option value="vertical" selected="selected">Vertical</option>
				<option value="horizontal">Horizontal</option>
			</select>
			<label>Series Display Type(Series Only)</label>
		</div>
		-->
	</div>
	<form id="category-list">
		<table class="table table-hover table-striped table-bordered">
			<thead>
				<tr>
					<th ></th>
					<th width="25%">Title</th>
					<th width="50%">Path</th>
					<th width="25%">Type</th>
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
	<td class="checkbox-table"><input name="board-check" type="checkbox" value="{{id}}"></td>
	<td><span class="pull-left">{{name}}</span></td>	
	<td><span class="pull-left">{{path}}</span></td>
	<td><span class="pull-left">{{categoryType}}</span></td>
</script>

<script id="search-category-list-radio-item-tpl" type="text/templete">
	<td class="checkbox-table"><input name="board-check" type="radio" value="{{id}}"></td>
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
				<h4 class="modal-title">Select Promotion</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-contents-promotion-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="contents-promotion-popup-confirm" type="button" class="btn btn-primary"><i class="fa fa-floppy-o"></i>Save</button>
				<button id="" type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i>Cancel</button>
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
					<th width="15%">Type</th>
					<th width="35%">Name</th>
					<th width="15%">Schedule Name</th>
					<th width="15%">Status</th>
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
