<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>

<div id="successModal" class="modal hide fade" style="width: 300px; margin: -150px 0 0 -150px">
	<div class="modal-body">
		<p>Success</p>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" onClick="window.location.reload()">
			Close
		</button>
	</div>
</div>

<div id="check-blankModal" class="modal hide fade" style="width: 300px; margin: -150px 0 0 -150px">
	<div class="modal-body">
		<p>Please input item</p>
		<p>Please click save</p>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal">Close</button>
	</div>
</div>

<div id="failureModal" class="modal hide fade" style="width: 300px; margin: -150px 0 0 -150px">
	<div class="modal-body">
		<p>
		
		</p>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal">Close</button>
	</div>
</div>

<div id="deleteModal" class="modal hide fade" style="width: 300px; margin: -150px 0 0 -150px">
	<div class="modal-body">
		<p>Would you like to delete?</p>
	</div>
	<div class="modal-footer">
		<button class="btn" id="confirm-button" type="submit" onClick="DeleteBtnClick()">Ok</button>
		<button class="btn" id="cancle-button" data-dismiss="modal">Cancel</button>
	</div>
</div>

<div id="deleteImgModal" class="modal hide fade" style="width: 300px; margin: -150px 0 0 -150px">
	<div class="modal-body">
		<p>Are you sure you want to delete this image?</p>
	</div>
	<div class="modal-footer">
		<button class="btn" id="confirm-button" onClick="removeImage('delete')">Ok</button>
		<button class="btn" id="cancle-button" data-dismiss="modal" onClick="removeImage('cancle')">Cancel</button>
	</div>s
</div>

<div id="checkDeleteModal" class="modal hide fade" style="width: 300px; margin: -150px 0 0 -150px">
	<div class="modal-body">
		<p>Please select an item to delete</p>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal">Close</button>
	</div>
</div>

<div id="checkSelectModal" class="modal hide fade" style="width: 300px; margin: -150px 0 0 -150px">
	<div class="modal-body">
		<p>There is no selected item</p>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal">Close</button>
	</div>
</div>

