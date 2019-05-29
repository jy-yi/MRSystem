<%@ page contentType="text/html; charset=UTF-8"%>

<!-- Edit Work place Modal-->
<div class="modal fade" id="editRoomModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">회의실 수정</h5>
				<button type="button" class="close" data-dismiss="modal"> &times;</button>
			</div>
			
			<div class="modal-body">
				
				<div class="form-group">
					
					<div class="row">
						<div class="col-xs-2 col-sm-2 text-center">
							<label>이미지</label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="file" class="form-control" id="nameForId" name="name" placeholder="" />
						</div>
					
						<div class="clearfix"></div>
					</div>
					
					<br>
					
					<div class="row">
						<div class="col-xs-2 col-sm-2 text-center">
							<label> 이름 </label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="text" class="form-control" id="nameForId" name="name" placeholder="회의실 이름을 입력하세요" />
						</div>
					
						<div class="clearfix"></div>
					</div>
					
					<br>
					
					<div class="row">
						<div class="col-xs-2 col-sm-2 text-center">
							<label>위치</label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="text" class="form-control" id="addressE" name="address" placeholder="위치를 입력하세요" />
						</div>
					
						<div class="clearfix"></div>
					</div>
					
					<br>
					
					<div class="row">
						<div class="col-xs-2 col-sm-2 text-center">
							<label> 인원 </label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="number" class="form-control" id="nameForId" name="name" placeholder="" />
						</div>
					
						<div class="clearfix"></div>
					</div>
					
					<br>
					
					<div class="row">
						<div class="col-xs-2 col-sm-2 text-center">
							<label> 비품 </label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="checkbox" id="nameForId" name="name" /> 빔 프로젝트
							<input type="checkbox" id="nameForId" name="name" /> 노트북
							<input type="checkbox" id="nameForId" name="name" /> 화이트보드
						</div>
					
						<div class="clearfix"></div>
					</div>
					
					<br>
					
					<div class="row">
						<div class="col-xs-2 col-sm-2 text-center">
							<label> 네트워크 </label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="radio" id="nameForId" name="name" /> 가능
							<input type="radio" id="nameForId" name="name" /> 불가능
						</div>
					
						<div class="clearfix"></div>
					</div>
					
				</div>
			</div>
			
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
				<a class="btn btn-primary" href="#">수정</a>
			</div>
		</div>
	</div>
</div>
