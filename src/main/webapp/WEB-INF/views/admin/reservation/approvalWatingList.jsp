<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Main Content -->
<div id="content">

	<!-- Begin Page Content -->
	<div class="container-fluid">

		<!-- Page Heading -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h1 class="h5 mb-0 text-gray-800">
				<i class="fas fa-user"></i> 예약 관리 > 승인 대기 목록
			</h1>
		</div>

		<!-- Content Row -->
		<div class="row">

			<!-- Begin Page Content -->
			<div class="container-fluid">

				<!-- DataTales Example -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary">승인 대기 목록</h6>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
								<thead>
									<tr>
										<th>No</th>
										<th>회의명</th>
										<th>회의 목적</th>
										<th>회의실</th>
										<th>기간</th>
										<th>신청자</th>
										<th>결재자</th>
										<th>승인</th>
										<th>반려</th>
									</tr>
								</thead>
								
								<tbody>
									<c:choose>
										<c:when test="${empty waitingList}">
											<td colspan="9" class="text-center"> 승인 대기 중인 예약이 존재하지 않습니다.</td>
										</c:when>
										<c:otherwise>
											<c:forEach items="${waitingList}" var="list" varStatus="status">
												<c:if test="${adminId eq list.ADMIN_ID }">
													<tr>
														<td> ${status.count}</td>
														<td> ${list.RESNAME} </td>
														<td> ${list.PURPOSE}</td>
														<td> ${list.ROOMNAME}</td>
														<td> ${list.STARTDATE} - ${list.ENDDATE}</td>
														<td> 
															${list.EMPNAME} 
															<input type="hidden" value="${list.EMAIL }">
															<input type="hidden" value="${list.EMPNO }">
														</td>
														
														
														<c:choose>
															<c:when test="${list.MANAGERAPPROVAL eq 'W'}">
																<td> 승인 대기</td>
																<td> 승인 대기</td>
																<td> 승인 대기</td>
															</c:when>	
															<c:otherwise>
																<td> ${list.MGRNAME}</td>
																<td><a href="#" class="btn btn-primary"> <span class="text">승인</span></a></td>
																<td><a href="#" class="btn btn-danger"> <span class="text">반려</span></a></td>
																<input type="hidden" id="reservationNo" value="${list.RESERVATIONNO}">
															</c:otherwise>
														</c:choose>
													</tr>
												</c:if>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
					</div>
				</div>

			</div>
			<!-- /.container-fluid -->

		</div>

	</div>
	<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->

<script>
/* 승인 버튼 클릭 */
$(document).on("click", ".btn-primary", function() {
	var reservationNo = $(this).parent().next().next().val();	// 승인할 예약 번호
	var empName = $(this).parent().prev().prev().text();
	var reservationName = $(this).parent().prev().prev().prev().prev().prev().prev().text();
	
	swal({
		title: '해당 예약을 승인처리 하시겠습니까?',
		text: "신청자 : " + empName + " / 회의명 : " + reservationName,
		type: 'question',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		    confirmButtonText: 'Yes',
		    cancelButtonText: 'No',
		}).then( (result) => {
			if (result.value) {
  			$.ajax({
				url : "/reservation/adminApproval",
				type : "POST",
				data : {
					reservationNo : reservationNo,
					status : 1
				}, success : function(data) {
					swal('Success!', '예약 승인이 완료되었습니다.', 'success'
			    		).then(function(){
  		    		    	location.href="/reservation/approvalWaitingList";
  		    		    });
				}
			});
			}
			  
		});
});


/* 반려 버튼 클릭 */
$(document).on("click", ".btn-danger", function() {
	var reservationNo = $(this).parent().next().val();	// 반려할 예약 번호
	var empName = $(this).parent().prev().prev().prev().text();
	var email = $(this).parent().prev().prev().prev().children().val();
	var empNo = $(this).parent().prev().prev().prev().children().next().val();
	var term = $(this).parent().prev().prev().prev().prev().text();
	var reservationName = $(this).parent().prev().prev().prev().prev().prev().prev().prev().text();
	
	swal({
		title: '정말 반려하시겠습니까?',
		text: "이후 복구는 불가능합니다.",
		type: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		    confirmButtonText: 'Yes',
		    cancelButtonText: 'No',
		}).then( (result) => {
			if (result.value) {
				Swal.mixin({
					  input: 'text',
					  confirmButtonText: '확인',
					  showCancelButton: true
					}).queue([
					  {
					    title: '반려 사유를 작성하세요',
					    text: '해당 사유는 신청자에게 메일로 전송됩니다.'
					  },
					]).then((result) => {
					  if (result.value) {
						 
						  /* 반려 사유 아무것도 작성하지 않았을 경우 */
						  if ($.trim(result.value[0]) == "") {
							  return;
						  } else {
				  			$.ajax({
								url : "/reservation/adminRefuse",
								type : "POST",
								data : {
									reservationNo : reservationNo,
									reason : result.value[0],
									status : 2,
									name : empName,
									email : email,
									empNo : empNo,
									term : term,
									reservationName : reservationName
								}, success : function(data) {
									swal('Success!', '반려가 완료되었습니다.', 'success'
						    		).then(function(){
			  		    		    	location.href="/reservation/approvalWaitingList";
			  		    		    });
								}
							});
						  }
				  			
					  }
					})
			}
			  
		});
});
</script>