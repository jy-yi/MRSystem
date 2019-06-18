<%@ page contentType="text/html; charset=UTF-8"%>

<!-- info reservation Modal-->
<div class="modal fade" id="infoReservationModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">예약 상세 정보</h5>
				<button type="button" class="close" data-dismiss="modal"> &times;</button>
			</div>
			
			<div class="modal-body">
				
				<div class="form-group">
					
					<div class="row">
						<div class="col-xs-2 col-sm-2 text-center">
							<label> 신청자 </label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="text" class="form-control" id="employeeName" readonly="readonly"/>
						</div>
					
						<div class="clearfix"></div>
					</div>
					
					<br>
					
					<div class="row">
						<div class="col-xs-2 col-sm-2 text-center">
							<label> 회의실 </label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="text" class="form-control" id="roomName" readonly="readonly"/>
						</div>
					
						<div class="clearfix"></div>
					</div>
					
					<br>
					
					<div class="row">
						<div class="col-xs-2 col-sm-2 text-center">
							<label> 회의명 </label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="text" class="form-control" id="reservationName" readonly="readonly"/>
						</div>
					
						<div class="clearfix"></div>
					</div>
					
					<br>
					
					<div class="row">
						<div class="col-xs-2 col-sm-2 text-center">
							<label> 목적 </label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="text" class="form-control" id="purpose" readonly="readonly"/>
						</div>
					
						<div class="clearfix"></div>
					</div>
					
					<br>
					
					<div class="row">
						<div class="col-xs-2 col-sm-2 text-center">
							<label> 기간 </label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="text" class="form-control" id="startDate" readonly="readonly"/>
						</div>
					
						<div class="clearfix"></div>
					</div>
					
					<br>
					
				</div>
			</div>
			
			<div class="modal-footer">
				<button class="btn btn-primary" type="button" data-dismiss="modal">확인</button>
			</div>
		</div>
	</div>
</div>