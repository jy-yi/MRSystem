<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Edit Work place Modal-->
<div class="modal fade" id="editRoomModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">회의실 수정</h5>
				<button type="button" class="close" data-dismiss="modal"> &times;</button>
			</div>
			
			<form action="/resource/editRoom" method="post" enctype="multipart/form-data">
				<div class="modal-body">
					
					<div class="form-group">
						
						<div class="row">
							<div class="col-xs-2 col-sm-2 text-center">
								<label>이미지</label>
							</div>
							<div class="col-xs-9 col-sm-9">
								<input type="file" class="form-control" id="editImage" name="img" accept="image/gif, image/jpeg, image/png"/>
							</div>
						
							<div class="clearfix"></div>
						</div>
						
						<br>
						
						<div class="row">
							<div class="col-xs-2 col-sm-2 text-center">
								<label> 이름 </label>
							</div>
							<div class="col-xs-9 col-sm-9">
								<input type="text" class="form-control" id="editName" name="name" placeholder="회의실 이름을 입력하세요" />
								<input type="hidden" class="form-control" id="editRoomNo" name="roomNo" />
							</div>
						
							<div class="clearfix"></div>
						</div>
						
						<br>
						
						<div class="row">
							<div class="col-xs-2 col-sm-2 text-center">
								<label>지사</label>
							</div>
							<div class="col-xs-9 col-sm-9">
								<button class="btn btn-light dropdown-toggle" type="button" id="editDropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			                      지사 선택 
			                    </button>
			                      <input type="hidden" name="workplaceNo" id="editWorkplaceNo">
			                    <div id="editWorkplaceDropdown" class="dropdown-menu animated--fade-in" aria-labelledby="dropdownMenuButton">
			                    	<c:forEach items="${workplaceList}" var="list">
				                      <a class="dropdown-item" value="${list.workplaceNo}">${list.name}</a>
			                    	</c:forEach>
			                    </div>
							</div>
						
							<div class="clearfix"></div>
						</div>
						
						<br>
						
						<div class="row">
							<div class="col-xs-2 col-sm-2 text-center">
								<label>유형</label>
							</div>
							<div class="col-xs-9 col-sm-9">
								<button class="btn btn-light dropdown-toggle" type="button" id="editDropdownMenuRoomType" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			                      회의실 유형 선택 
			                    </button>
		                      	<input type="hidden" name="type" id="editRoomType">
			                    <div id="editRoomTypeDropdown" class="dropdown-menu animated--fade-in" aria-labelledby="editDropdownMenuRoomType">
				                      <a class="dropdown-item" value="회의실">회의실</a>
				                      <a class="dropdown-item" value="교육실">교육실</a>
				                      <a class="dropdown-item" value="대회의실">대회의실</a>
			                    </div>
							</div>
						
							<div class="clearfix"></div>
						</div>
						
						<br>
						
						<div class="row">
							<div class="col-xs-2 col-sm-2 text-center">
								<label> 인원 </label>
							</div>
							<div class="col-xs-9 col-sm-9">
								<input type="number" class="form-control" id="editCapacity" name="capacity" placeholder="" />
							</div>
						
							<div class="clearfix"></div>
						</div>
						
						<br>
						
						<div class="row">
							<div class="col-xs-2 col-sm-2 text-center">
								<label> 네트워크 </label>
							</div>
							<div class="col-xs-9 col-sm-9">
								<input type="radio" id="editNwY" name="nwAvailable" value="Y" /> <label for="editNwY"> 가능 </label>
								<input type="radio" id="editNwN" name="nwAvailable" value="N" /> <label for="editNwN"> 불가능 </label>
							</div>
						
							<div class="clearfix"></div>
							<input type="hidden" name="adminId" value="${login.employeeNo}">
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
	var roomNo="";
	var workplaceNo="";
	var workplaceName="";
	var image="";
	var name="";
	var type="";
    var capacity="";
    var nwAvailable="";
    
	$(function() {     
        $('#editRoomModal').on('show.bs.modal', function(event) {          
        	roomNo = $(event.relatedTarget).data('roomno');
        	workplaceNo = $(event.relatedTarget).data('workplaceno');
        	workplaceName = $(event.relatedTarget).data('workplacename');
        	image = $(event.relatedTarget).data('image');
        	name = $(event.relatedTarget).data('name');
        	type = $(event.relatedTarget).data('type');
        	capacity = $(event.relatedTarget).data('capacity');
        	nwAvailable = $(event.relatedTarget).data('nwavailable');
        	
        	 $("#editRoomNo").val(roomNo);
        	 $("#editWorkplaceNo").val(workplaceNo);
//         	 $("#editImage").val(name);
        	 $("#editName").val(name);
        	 $('#editDropdownMenuButton').text(workplaceName);
        	 $('#editDropdownMenuRoomType').text(type);
    	     $("#editCapacity").val(capacity);
    	     
    	     if (nwAvailable === 'Y') 
    	    	 $("input:radio[id='editNwY']").prop('checked', true);
    	     else
    	    	 $("input:radio[id='editNwN']").prop('checked', true);
        });
    });
	
	/* 지사 드롭박스 선택 시 텍스트 변경 */
	$('#editWorkplaceDropdown a').on('click', function() {
	    $('#editDropdownMenuButton').text($(this).text());
	    $('#editWorkplaceNo').val($(this).attr('value'));
	});
	
	/* 회의실 유형 드롭박스 선택 시 텍스트 변경 */
	$('#editRoomTypeDropdown a').on('click', function() {
	    $('#editDropdownMenuRoomType').text($(this).text());
	    $('#editRoomType').val($(this).attr('value'));
	});
</script>