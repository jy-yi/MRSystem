<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
								
									가장 최근 회의 일정 -	${latestReservation.name} / ${latestReservation.startDate} ~ ${latestReservation.endDate}
									
								</div>

								<!-- 프로그레스 바 -->
								<div id="bar" style="display: none">
									<div class="row no-gutters align-items-center">

										<div class="col-auto">
											<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">70%</div>
										</div>
										<div class="col">
											<div class="progress progress-sm mr-2">
												<div class="progress-bar progress-bar-striped active" role="progressbar" style="width: 70%" aria-valuenow="70" aria-valuemin="0"
													aria-valuemax="100">70%</div>	
											</div>
										</div>
									</div>
								</div>
								<!-- 프로그레스 바 끝 -->

							</div>

							<button id="startBtn" class="btn btn-secondary btn-icon-split" style="display: none">
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
										console.log(reservationNo);
										
										$.ajax({
									        url : "/reservation/getCalendar",
									        data : {"reservationNo": reservationNo},
									        type : "GET",
									        success : function(data){
												
									        	console.log(data);
									        	
												$("#employeeName").val(data.EMPNAME);
								        	 	$("#roomName").val(data.ROOMNAME);
									        	$("#reservationName").val(data.RESERVATIONNAME);
									    	 	$("#purpose").val(data.PURPOSE);
									    	    $("#startDate").val(data.STARTDATE +" ~ "+data.ENDDATE);
								        	 	
								        	 	$("#infoReservationModal").modal('show');
									        },
									        error : function(){
									            alert("전체 예약 현황 조회 에러");
									        }
									    });
										
									}									
								});

						calendar.render();

						calendar.setOption('locale', 'ko'); // 달력 한국어 설정

					});	
</script>



<script type="text/javascript">
	
	// sysdate가 startDate의 10분전이라면 시작 버튼 표시
	/*  sysdate = TO_CHAR(start_date-10/24/60, 'YYYYMMDD HH24:MI:SS') */
	var date = "${latestReservation.startDate}";
	
	var year = date.substring(0, 4);
	var month = date.substring(5, 7);
	var day = date.substring(8, 10);
	var hour = date.substring(11, 13);
	var minute = date.substring(14, 16);

	var myDate = new Date(year, month, day, hour, minute);
	console.log("분 : " + minute);
	console.log("나의 가장 최근 날짜 : "+ myDate);
	
	var d = new Date();
    var currentDate = new Date(d.getFullYear(),(d.getMonth() + 1), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds());
    
    console.log("현재 분 : " + d.getMinutes());
    console.log("현재 날짜 및 시간 : " + currentDate);
    
    var testDate = myDate - currentDate;
    
    console.log(testDate/1000);
    
    // 현재시간이 예약시간의 -10분일때 시작버튼 뜨고
   	// -> currentDate == myDate.setMinutes(myDate.getMinute()-10)
    // 예약시간의 +10분까지 띄워줌
    
    //if(currentDate <){
    	var startBtn = document.getElementById("startBtn");
    	
    	if (startBtn.style.display == 'none') {
    		startBtn.style.display = 'block';
			$("#spanText").text('시작');

		} else {
			startBtn.style.display = 'none';
			$("#spanText").text('종료');
		}
  //  }
	
	/* // 시작 버튼을 눌렀을 때
	$("#startBtn").click(function() {
		var bar = document.getElementById("bar");

		if (bar.style.display == 'none') {
			bar.style.display = 'block';
			$("#spanText").text('종료');

		} else {
			bar.style.display = 'none';
			$("#spanText").text('시작');
		}

	}); */
	

		
</script>

