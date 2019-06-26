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
$(function(){
	var status = getUrlParams();
	var type = status.type;
	var resNo = status.resNo;
	
	console.log("type : " + type);
	console.log("resNo : " + resNo);
	
	history.replaceState({}, null, location.pathname);	// url에서 파라미터 숨기기
	
	if(type == "manager") {
		swal({
			title: '해당 예약을 승인처리 하시겠습니까?',
			text: "ㄴㄴㄴ",
			type: 'question',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			    confirmButtonText: 'Yes',
			    cancelButtonText: 'No',
			}).then( (result) => {
				if (result.value) {
	  			$.ajax({
					url : "/reservation/mgrApproval",
					type : "POST",
					data : {
						reservationNo : resNo
					}, success : function(data) {
						swal('Success!', '예약 승인이 완료되었습니다.', 'success'
				    		).then(function(){
	  		    		    	location.href="/reservation/approvalWaitingList";
	  		    		    });
					}
				});
				}
				  
			});
	}

});

function getUrlParams() {
    var params = {};
    window.location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, 
    		function(str, key, value) { params[key] = value; });
    return params;
}
</script>

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

			$.ajax({
				url : "/statistic/getRoomListByWorkplaceNo",
				data : {
					"workplaceNo" : workplaceNo
				},
				type : "POST",
				dataType : 'json',
				success : function(data) {
					console.log(data.roomList);
					$("#roomList"+workplaceNo).empty();
					$.each(data.roomList, function(index, item){
						$("#roomList"+workplaceNo).append('<li style="text-align: center;"><a href="#" data-toggle="tab" value="'+ item.roomNo +'" class="roomBtn">'+ item.name + '</a></li>');
					});
				},
				error : function() {
					alert("지사별 해당 회의실 조회 에러");
				}
			});
			
		});

		/* 페이지 처음 로딩 시 지사 탭 제일 처음 클릭 이벤트 디폴트 처리 */
		$(".workplace-list:first").trigger("click");
		$('.roomBtn:first').trigger('click');
		
		/* 회의실 버튼 눌렀을 때 */
		$(document).on("click", ".roomBtn", function() {
			var roomNo = $(this).attr('value');
			
			// 대시보드 > XXX > YYY (회의실 이름 동적 변경)
			$("#roomNameTitle").text(" > "+$(this).text());
			
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
