<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<!DOCTYPE html>
<html>

<style>
#calendar {
	max-width: 1300px;
	margin: 0 auto;
	background-color: white;
}
</style>


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
								<div class="text-xs font-weight-bold text-info text-uppercase mb-1">
								
									오늘의 일정 -	<c:forEach items="${reservationInfo}" var="list" varStatus="status">
													<c:if test="${list.STATUS ne 3 }">
														
														${list.RESERVATIONNAME }		
													</c:if>
														
												</c:forEach>
												  											
								</div>

								<!-- 프로그레스 바 -->
								<div id="bar" style="display: none">
									<div class="row no-gutters align-items-center">

										<div class="col-auto">
											<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">50%</div>
										</div>
										<div class="col">
											<div class="progress progress-sm mr-2">
												<div class="progress-bar bg-info" role="progressbar"
													style="width: 50%" aria-valuenow="50" aria-valuemin="0"
													aria-valuemax="100"></div>	
											</div>
										</div>
									</div>
								</div>
								<!-- 프로그레스 바 끝 -->

							</div>

							<button id="startBtn" class="btn btn-secondary btn-icon-split">
								<span id="spanText" class="text">시작</span>
							</button>

							<a href="/reservation/statusList"
								class="btn btn-primary btn-icon-split"> <span class="text">목록형</span>
							</a>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

	<br>


	<!-- Begin Page Content -->
	<div class="container-fluid">

		<!-- Content Row -->
		<div id='calendar'></div>
	</div>

</div>
<!-- /.container-fluid -->

<!-- End of Main Content -->

<!-- Modal -->
<jsp:include page="include/infoReservation.jsp" />

</body>
<script>
	document.addEventListener('DOMContentLoaded',function() {
					 
						var calendarEl = document.getElementById('calendar');

						var calendar = new FullCalendar.Calendar(
								calendarEl,
								{
									plugins : [ 'interaction', 'dayGrid' ],	
									defaultDate : new Date(),
									editable : true,
									eventLimit : true, // allow "more" link when too many events

									events : [
										<c:forEach items="${reservationInfo}" var="list" varStatus="status">
											<c:if test="${list.STATUS ne 3 }">
											{ 
												id : '${list.RESERVATIONNO}',
												title : '${list.RESERVATIONNAME}',
												start : '${list.STARTDATE}',
												end : '${list.ENDDATE}'
											},
											</c:if>
										</c:forEach>
									], eventClick: function(info) {
										
										var reservationNo = info.event.id;
										var name = info.event.title;
										var start = info.event.start;
										var end = info.event.end;
										
										console.log(reservationNo);
										console.log(name);
										console.log(start);
										console.log(end);
										
										$("#reservationNo").val(reservationNo);
						        		$("#employeeNo").val(name); 	
						        	 	$("#roomNo").val(name);
							        	$("#name").val(name);
							    	 	$("#purpose").val(name);
							    	    $("#startDate").val(start);
							    	    $("#endDate").val(end);
							    	    $("#snackWant").val(name);
							    	    $("#status").val(name);
						        	 	
						        	 	$("#infoReservationModal").modal('show');
									}									
								});

						calendar.render();

						calendar.setOption('locale', 'ko'); // 달력 한국어 설정

					});	
</script>


<script type="text/javascript">
	$("#startBtn").click(function() {
		var bar = document.getElementById("bar");

		if (bar.style.display == 'none') {
			bar.style.display = 'block';
			$("#spanText").text('종료');

		} else {
			bar.style.display = 'none';
			$("#spanText").text('시작');
		}

	});
</script>

</html>