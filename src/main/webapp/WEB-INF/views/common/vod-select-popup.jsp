<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@ include file="/WEB-INF/views/includes/taglibs.jsp"%>

<!-- program 선택 modal-->
<div id="program-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title">컨텐츠 선택</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-vod-body">
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="program-popup-confirm" type="button" class="btn btn-primary"
					data-dismiss="modal">확인</button>
				<button id="" type="button" class="btn btn-default"
					data-dismiss="modal">취소</button>
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