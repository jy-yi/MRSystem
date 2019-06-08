<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>

<!DOCTYPE html>
<html>

<!-- Main Content -->
<div id="content">

	<!-- Begin Page Content -->
	<div class="container-fluid">

		<!-- Page Heading -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h1 class="h5 mb-0 text-gray-800">
				<i class="fas fa-user"></i> 마이페이지 > 예약 현황
			</h1>
		</div>

		<!-- Content Row -->
		<div class="row">

			<!-- Earnings (Monthly) Card Example -->
			<div class="col-xl-12 col-md-12 mb-6">
				<div class="card border-left-info shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-xs font-weight-bold text-info text-uppercase mb-1">오늘의 일정</div>
								<div class="row no-gutters align-items-center">
									<div class="col-auto">
										<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">50%</div>
									</div>
									<div class="col">
										<div class="progress progress-sm mr-2">
											<div class="progress-bar bg-info" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">
											</div>
										</div>
									</div>
								</div>
							</div>
							<a href="/reservation/statusCalendar" class="btn btn-primary btn-icon-split">
			                    <span class="text">달력형</span>
		                    </a>
						</div>
					</div>
				</div>
			</div>
		</div>

		<p>
		<p>

		<!-- Content Row -->
		<div class="row">

			<!-- Begin Page Content -->
			<div class="container-fluid">

				<!-- DataTales Example -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary">나의 예약 현황</h6>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-bordered" id="dataTable" width="100%"
								cellspacing="0">
								<thead>
									<tr>
										<th>No</th>
										<th>회의명</th>
										<th>회의 목적</th>
										<th>회의실</th>
										<th>기간</th>
										<th>주관부서</th>
										<th>승인 상태</th>
										<th>취소</th>
									</tr>
								</thead>

								<tbody>
									<c:choose>
										<c:when test="${empty reservationList}">
											<td colspan="9" class="text-center"> 예약이 존재하지 않습니다.</td>
										</c:when>
										<c:otherwise>
											<c:forEach items="${reservationList}" var="list" varStatus="status">
												<tr>
													<td> ${status.count} </td>
													<td> ${list.RESERVATIONNAME}</td>
													<td> ${list.PURPOSE}</td>
													<td> ${list.ROOMNO}</td>
													<td> ${list.STARTDATE} - ${list.ENDDATE}</td>
													<td> ${list.DEPARTMENTNAME}</td>
													
													<c:if test="${list.STATUS eq 0 }">
														<td> <span class="text-danger"> 대기 </span> </td>
													</c:if>
													
													<c:if test="${list.STATUS eq 1 }">
														<td> <span class="text-warning"> 승인 </span> </td>
													</c:if>
													
													<c:if test="${list.STATUS eq 2 }">
														<td> <span class="text-primary"> 반려 </span></td>
													</c:if>
													
													<c:if test="${list.STATUS eq 3	 }">
														<td> <span class="text-primary"> 취소 </span></td>
													</c:if>
													
													<td>
														<a href="#" class="btn btn-danger"> <span class="text">취소</span> </a>
														<input type="hidden" id="reservationNo" name="reservationNo" value="${list.RESERVATIONNO}">
													</td>
												</tr>
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


</body>

</html>

<script type="text/javascript">
	
	/* 삭제 버튼 클릭 */
	$(document).on("click", ".btn-danger", function() {
		var reservationNo = $(this).next().val();	// 취소 버튼을 클릭한 예약 번호
		
		swal({
			title: '정말 삭제하시겠습니까?',
			text: "이후 복구는 불가능합니다.",
			type: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
  		    confirmButtonText: 'Yes',
  		    cancelButtonText: 'No',
  		}).then( (result) => {
  			if (result.value) {
	  			$.ajax({
					url : "/reservation/deleteReservation",
					type : "POST",
					data : {
						reservationNo : reservationNo,
					}, success : function(data) {
						swal('Success!', '예액 취소가 완료되었습니다.', 'success'
				    		).then(function(){
	  		    		    	location.href="/reservation/statusList";
	  		    		    });
					}
				});
  			}
  			  
  		});
	});
</script>