<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.15/css/bootstrap-multiselect.css" type="text/css">
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.15/js/bootstrap-multiselect.min.js"></script>

<!-- Add Equipment Modal-->
<div class="modal fade" id="addEquipModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">비품 추가</h5>
				<button type="button" class="close" data-dismiss="modal"> &times;</button>
			</div>
			
			<form action="/resource/addEquipment" method="post">
				<div class="modal-body">
					
					<div class="form-group">
						<div class="row">
							<div class="col-xs-2 col-sm-2 text-center">
								<label> 비품명 </label>
							</div>
							<div class="col-xs-9 col-sm-9">
								<input type="text" class="form-control" id="name" name="name" placeholder="비품 이름을 입력하세요" required="required" />
							</div>
						
							<div class="clearfix"></div>
						</div>
						
						<br>
						
						<div class="row">
							<div class="col-xs-2 col-sm-2 text-center">
								<label> 구매일 </label>
							</div>
							<div class="col-xs-9 col-sm-9">
				                <div class="input-group input-append date" id="datePicker">
				                    <input type="text" class="form-control" name="buyDate" placeholder="비품 구매일을 입력하세요" required="required">
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
								<select id="option-droup-demo" multiple="multiple" class="form-control">
									<c:forEach items="${workplaceNameList}" var="workpalceList">
										<optgroup label="${workpalceList}">
											
										<c:forEach items="${roomList}" var="roomList" varStatus="status">
											<c:if test="${workpalceList eq  roomList.WORKPLACENAME}">
												<option value="${roomList.ROOMNO}">${roomList.ROOMNAME }</option>
											</c:if>
										</c:forEach>
							        	</optgroup>
									</c:forEach>
							    </select>
							    <input type="hidden" id="roomNo" name="roomNoList" value="">
							</div>
						
							<div class="clearfix"></div>
						</div>
					</div>
				</div>
			
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
					<input type="submit" class="btn btn-primary" value="추가" >
				</div>
			</form>
		</div>
	</div>
</div>

<script>
	$(function() {
	    $('#datePicker').datepicker({
	    	calendarWeeks: false,
	        todayHighlight: true,
	        autoclose: true,
	        format: "yyyy-mm-dd",
	        language: "kr"
        });
	    
	    $('#option-droup-demo').multiselect({buttonWidth: '340px'});
	});
	
	/* 모달 사라졌을 때 입력 값 초기화 */
	$('.modal').on('hidden.bs.modal', function (e) {
	  $(this).find('form')[0].reset();
	});
	
	var arrSelected = [];
	$('#option-droup-demo').on('change', function(){
	    var selected = $(this).find("option:selected");
	    arrSelected = [];
	    selected.each(function(){
	       arrSelected.push($(this).val());
	    });
	    $('#roomNo').val(arrSelected);
	});
	
</script>