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
								<div class="text-lg font-weight-bold text-info text-uppercase mb-1" id="todayRes">
								
									<%-- <c:forEach items="${latestReservation}" var="list">
										<c:if test="${list.STATUS == 1 || list.STATUS == 4}">
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
										</c:if>
									</c:forEach>	 --%>
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

							<button id="start_end_Btn" class="btn btn-secondary btn-icon-split" style="display: none">
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
													<c:if test="${list.STATUS eq 4 }">
														'red',
													</c:if>
													<c:if test="${list.STATUS eq 5 }">
														'blue',
													</c:if>
													<c:if test="${list.STATUS eq 6 }">
														'yellow',	
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
													<c:if test="${list.STATUS eq 4 }">
														'red'
													</c:if>
													<c:if test="${list.STATUS eq 5 }">
														'blue'	
													</c:if>
													<c:if test="${list.STATUS eq 6 }">
														'yellow'	
													</c:if>
											},
											</c:if>
										</c:forEach>
									], 	
									eventClick: function(info) {
										
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
									},
									contentHeight: "auto"
								});

						calendar.render();

					});	
</script>



<script type="text/javascript">
	
	var resNo = '';
	var resName = '';
	var empNo = '';
	var startDate = '';
	var endDate = '';
	var status = '';
	var interval2 = '';
	
	/* 가장 최근 예약 1개 정보 가져오기 */
	function getOne(){
		$.ajax({
			url : "/reservation/getOne",
			type : "POST",
			dataType : 'json',
			async : false,
			data : {
				employeeNo : "${login.employeeNo}"
			}, success : function(data) {
				//console.log(data);
				if(data.one == null) {
					$("#todayRes").text("[당일 가장 가까운 예약 일정] 현재 가까운 예약 정보가 없습니다.");
					return false;					
				}
				console.log("-----------가장 최근 1개 정보------------");
				console.log("예약 번호 >>> " + data.one.RESERVATIONNO);
				console.log("회의 이름 >>> " + data.one.NAME);
				console.log("사원 번호 >>> " + data.one.EMPNO);
				console.log("시작 시간 >>> " + data.one.STARTDATE);
				console.log("종료 시간 >>> " + data.one.ENDDATE);
				console.log("승인 상태 >>> " + data.one.STATUS);
				console.log("-------------------------------");
				
				resNo = data.one.RESERVATIONNO;
				resName = data.one.NAME;
				empNo = data.one.EMPNO;
				startDate = data.one.STARTDATE;
				endDate = data.one.ENDDATE;
				status = data.one.STATUS;
			}
		});
	}
	
	// 실행하자마자 
	$(document).ready(function(){
		getOne();
		
		var startYear = startDate.substring(0, 4);
		var startMonth = startDate.substring(5, 7);
		var startDay = startDate.substring(8, 10);
		var startHour = startDate.substring(11, 13);
		var startMinute = startDate.substring(14, 16);
		var myStartDate = new Date(startYear, startMonth, startDay, startHour, startMinute);
		
		
		console.log("------------------------------");
		
		console.log("${login.name}" +"님의 예약 정보는 아래와 같습니다.");
		console.log("[ " + resName + " ] 회의 시작 시간 >>>> " + myStartDate + "분");
		console.log("승인 상태 status >>>> " + status);
		
		var interval = '';
	    
	    if(status == 1){
		    interval = setInterval(() => {
		    	
		    	var cd = new Date();
		    	
		    	var year = cd.getFullYear();
		    	var month = cd.getMonth()+1;
		    	var day = cd.getDate();
		    	var hour = cd.getHours();
		    	var minute = cd.getMinutes();
		    	var second = cd.getSeconds();
		    	
		    	var currDate = new Date(year, month, day, hour, minute, second);
		    	
		    	var result = Math.round(((myStartDate.getTime()/1000/60) - (currDate.getTime()/1000/60)));
		    	
		    	console.log("--------------------------");
		    	
		    	if(result >= 0){
		    		console.log(result+"분 남았습니다.");
		    	} else{
		    		console.log((result * -1)+"분 지났습니다.");
		    	}
		    	
		    	console.log(((myStartDate.getTime()/1000/60) - (currDate.getTime()/1000/60)));
		    	
		    	console.log("--------------------------");	    
		    	
		    	if (-10 < result && result <= 10) {
		   	    	var start_end_Btn = document.getElementById("start_end_Btn");
		   	    	
		   	    	if(result >= 0) {
		   	    		$("#todayRes")
						.text("[당일 가장 가까운 예약 일정]  " + resName + " >> "+ result + "분 남았습니다.");
		   	    	} else{
		   	    		$("#todayRes")
						.text("[당일 가장 가까운 예약 일정]  " + resName + " >> "+ (result * -1) + "분 지났습니다.");
		   	    	}
		   	    	
		   			if (start_end_Btn.style.display == 'none') {
		   	    		// 시작버튼 활성화
		   	    		start_end_Btn.style.display = 'block';
		   				$("#spanText").text('시작');
		   			}
		   	    }
		    	else if(result <= -10){
					$("#todayRes").text("[당일 가장 가까운 예약 일정] 현재 가까운 예약 정보가 없습니다.");
					console.log("10분 초과 인터벌 클리어");
			    	clearInterval(interval);
			    }
			}, 1000);
	    } else if(status == 4){
	  		if (start_end_Btn.style.display == 'none') {
	    		start_end_Btn.style.display = 'block';
				$("#spanText").text('종료');
	  		}
	  		
	  		console.log("status 4");
	   	}
	    
	 	// 시작 버튼 클릭
	 	
		$("#start_end_Btn").click(function() {
			if(status == 1){
			
			console.log("------------시작 버튼이 눌린 후------------");
			console.log("예약명 > " + resName + ", " + "예약번호 > " + resNo);
			
			$("#spanText").text('종료');
			
			// STATUS를 예약 승인(1) -> 예약 시작(4)로 바꿔줌
			$.ajax({
				url : "/reservation/updateStart",
				type : "POST",
				data : {
					reservationNo : resNo,
					status : 4
				}, success : function(data) {
					
					status = 4;
					console.log("현재 status >>> " + status);
					swal('회의 시작!', '회의가 시작됩니다', 'success');
					console.log("시작 버튼 눌러서 인터벌 클리어");
					clearInterval(interval);
				}
			});
		
	 		} else if(status==4){
	 		// 종료 버튼 클릭
	 			$("#start_end_Btn").click(function(){
	 				console.log("종료버튼 클릭!");
	 				$.ajax({
	 		    		url : "/reservation/deleteBorEquip",
	 					type : "POST",
	 					data : {
	 						reservationNo : resNo,
	 					}, success : function(data) {
	 						
	 						console.log(resNo);
	 						
	 						swal({
	 							title: '정말 종료하시겠습니까?',
	 							text: "대여물품 삭제 및 비용 계산이 됩니다.",
	 							type: 'warning',
	 							showCancelButton: true,
	 							confirmButtonColor: '#3085d6',
	 							cancelButtonColor: '#d33',
	 				  		    confirmButtonText: 'Yes',
	 				  		    cancelButtonText: 'No',
	 				  		}).then( (result) => {
	 				  			if (result.value) {
			 						$.ajax({
			 							url : "/reservation/updateStart",
			 							type : "POST",
			 							data : {
			 								reservationNo : resNo,
			 								status : 5
			 							}, success : function(data) {
			 								
			 								status = '';
			 								console.log("현재 status:"+status);
			 								swal('회의 종료!', '회의가 종료됩니다', 'success');
			 								
			 								start_end_Btn.style.display = 'none';
			 							}
			 						});
		 							getOne();
	 				  			}
	 				  		});
	 						
	 					}, error : function(){
	 			            alert("종료 버튼 처리 에러");
	 			        }
	 		    	});
	 			});
	 		}
	    
	 	});
		
		
	});
	 
</script>