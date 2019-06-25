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
								<div class="text-lg font-weight-bold text-info text-uppercase mb-1">
								
									[당일 가장 가까운 예약 일정]	
									<c:forEach items="${latestReservation}" var="list">
										<c:if test="${list.WOWDATE <= 10 && list.WOWDATE > - 10}">
											<c:choose>
												<c:when test="${list.WOWDATE >= 0 }">
													${list.NAME } : ${list.WOWDATE}분 남았습니다. <br>
												</c:when>
												<c:otherwise>
													${list.NAME } : ${list.WOWDATE * -1 }분 지났습니다. <br>
												</c:otherwise>
											</c:choose>
											회의 시작 후 10분 이내에 시작버튼을 누르지 않으면 NO-SHOW 처리되오니 유의하시기 바랍니다.
										</c:if>
									</c:forEach>	
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
							<button id="endBtn" class="btn btn-secondary btn-icon-split">
								<span id="spanText" class="text">끝</span>
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
												end : '${list.ENDDATE}',
												backgroundColor: 
													<c:if test="${list.STATUS eq 0 }">
														'skyblue',
													</c:if>
													<c:if test="${list.STATUS eq 1 }">
														'pink',
													</c:if>
													<c:if test="${list.STATUS eq 2 }">
														'orange',
													</c:if>
												borderColor: 
													<c:if test="${list.STATUS eq 0 }">
														'skyblue'
													</c:if>
													<c:if test="${list.STATUS eq 1 }">
														'pink'
													</c:if>
													<c:if test="${list.STATUS eq 2 }">
														'orange'
													</c:if>
											},
											</c:if>
										</c:forEach>
									], 	eventClick: function(info) {
										
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
	var reservationName = '';
	var startDate = '';
	var endDate = '';
	
	<c:forEach items="${latestReservation}" var="list">
		reservationName = "${list.NAME}";
		startDate = "${list.STARTDATE}";
		endDate = "${list.ENDDATE}";
		wowDate = "${list.WOWDATE}";
	</c:forEach>
	
	//console.log(wowDate);
	
	var startYear = startDate.substring(0, 4);
	var startMonth = startDate.substring(5, 7);
	var startDay = startDate.substring(8, 10);
	var startHour = startDate.substring(11, 13);
	var startMinute = startDate.substring(14, 16);
	
	var endYear = endDate.substring(0, 4);
	var endMonth = endDate.substring(5, 7);
	var endDay = endDate.substring(8, 10);
	var endHour = endDate.substring(11, 13);
	var endMinute = endDate.substring(14, 16);

	var myStartDate = new Date(startYear, startMonth, startDay, startHour, startMinute);
	var myEndDate = new Date(endYear, endMonth, endDay, endHour, endMinute);
	
	console.log("회의 예약명 : " + reservationName);
	console.log("나의 가장 최근 예약 회의 시작 날짜 및 시간 : "+ myStartDate);
	console.log("나의 가장 최근 예약 회의 끝 날짜 및 시간 : "+ myEndDate);
	
	var date = new Date();
    var currentDate = new Date(date.getFullYear(),(date.getMonth() + 1), date.getDate(), date.getHours(), date.getMinutes(), date.getSeconds());
    
    console.log("현재 분 : " + date.getMinutes());
    console.log("현재 날짜 및 시간 : " + currentDate);
    console.log("${login.name}");
    
    var testDate = myStartDate - currentDate;
    
    var temp = Math.round((testDate/1000)/60);
    
    console.log("예약시작시간 - 현재시간 temp >>>>>>  " + temp);
    
    // 현재시간이 예약시간의 -10분일때 시작버튼 뜨고
   	// -> currentDate == myDate.setMinutes(myDate.getMinute()-10)
    // 예약시간의 +10분까지 띄워줌
    
    var map = new Object();
    map.empNo = "${latestReservation[0].EMPNO}";
    map.reservationNo = "${latestReservation[0].RESERVATIONNO}";
    map.name = "${latestReservation[0].NAME}";
    map.startDate = "${latestReservation[0].STARTDATE}";
    map.endDate = "${latestReservation[0].ENDDATE}";
    map.wowDate = "${latestReservation[0].WOWDATE}";

    console.log(map.wowDate);
    
    /* ---------------------------------------------------------------------- */
    /* ---------------------------------------------------------------------- */
    /* ---------------------------------------------------------------------- */

    $("#endBtn").click(function(){
    	//alert("끝 버튼 클릭!");
    	
    	$.ajax({
    		url : "/reservation/deleteBorEquip",
			type : "POST",
			data : {
				reservationNo : map.reservationNo,
			}, success : function(data) {
				
				console.log(map.reservationNo);
				
				swal('끝 버튼 처리!', '대여물품 삭제 및 비용 계산이 됩니다.', 'success'
	    		).then(function(){
	    		    	location.href="/reservation/statusCalendar";
	    		});
			}, error : function(){
	            alert("끝 버튼 처리 에러");
	        }
    	});
    	
    });
    
    
    
    /* if (-10 < map.wowDate && map.wowDate <= 10) {
    	console.log(map.name + " : " + map.wowDate +"분 남았습니다.");
    
    	var startBtn = document.getElementById("startBtn");
    	
			// 시간 비교
		if (startBtn.style.display == 'none') {
    		// 시작버튼 활성화
    		startBtn.style.display = 'block';
			$("#spanText").text('시작');
		}
		// 시작 버튼 클릭
		$("#startBtn").click(function() {
				
			console.log("startBtn 클릭 안의 temp >>>>>>> " + temp);
			if (temp <= -10) {
				console.log("startBtn 클릭 안의 temp가 -10보다 작거나 같을 때의 temp >>>>>>> " + temp);
				$.ajax({
					url : "/reservation/cancelReservation",
					type : "POST",
					data : {
						reservationNo : map.reservationNo,
						reason : "NO-SHOW로 인해 예약이 강제 취소되었습니다.",
						status : 3,
						name : "${login.name}",
						empNo : map.empNo,
						term : map.startDate + " - " + map.endDate,									
						reservationName : map.name
		
					}, success : function(data) {
						swal('예약 취소!', 'NO-SHOW로 인해 예약이 강제 취소되었습니다.', 'error'
			    		).then(function(){
			    		    	location.href="/reservation/statusCalendar";
			    		});
					}
				});
			} else {
				alert("시작 버튼 클릭!");
				console.log(map.name + ", " + map.reservationNo);
				$("#spanText").text('끝');
			}
		});
    } */
	
</script>