<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<!DOCTYPE html>
<html>
<c:forEach var="resList" items="${reservationInfo}">
	${resList.name }
</c:forEach>
<script>
	document
			.addEventListener(
					'DOMContentLoaded',
					function() {
						
						var calendarEl = document.getElementById('calendar');
						
						var calendar = new FullCalendar.Calendar(
								calendarEl,
								{
									plugins : [ 'interaction', 'dayGrid' ],
									defaultDate : '2019-04-12',
									editable : true,
									eventLimit : true, // allow "more" link when too many events

									events : [ {
										title : 'dddd',
										start : '2019-04-01'
									}, {
										title : 'Long Event',
										start : '2019-04-07',
										end : '2019-04-10'
									}, {
										groupId : 999,
										title : 'Repeating Event',
										start : '2019-04-09T16:00:00'
									}, {
										groupId : 999,
										title : 'Repeating Event',
										start : '2019-04-16T16:00:00',
										end : '2019-04-16T18:00:00'
									}, {
										title : 'Conference',
										start : '2019-04-11',
										end : '2019-04-13'
									}, {
										title : 'Meeting',
										start : '2019-04-12T10:30:00',
										end : '2019-04-12T12:30:00'
									}, {
										title : 'Lunch',
										start : '2019-04-12T12:00:00'
									}, {
										title : 'Meeting',
										start : '2019-04-12T14:30:00'
									}, {
										title : 'Happy Hour',
										start : '2019-04-12T17:30:00'
									}, {
										title : 'Dinner',
										start : '2019-04-12T20:00:00'
									}, {
										title : 'Birthday Party',
										start : '2019-04-13T07:00:00'
									}, {
										title : 'Birthday Party',
										start : '2019-04-13T10:00:00'
									}, {
										title : 'Birthday Party2',
										start : '2019-04-13T09:30:00'
									}, {
										title : 'Birthday Party',
										start : '2019-04-13T08:00:00'
									}, {
										title : 'Birthday Party',
										start : '2019-04-13T11:00:00'
									}, {
										title : 'Birthday Party',
										start : '2019-04-13T18:00:00'
									}, {
										title : 'Birthday Party22224',
										start : '2019-04-13T21:00:00'
									}, {
										title : 'Click for Google',
										url : 'http://google.com/',
										start : '2019-04-28'
									} ],
									eventClick : function(event) {
										swal({
											title : '선택한 예약의 상세정보',
											html : '예약번호 : <br/> 사원번호 : <br/> 회의실번호 : <br/> 회의명 : <br/> 목적 : <br/> 시작시각 : <br/> 종료시각 : <br/> 간식준비여부 : <br/> 상태 : <br/>',
											type : '',
											confirmButtonText : 'OK'
										});
									}
								});

						calendar.render();

						calendar.setOption('locale', 'ko'); // 달력 한국어 설정

					});
	$("#startBtn").on("click", function() {
		alert("asd");
	});
</script>

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
								<div
									class="text-xs font-weight-bold text-info text-uppercase mb-1">오늘의
									일정</div>

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


</body>

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

		//$("#bar").toggle('show');
	});
</script>

</html>