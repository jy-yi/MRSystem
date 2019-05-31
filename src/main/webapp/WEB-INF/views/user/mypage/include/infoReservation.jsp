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
							<label> 예약번호 </label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="text" class="form-control" id="reservationNo"/>
						</div>
					
						<div class="clearfix"></div>
					</div>
					
					<br>	
					
					<div class="row">
						<div class="col-xs-2 col-sm-2 text-center">
							<label> 사원번호 </label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="text" class="form-control" id="employeeNo"/>
						</div>
					
						<div class="clearfix"></div>
					</div>
					
					<br>
					
					<div class="row">
						<div class="col-xs-2 col-sm-2 text-center">
							<label> 회의실호 </label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="text" class="form-control" id="roomNo"/>
						</div>
					
						<div class="clearfix"></div>
					</div>
					
					<br>
					
					<div class="row">
						<div class="col-xs-2 col-sm-2 text-center">
							<label> 회의명 </label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="text" class="form-control" id="name" />
						</div>
					
						<div class="clearfix"></div>
					</div>
					
					<br>
					
					<div class="row">
						<div class="col-xs-2 col-sm-2 text-center">
							<label> 회의목적 </label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="text" class="form-control" id="purpose" />
						</div>
					
						<div class="clearfix"></div>
					</div>
					
					<br>
					
					<div class="row">
						<div class="col-xs-2 col-sm-2 text-center">
							<label> 시작시간 </label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="text" class="form-control" id="startDate"/>
						</div>
					
						<div class="clearfix"></div>
					</div>
					
					<br>
					
					<div class="row">
						<div class="col-xs-2 col-sm-2 text-center">
							<label> 종료시간 </label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="text" class="form-control" id="endDate" />
						</div>
					
						<div class="clearfix"></div>
					</div>
					
					<br>
					
					<div class="row">
						<div class="col-xs-2 col-sm-2 text-center">
							<label> 간식여부 </label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="text" class="form-control" id="snackWant" />
						</div>
					
						<div class="clearfix"></div>
					</div>
					
					<br>
					
					<div class="row">
						<div class="col-xs-2 col-sm-2 text-center">
							<label> 승인상태 </label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="text" class="form-control" id="status" />
						</div>
					
						<div class="clearfix"></div>
					</div>
					
					
				</div>
			</div>
			
			<div class="modal-footer">
				<button class="btn btn-primary" type="button" data-dismiss="modal">확인</button>
			</div>
		</div>
	</div>
</div>

<script>
	/* 모달 사라졌을 때 입력 값 초기화 */
	$('.modal').on('hidden.bs.modal', function (e) {
	  $(this).find('form')[0].reset()
	});
</script>