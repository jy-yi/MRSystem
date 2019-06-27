<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link href='/resources/css/dashboard.css' rel='stylesheet' />

<!-- Main Content -->
<div id="content">

	<!-- Begin Page Content -->
	<div class="container-fluid">

		<!-- Begin Page Content -->
		<div class="container-fluid">

			<!-- Page Heading -->
			<div class="d-sm-flex align-items-center justify-content-between mb-4">
				<h1 id="name" class="h5 mb-0 text-gray-800">
					<i class="fas fa-user"></i> 대시보드 > <span id="workplaceNameTitle"></span> <span id="roomNameTitle"></span>
				</h1>
			</div>
			
			<div class="mb-2">
				<a href="#" class="btn btn-success btn-circle btn-sm"></a> 승인 대기
				<a href="#" class="btn btn-primary btn-circle btn-sm"></a> 예약 완료
				<a href="#" class="btn btn-info btn-circle btn-sm"></a> 진행 중인 회의
				<a href="#" class="btn btn-secondary btn-circle btn-sm"></a> 사용 완료
				<a href="#" class="btn btn-warning btn-circle btn-sm"></a> No-Show
			</div>
			
			<br>

			<!-- Content Row -->
			<div class="row">
				<div class="panel with-nav-tabs panel-primary">
					<div class="panel-heading">
						<ul class="nav nav-tabs">
							<!-- 지사 목록 DB 연동 (session에 담겨있는 지사 목록) -->
							<c:forEach items="${workplaceList}" var="list" varStatus="status">
								<li class="dropdown">
		                            <a href="#workplace${list.workplaceNo}" class="nav-link workplace-list" data-toggle="dropdown" value="${list.workplaceNo}"> ${list.name} <i class="fas fa-caret-down"></i></a>
		                            <ul class="dropdown-menu" role="menu" id="roomList${list.workplaceNo}">
		                            </ul>
		                        </li>
							</c:forEach>
						</ul>
					</div>
				
					<div class="panel-body">
						<div class="tab-content">
							<div id="calendar"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /.container-fluid -->
	</div>
</div>
<!-- End of Main Content -->

<script>
var calendar;
document.addEventListener('DOMContentLoaded',function() {
				var calendarEl = document.getElementById('calendar');

				calendar = new FullCalendar.Calendar(
						calendarEl,
						{
							plugins : [ 'interaction', 'dayGrid' ],	
							defaultDate : new Date(),
							editable : true,
							eventLimit : true, // allow "more" link when too many events
							events : [
								<c:forEach items="${roomDashBoard}" var="list" varStatus="status">
									<c:if test="${list.STATUS ne 2 && list.STATUS ne 3 }">
									{ 
										id : '${list.RESNO}',
										title : '${list.RESERVATIONNAME}',
										start : '${list.STARTDATE}',
										end : '${list.ENDDATE}'
									},
									</c:if>
								</c:forEach>
							], 
							eventClick: function(info) {
								
								var reservationNo = info.event.id;
								
								$.ajax({
							        url : "/reservation/getCalendar",
							        data : {"reservationNo": reservationNo},
							        type : "GET",
							        success : function(data){
							        	
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

	$(function() {

		var workplaceNo = "";
		
		/* 회의실 버튼 눌렀을 때 */
		$(document).on("click", ".roomBtn", function() {
			var roomNo = $(this).attr('value');
			
			// 대시보드 > XXX > YYY (회의실 이름 동적 변경)
			$("#workplaceNameTitle").text($(this).parent().prev().text());
			$("#roomNameTitle").text(" > "+$(this).text());
			
			$('.workplace-list').removeClass('active');
			$(this).parent().prev().addClass('active');
			
			$.ajax({
				url : "/reservation/getRoomDashBoard",
				data : {
					"roomNo" : roomNo
				},
				type : "POST",
				dataType : 'json',
				success : function(data) {
					calendar.removeAllEvents();
					
					$.each(data.roomDashBoard, function(index, item){
						if(item.STATUS!=2 && item.STATUS!=3) {
							var color = "";
							if (item.STATUS == 0) {
									color = '#1cc88a';
								} else if (item.STATUS == 1) {
									color = '#4e73df';
								} else if (item.STATUS == 4) {
									color = '#36b9cc';
								} else if (item.STATUS == 5) {
									color = '#858796';
								} else if (item.STATUS == 6) {
									color = '#f6c23e';
								}
							var obj = {
										id : item.RESNO,
										title : item.RESERVATIONNAME,
										start : item.STARTDATE,
										end : item.ENDDATE,
										backgroundColor: color,
										borderColor: color
								};
							calendar.addEvent(obj);
						}
					})
				},
				error : function() {
					alert("회의실별 대쉬보드 조회 에러");
				}
			});
			
		});

		/* 지사 탭 클릭 이벤트 */
		$(".workplace-list").each(function(index, item) {
			workplaceNo = $(item).attr('value');

			$.ajax({
				url : "/statistic/getRoomListByWorkplaceNo",
				data : {
					"workplaceNo" : workplaceNo
				},
				type : "POST",
				dataType : 'json',
				async : false,
				success : function(data) {
					$("#roomList"+workplaceNo).empty();
					$.each(data.roomList, function(index, item){
						$("#roomList"+workplaceNo).append('<li class="roomBtn" value="'+ item.roomNo +'" style="text-align: center;"><a href="#" data-toggle="tab">'+ item.name + '</a></li>');
					});
				},
				error : function() {
					alert("지사별 해당 회의실 조회 에러");
				}
			});
			
		});

		/* 페이지 처음 로딩 시 지사 탭 제일 처음 클릭 이벤트 디폴트 처리 */
 		$('.roomBtn:first').trigger('click');
		
	});
</script>
<!-- Modal -->
<jsp:include page="include/infoReservation.jsp" />

</body>
