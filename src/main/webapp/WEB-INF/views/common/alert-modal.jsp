<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>

<div id="successModal" class="modal hide fade" style="width: 300px; margin: -150px 0 0 -150px">
	<div class="modal-body">
		<p>처리되었습니다.</p>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" onClick="window.location.reload()">
			닫기
		</button>
	</div>
</div>

<div id="check-blankModal" class="modal hide fade" style="width: 300px; margin: -150px 0 0 -150px">
	<div class="modal-body">
		<p>입력되지 않은 항목이 있습니다.</p>
		<p>입력 후, [저장]버튼을 눌러 주세요.</p>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal">닫기</button>
	</div>
</div>

<div id="failureModal" class="modal hide fade" style="width: 300px; margin: -150px 0 0 -150px">
	<div class="modal-body">
		<p>
		
		</p>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal">닫기</button>
	</div>
</div>

<div id="deleteModal" class="modal hide fade" style="width: 300px; margin: -150px 0 0 -150px">
	<div class="modal-body">
		<p>삭제하시겠습니까?</p>
	</div>
	<div class="modal-footer">
		<button class="btn" id="confirm-button" type="submit" onClick="DeleteBtnClick()">확인</button>
		<button class="btn" id="cancle-button" data-dismiss="modal">취소</button>
	</div>
</div>

<div id="deleteImgModal" class="modal hide fade" style="width: 300px; margin: -150px 0 0 -150px">
	<div class="modal-body">
		<p>이미지를 삭제하시겠습니까?</p>
	</div>
	<div class="modal-footer">
		<button class="btn" id="confirm-button" onClick="removeImage('delete')">확인</button>
		<button class="btn" id="cancle-button" data-dismiss="modal" onClick="removeImage('cancle')">취소</button>
	</div>
</div>

<div id="checkDeleteModal" class="modal hide fade" style="width: 300px; margin: -150px 0 0 -150px">
	<div class="modal-body">
		<p>삭제할 항목을 선택해주세요.</p>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal">닫기</button>
	</div>
</div>

<div id="checkSelectModal" class="modal hide fade" style="width: 300px; margin: -150px 0 0 -150px">
	<div class="modal-body">
		<p>선택된 항목이 없습니다.</p>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal">닫기</button>
	</div>
</div>

