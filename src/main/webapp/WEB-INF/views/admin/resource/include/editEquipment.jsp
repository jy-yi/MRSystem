<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Add Equipment Modal-->
<div class="modal fade" id="editEquipModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">비품 수정</h5>
				<button type="button" class="close" data-dismiss="modal"> &times;</button>
			</div>
			
			<form action="/resource/editEquipment" method="post">
				<div class="modal-body">
					
					<div class="form-group">
						<div class="row">
							<div class="col-xs-2 col-sm-2 text-center">
								<label> 비품명 </label>
							</div>
							<div class="col-xs-9 col-sm-9">
								<input type="text" class="form-control" id="editName" name="name" placeholder="비품 이름을 입력하세요" required="required" />
							</div>
						
							<div class="clearfix"></div>
						</div>
						
						<br>
						
						<div class="row">
							<div class="col-xs-2 col-sm-2 text-center">
								<label> 구매일 </label>
							</div>
							<div class="col-xs-9 col-sm-9">
				                <div class="input-group input-append date" id="editDatePicker">
				                    <input type="text" class="form-control" id="editBuyDate" name="buyDate" placeholder="비품 구매일을 입력하세요" required="required" autocomplete="off">
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
							</div>
							
							<div class="clearfix"></div>
						</div>
						
						<br>
						
						<div class="row">
							<div class="col-xs-2 col-sm-2 text-center">
								<label> 비치장소 </label>
							</div>
							<div class="col-xs-9 col-sm-9">
								<input type="text" class="form-control" id="editRoomName" readonly="readonly" required="required"/>
							</div>
						
							<input type="hidden" id="editEquipNo" name="equipmentNo"/>
							<div class="clearfix"></div>
						</div>
					</div>
				</div>
			
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
					<input type="submit" class="btn btn-primary" value="수정" >
				</div>
			</form>
		</div>
	</div>
</div>

<script>
	$(function () {
		$('#editDatePicker').datepicker({
	        calendarWeeks: false,
	        todayHighlight: true,
	        autoclose: true,
	        format: "yyyy-mm-dd",
	        language: "kr"
	    });
	})	

	
	var equipNo="";
	var equipName="";
    var buyDate="";
    var roomName = "";
	
	$(function() {     
        $('#editEquipModal').on('show.bs.modal', function(event) {          
        	equipNo = $(event.relatedTarget).data('equipno');
        	equipName = $(event.relatedTarget).data('equipname');
        	buyDate = $(event.relatedTarget).data('buydate');
        	roomName = $(event.relatedTarget).data('roomname');
        	
        	$("#editEquipNo").val(equipNo);
        	$("#editName").val(equipName);
    	    $("#editBuyDate").val(buyDate);
    	    $("#editRoomName").val(roomName);
        });
    });
	
</script>