<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
#calendar {
	max-width: 1300px;
	margin: 0 auto;
	background-color: white;
}
.activeBtn{
	background-color: rgb(54,93,205);
	color: white;
}
.disabledBtn{
	background-color: #cecece;
	color: white;
}
</style>
<!-- Main Content -->
<div id="content">

	<!-- Begin Page Content -->
	<div class="container-fluid">

		<!-- Begin Page Content -->
		<div class="container-fluid">

			<!-- Page Heading -->
			<div class="d-sm-flex align-items-center justify-content-between mb-4">
				<h1 id="name" class="h5 mb-0 text-gray-800">
					<i class="fas fa-user"></i> 대시보드 > <span id="workplaceNameTitle"></span>
				</h1>
			</div>

			<!-- Content Row -->
			<div class="row">

				<ul class="nav nav-tabs">
					<!-- 지사 목록 DB 연동 (session에 담겨있는 지사 목록) -->
					<c:forEach items="${workplaceList}" var="list" varStatus="status">
						<li class="nav-item">
							<a class="nav-link workplace-list ${status.index eq 0 ? 'active':''}"
								data-toggle="tab" href="#workplace${list.workplaceNo}"
								value="${list.workplaceNo}">${list.name}
							</a>
						</li>
					</c:forEach>
				</ul>

				<div class="tab-content">
					<div id="roomList"></div>
					<div id="calendar"></div>
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


	$(function() {

		var workplaceNo = "";

		/* 지사 탭 클릭 이벤트 */
		$(".workplace-list").on("click", function() {
			workplaceNo = $(this).attr('value');

			// 대시보드 > XXX (지사 이름 동적 변경)
			$("#workplaceNameTitle").text($(this).text());

			// TODO : 탭 눌렀을 때 이벤트 다 지워버리고 다시 ajax로 뿌려주셈~ 화이팅!
			
			$.ajax({
				url : "/statistic/getRoomListByWorkplaceNo",
				data : {
					"workplaceNo" : workplaceNo
				},
				type : "POST",
				dataType : 'json',
				success : function(data) {
					console.log("success");
					$("#roomList").empty();
					$.each(data.roomList, function(index, item){
						$("#roomList").append('<input type="hidden" name="roomNo" id= "room'+ item.roomNo +  '" value="'+ item.roomNo +  '">');
						$("#roomList").append('<a href="#" class="btn disabledBtn roomBtn"> '+item.name+' </a>');
						
						//$(".roomBtn").on("click").css('color','yellow');
						//$(".roomBtn").css('color','yellow');
						
					});
					
					$('.roomBtn:first').trigger('click');
				},
				error : function() {
					alert("지사별 해당 회의실 조회 에러");
				}
			});
			
		});

		$(document).on("click",".roomBtn",function(){
			console.log("크릭!");
			$(".roomBtn").removeClass("activeBtn").addClass("disabledBtn");
			$(this).removeClass("disabledBtn").addClass("activeBtn");
		}); 
		
		/* 페이지 처음 로딩 시 지사 탭 제일 처음 클릭 이벤트 디폴트 처리 */
		$(".workplace-list:first").trigger("click");
		
		var roomNo;
		
		/* 회의실 버튼 눌렀을 때 */
		$(document).on("click", ".roomBtn", function() {
			roomNo = $(this).prev().val();
			console.log(roomNo);
			
			$.ajax({
				url : "/reservation/getRoomDashBoard",
				data : {
					"roomNo" : roomNo
				},
				type : "POST",
				dataType : 'json',
				success : function(data) {
					console.log(data);
					
					calendar.removeAllEvents();
					
					$.each(data.roomDashBoard, function(index, item){
						if(item.STATUS!=3) {
							var obj = {
										id : item.RESNO,
										title : item.RESERVATIONNAME,
										start : item.STARTDATE,
										end : item.ENDDATE
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
		

	});
</script>
<!-- Modal -->
<jsp:include page="include/infoReservation.jsp" />

</body>
