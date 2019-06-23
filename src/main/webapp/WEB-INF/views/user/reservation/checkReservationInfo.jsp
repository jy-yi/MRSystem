<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel= "stylesheet" type="text/css" href="/resources/css/user/reservation-checkReservationInfo.css">
<style>
th {
	width: 20%;
}
</style>

<!-- Main Content -->

<div id="content">

	<!-- Begin Page Content -->
	<div class="container-fluid">

		<div class="row">

			<!-- Begin Page Content -->
			<div class="container-fluid">
				<!-- Page Heading -->
				<div
					class="d-sm-flex align-items-center justify-content-between mb-4">
					<h1 class="h5 mb-0 text-gray-800">
						<i class="fas fa-user"></i> 예약하기 > 예약 정보 확인
					</h1>
				</div>
			</div>

			<!-- Content Row -->
			<div class="col-lg-1"></div>
			<div class="col-lg-10">
				<div class="card shadow mb-10">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary">예약 정보</h6>
					</div>
					<div class="card-body">
					
						<table class="table table-bordered text-center" >
							<tr>
								<th>회의실</th>
								<td>${roomInfo.ROOMNAME}</td>
							</tr>
							<tr>
								<th>회의명</th>
								<td>${meetingName}</td>
							</tr>
							<tr>
								<th>회의 목적</th>
								<td>${purpose}</td>
							</tr>
							<tr>
								<th>예약일</th>
								<td>${date}</td>
							</tr>
							<tr>
								<th>예약자</th>
								<td>${employeeDto.name}</td>
							</tr>
							<tr>
								<th>가격</th>
								<td>${price}원</td>
							</tr>
							<tr>
								<th>연락처</th>
								<td>${employeeDto.phone}</td>
							</tr>
							<tr>
								<th>이메일</th>
								<td>${employeeDto.email}</td>
							</tr>
							<tr>
								<th>참여 인원</th>
								<td>
									<c:forEach items="${participation }" var="emp">
										${emp.NAME}(${emp.DEPARTMENTNAME})
									</c:forEach>
								</td>
							</tr>
							<tr>
								<th>주관 부서</th>
								<td>
									<c:forEach items="${mainDept}" var="dept">
										<input type="hidden" class="mainDept" value="${dept.DEPT_NO}"/>
										${dept.NAME}
									</c:forEach> 
								</td>
							</tr>
								<c:if test="${!empty subDept }">
								<tr>
									<th>협조 부서</th>
									<td>
										<c:forEach items="${subDept}" var="dept">
											<input type="hidden" class="subDept" value="${dept.DEPT_NO}"/>
											${dept.NAME}
										</c:forEach> 
									</td>
								</tr>
								</c:if>
							<c:if test="${!empty equipments }">
								<tr>
									<th>비품 대여 신청 목록</th>
									<td>
										<c:forEach items="${equipments }" var="equipment">
											${equipment.NAME}
											<input type="hidden" class="equipments" value="${equipment.EQUIP_NO}"/>
										</c:forEach>
									</td>
								</tr>
							</c:if>
							<tr>
								<th>간식준비 여부</th>
								<c:choose>
									<c:when test="${snackWant eq 'Y'}">
										<td>O</td>
									</c:when>
									<c:otherwise>
										<td>X</td>
									</c:otherwise>
								</c:choose>
							</tr>
						</table>
					</div>
				</div>
				<!-- 이전 페이지로 이동시 데이터를 넘겨주는 부분 -->
				<form action="/reservation/InputReservationInfo" id="reservationInfoForm">
					<input type="hidden" name="clickPrevBtn" value="true">
					<input type="hidden" name="employeeNo" value="">
					<input type="hidden" name="roomNo" value="${roomInfo.ROOMNO}">
					<input type="hidden" name="name" value="${meetingName}">
					<input type="hidden" name="purpose" value="${purpose}">
					<input type="hidden" name="startDate" value="${startDate}">
					<input type="hidden" name="endDate" value="${endDate}">
					<input type="hidden" name="snackWant" value="${snackWant}">
					<input type="hidden" name="participation" value="">
					<input type="hidden" name="mainDept" value="">
					<input type="hidden" name="subDept" value="">
					<input type="hidden" name="equipments" value="">
				</form>
				<hr>
				<div class="text-center">
					<button class="btn btn-warning col-lg-3 btn-margin" id="prevBtn">이전 단계</button>
					<button class="btn btn-primary col-lg-3 btn-margin" onclick="doReserve()">예약 하기</button>
					<button class="btn btn-danger col-lg-3 btn-margin" id="cancelBtn">예약 취소</button>
				</div>
			</div>
		</div>
		<br>
	</div>
</div>

<script src="/resources/js/jquery_cookie.js" type="text/javascript"></script>
<script>
	// 예약에 필요한 정보
	var empNo=$.cookie('loginCookie');
	var roomNo="${roomInfo.ROOMNO}";
	var name="${meetingName}";
	var purpose="${purpose}";
	var startDate="${startDate}";
	var endDate="${endDate}";
	var snackWant="${snackWant}";
	var mainDept=$(".mainDept").map(function() {
		   return $(this).val();
	}).get();
	var subDept=$(".subDept").map(function() {
		   return $(this).val();
	}).get();
	var equipments= $(".equipments").map(function() {
		   return $(this).val();
	}).get();
	var participation= "${participationEmpNos}";
	
	var resData={
			empNo:empNo,
			roomNo:roomNo,
			name:name,
			purpose:purpose,
			startDate:startDate,
			endDate:endDate,
			snackWant:snackWant,
			mainDept:mainDept,
			subDept:subDept,
			equipments:equipments
			};
	var jsonData = JSON.stringify(resData);
	
	// 예약에 필요한 데이터를 DB에 담아주는 함수
	function doReserve() {
		$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath}/reservation/doReserve",
				data:jsonData,
				contentType: "application/json; charset=utf-8",
				dataType: "text",
				traditional:true,
				success: function(data){
					alert("예약이 완료되었습니다.");
				},
				error: function(xhr, status, error) {
					alert(error);
				}	
			});
			
		// 예약 확인 페이지로 이동
		location.href="/reservation/statusCalendar";
	}
	
	// 취소 버튼 클릭 이벤트
	$("#cancelBtn").on("click", function(){
		var wantCancel=confirm("정말 예약을 취소하시겠습니까?");
		if(wantCancel){
			// 회의실 목록으로 이동
			location.href="/reservation/room";
		}
	});
	
	// 이전페이지로 이동시켜주는 이벤트
	$("#prevBtn").on("click", function(){
		// 폼에 필요한 input값을 넣는다.
		$("input[name='employeeNo']").val(empNo);
		$("input[name='mainDept']").val(mainDept);
		$("input[name='subDept']").val(subDept);
		$("input[name='equipments']").val(equipments);
		$("input[name='participation']").val(participation);
		// inputReservationInfo로 이동
		$("#reservationInfoForm").submit();
	});
	
</script>
