<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Add Work place Modal-->
<div class="modal fade" id="addRoomModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">회의실 추가</h5>
				<button type="button" class="close" data-dismiss="modal"> &times;</button>
			</div>
			
			<form action="/resource/addRoom" method="post" enctype="multipart/form-data">
				<div class="modal-body">
					
					<div class="form-group">
						
						<div class="row">
							<div class="col-xs-2 col-sm-2 text-center">
								<label>이미지</label>
							</div>
							<div class="col-xs-9 col-sm-9">
								<input type="file" class="form-control" id="image" name="file"  accept="image/gif, image/jpeg, image/png" />
							</div>
						
							<div class="clearfix"></div>
						</div>
						
						<br>
						
						<div class="row">
							<div class="col-xs-2 col-sm-2 text-center">
								<label> 이름 </label>
							</div>
							<div class="col-xs-9 col-sm-9">
								<input type="text" class="form-control" name="name" placeholder="회의실 이름을 입력하세요" />
							</div>
						
							<div class="clearfix"></div>
						</div>
						
						<br>
						
						<div class="row">
							<div class="col-xs-2 col-sm-2 text-center">
								<label>지사</label>
							</div>
							<div class="col-xs-9 col-sm-9">
								<button class="btn btn-light dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			                      지사 선택 
			                    </button>
			                      <input type="hidden" name="workplaceNo" id="workplaceNo">
			                    <div id="workplaceDropdown" class="dropdown-menu animated--fade-in" aria-labelledby="dropdownMenuButton">
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
								<label> 인원 </label>
							</div>
							<div class="col-xs-9 col-sm-9">
								<input type="number" class="form-control" name="capacity" placeholder="수용 인원을 입력하세요" />
							</div>
						
							<div class="clearfix"></div>
						</div>
						
						<br>
						
						<div class="row">
							<div class="col-xs-2 col-sm-2 text-center">
								<label> 비품 </label>
							</div>
							<div class="col-xs-9 col-sm-9">
								<select id="option-drop-demo" multiple="multiple" class="form-control">
									<optgroup label="비품 목록">
										<c:forEach items="${equipDistinctList}" var="list">
												<option value="${list}">${list}</option>
										</c:forEach>
						        	</optgroup>
							    </select>
							    <input type="hidden" id="equipName" name="equipList">
							</div>
						
							<div class="clearfix"></div>
						</div>
						
						<br>
						
						<div class="row">
							<div class="col-xs-2 col-sm-2 text-center">
								<label> 네트워크 </label>
							</div>
							<div class="col-xs-9 col-sm-9">
								<input type="radio" id="nwY" name="nwAvailable" value="Y" /> <label for="nwY"> 가능 </label>
								<input type="radio" id="nwN" name="nwAvailable" value="N" /> <label for="nwN"> 불가능 </label>
							</div>
						
							<div class="clearfix"></div>
							<input type="hidden" name="adminId" value="${adminId}">
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

	/* 모달 사라졌을 때 입력 값 초기화 */
	$('.modal').on('hidden.bs.modal', function (e) {
	  $(this).find('form')[0].reset();
	  $('#dropdownMenuButton').text("지사 선택");
	});
	
	/* 지사 드롭박스 선택 시 텍스트 변경 */
	$('#workplaceDropdown a').on('click', function() {
	    $('#dropdownMenuButton').text($(this).text());
	    $('#workplaceNo').val($(this).attr('value'));
	});
	
	var arrSelected = [];
	$('#option-drop-demo').multiselect({buttonWidth: '340px'});
	$('#option-drop-demo').on('change', function(){
	    var selected = $(this).find("option:selected");
	    arrSelected = [];
	    selected.each(function(){
	       arrSelected.push($(this).val());
	    });
	    console.log(arrSelected);
	    $('#equipName').val(arrSelected);
	});
</script>