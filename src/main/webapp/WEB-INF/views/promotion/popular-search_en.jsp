<%@ page language="java" pageEncoding="utf-8"
	contentType="text/html;charset=utf-8"%>
<%@ include file="/WEB-INF/views/includes/taglibs.jsp"%>
<head>
    <meta name="_csrf" content="${_csrf.token}"/>
    <!-- default header name is X-CSRF-TOKEN -->
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <!-- ... -->
</head>   

<div class="main-content"  id="main-body">
	<div class="row">
		<div class="col-md-12">
			<div class="widget">
                <div class="widget-header">
                	<h3><i class="fa fa-th-list"></i>Product And Option List</h3>
                </div>
           
	            <div class="widget-content" style="height: 585px; min-width: 600px;">
					<div class="col-md-5">
						<form class="form-horizontal" id="search-recommend-info" >
							<div class="form-group">
								<div id="search-recommend-list-body"></div>
							</div>
						</form> 
					</div>
					<div class="col-md-1"></div>

					<div class="col-md-5">
						<form class="form-horizontal">
							<div class="form-group">
								<div id="product-option-list-body"></div>
							</div>
						</form>
					</div>
					 <div id="divResults"></div>
				</div>
			 </div>
		 </div>
	</div>
</div>

<script id="product-option-list-tpl" type="text/template"> 

	<table class="table table-hover table-striped table-bordered datatable" style="table-layout:fixed">
		<thead>
			<tr>
				<th>Popular Search</th>
				<th>Rank</th>
			</tr>
		</thead>
		<tbody id="product-option-list-container">
		</tbody>

	</table>
	<div class="form-group button-group">
		<div class="col-sm-offset-3 col-sm-9">
			<div class="input-group-appendable pull-right">
				<!--<button  class="btn btn-primary btn-compose" id="product-option-edit-save"><i class="fa fa-floppy-o"></i>Save</button>
				<button  class="btn btn-primary btn-compose" id="product-option-edit-cancel"><i class="fa fa-times"></i>Cancel</button>-->
			</div>
		</div>
	</div>
</script>

<script id="product-option-list-item-tpl" type="text/templete">
	<td><span class="pull-left" name="productId" id="productId" style="margin-bottom: 6px;" >{{productId}}</span></td>
	<td><span class="pull-left" name="optionId" id="optionId" >{{productId}}</span></td>
	
	
</script>

<script id="search-recommend-list-tpl" type="text/template">
	<table class="table table-hover table-striped table-bordered datatable" style="table-layout:fixed">
		<thead>
			<tr>
				<th>Product ID</th>
				<th>Option ID</th>
			</tr>
		</thead>
		<tbody id="search-recommend-list-container" >
		</tbody>
	</table>
	<div class="form-group button-group">
		<div class="col-sm-offset-3 col-sm-9">
			<div class="input-group-appendable pull-right">
				<button  class="btn btn-primary btn-compose" id="product-option-edit-save"><i class="fa fa-floppy-o"></i>start sorting</button>
				<!--<button  class="btn btn-primary btn-compose" id="product-option-edit-cancel"><i class="fa fa-times"></i>Cancel</button>-->
			</div>
		</div>
	</div>
</script>

<script id="search-recommend-list-item-tpl" type="text/templete">
	<td><input name="productId" id="productId" class= "search_group" style="margin-bottom: 0px;" type="text" value="{{productId}}"></td>
	<td><input name="optionId" id="optionId" class= "search_group" type="number" style="margin-bottom: 0px;" type="text" value="{{optionId}}"></td>
</script>

<div id="modal" class="modal modal-wide fade"></div>