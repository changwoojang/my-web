<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ include file="/WEB-INF/views/includes/taglibs.jsp"%>

<!-- program 선택 modal-->
<div id="program-select-popup" class="modal modal-wide fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title">Select Content</h4>
			</div>
			<div class="modal-body">
				<div class="widget-box">
					<div class="widget-content nopadding" id="search-vod-body"></div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="program-popup-confirm" type="button"
					class="btn btn-primary" data-dismiss="modal"><i class="fa fa-check-circle"></i>Ok</button>
				<button id="" type="button" class="btn btn-default"
					data-dismiss="modal"><i class="fa fa-times"></i>Cancel</button>
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
									<option id="vodName" value="vodName">vod Name</option>
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
							<table class="table table-hover table-striped table-bordered" >
								<thead>
									<tr>
										<th width="20px"></th>
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
	</table>
</form>
</script>

<script id="vod-list-item-checkbox-tpl" type="text/template">
	<td class="checkbox-table"><input name="board-check" id="board-check" type="checkbox" value="{{id}}"></td>
	<td><span class="pull-left">{{type}}</span></td>
    <td><span class="pull-left"style="display: inline-block; overflow:hidden; white-space:nowrap; width: 100%">{{title}}</span> <br> <span class='pull-left' style="display: inline-block; overflow:hidden; white-space:nowrap; width: 100%">[{{assetId}}]</span></td>
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
  	<td><span class="pull-left"style="display: inline-block; overflow:hidden; white-space:nowrap; width: 100%">{{title}}</span> <br> <span class='pull-left' style="display: inline-block; overflow:hidden; white-space:nowrap; width: 100%">[{{assetId}}]</span></td>
	<td><span class="pull-left">{{format}}</span></td>
    <td><span class="pull-left"style="display: inline-block; overflow:hidden; white-space:nowrap; width: 100%">{{device}}</span></td>
	<td><span class="pull-left">{{price}}</span></td>
	<td><span class="pull-left">{{license}}</td>
	<td><span class="pull-left">{{providerName}}</td>
	<td><span class="pull-left">{{status}}</td>
</script>