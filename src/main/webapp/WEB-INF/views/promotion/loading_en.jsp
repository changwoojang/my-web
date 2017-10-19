<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@ include file="/WEB-INF/views/includes/taglibs.jsp"%>

<div class="main-content">
	<div id="board-list-body" class="king-gallery">
		<table class="table table-hover table-striped table-bordered datatable iframe-table">
			<thead>
				<tr>
					<th style="width:19%"></th>
					<th style="width:27%">Smart</th>
					<th style="width:27%">HD</th>
					<th style="width:27%">SD</th>
				</tr>
			</thead>
			<tbody id="board-list-container">
				<tr>
					<td class="iframe-name">
						Loading 바킹
					</td>
					<td>
						<div class="item col-sm-12">
							<div class="thumbnail">
								<img class="list-group-image" src="${ctx}/img/no-image.jpg" alt=""/>
								<div class="caption">
									<h3 class="inner list-group-item-heading">Image Title</h3>
									<ul class="list-unstyled">
										<li><strong>Path:</strong> <em>assets/img/gallery/no-image.jpg</em></li>
										<li><strong>File Size:</strong> <em>139 KB</em></li>
									</ul>
									<div class="action-buttons">
										<a href="#" class="image-upload btn btn-primary btn-xs"><i class="fa fa-pencil"></i> Edit</a>
										<a href="#" class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i> Remove</a>
										<input type="file" class="hide"/>
									</div>
								</div>
							</div>
						</div>
					</td>
					<td>
						<div class="item col-sm-12">
							<div class="thumbnail">
								<img class="list-group-image" src="${ctx}/img/no-image.jpg" alt=""/>
								<div class="caption">
									<h3 class="inner list-group-item-heading">Image Title</h3>
									<ul class="list-unstyled">
										<li><strong>Path:</strong> <em>assets/img/gallery/no-image.jpg</em></li>
										<li><strong>File Size:</strong> <em>139 KB</em></li>
									</ul>
									<div class="action-buttons">
										<a href="#" class="image-upload btn btn-primary btn-xs"><i class="fa fa-pencil"></i> Edit</a>
										<a href="#" class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i> Remove</a>
										<input type="file" class="hide"/>
									</div>
								</div>
							</div>
						</div>
					</td>
					<td>
						<div class="item col-sm-12">
							<div class="thumbnail">
								<img class="list-group-image" src="${ctx}/img/no-image.jpg" alt=""/>
								<div class="caption">
									<h3 class="inner list-group-item-heading">Image Title</h3>
									<ul class="list-unstyled">
										<li><strong>Path:</strong> <em>assets/img/gallery/no-image.jpg</em></li>
										<li><strong>File Size:</strong> <em>139 KB</em></li>
									</ul>
									<div class="action-buttons">
										<a href="#" class="image-upload btn btn-primary btn-xs"><i class="fa fa-pencil"></i> Edit</a>
										<a href="#" class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i> Remove</a>
										<input type="file" class="hide"/>
									</div>
								</div>
							</div>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

