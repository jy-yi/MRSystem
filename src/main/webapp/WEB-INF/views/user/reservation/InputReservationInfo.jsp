<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>

<link rel= "stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/user/reservation-chooseDate.css">
<link href='${pageContext.request.contextPath}/resources/css/core/main.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/css/daygrid/main.css' rel='stylesheet' />

<script src='${pageContext.request.contextPath}/resources/js/core/main.js'></script>
<script src='${pageContext.request.contextPath}/resources/js/daygrid/main.js'></script>

<!-- Main Content -->
<!-- 이 안에 내용 채우시면 됩니당 -->
	
<div id="content">

	<!-- Begin Page Content -->
	<div class="container-fluid">

	<div class="row">

		<!-- Begin Page Content -->
		<div class="container-fluid">

			<!-- Page Heading -->
			<div class="d-sm-flex align-items-center justify-content-between mb-4">
				<h1 class="h5 mb-0 text-gray-800"> <i class="fas fa-user"></i> 예약하기 > 예약 일자 선택 </h1>
			</div>

			<div class="row">
				<div class="card-body py-2 text-right">
					<span class="pull-right text-lg"> 본사 </span>

				</div>
			</div>

			<!-- Content Row -->
			
			<div class="row">
				<div class="col-sm-6 left-padding-zero" >
					<img id="room_img" alt="본사 몰디브 회의실의 사진" src="${pageContext.request.contextPath}/resources/img/maldives.jpg">	
					<div id="room_info_div" class="background-lightgrey font-black padding-content div-border">
						<h1 class="align-center color-title">${roomInfo.ROOMNAME }</h1>
						<p id="chosen-date" class="align-center">${reservationInfo.startDate }</p>
						<hr>
						<ul>
							<li>회의실 이름 : ${roomInfo.ROOMNAME}
							<li>회의실 위치 : ${roomInfo.WORKPLACEADDRESS}
							<li>수용인원 수 : ${roomInfo.CAPACITY}명
							<li>비치물품 : ${roomInfo.EQUIPMENTS}
							<li>네트워크 : 
								<c:choose>
									<c:when test="${roomInfo.NWAVAILABLE eq 'Y'}">
										사용가능
									</c:when>
									<c:otherwise>
										사용불가능
									</c:otherwise>
								</c:choose>
							<li>사용요금 : 1시간 당 10000원
							<li>관리자 : ${roomInfo.ADMINNAME}
						</ul>	
					</div>
				</div>
				<div class="col-sm-6">
					<!-- calendar -->
					<div id="calendar_div" class="background-lightgrey font-black padding-content div-border">
						<div id='calendar'></div>
					</div>
					
					<div id="option_div" class="background-lightgrey font-black padding-content div-border">
						<h4 class="color-title">옵션 선택</h4>
						<hr>
						<form action="${pageContext.request.contextPath}/reservation/InputReservationInfo" id="option_form" method="get">
							<input type="hidden" name="roomNo" value="${roomInfo.ROOMNO}"/>
							<input type="hidden" name="employeeNo" value=""/>
							<input type="hidden" name="startDate" value="">
							<input type="hidden" name="endDate" value="">
							<input type="hidden" name="equipments" value="">
							<c:forEach var="equip" items="${equipmentList}" >
								<p>${equip.NAME} 대여</p>
								<c:choose>
									<c:when test="${!(empty equip.need) and (equip.need eq true)}">
										<p>Y</p>
									</c:when>
									<c:otherwise>
										<p>N</p>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</form>
					</div>
					<button class="btn btn-disabled" id="nextBtn" disabled>다음 단계</button>
				</div>
			</div>
		</div>
		<!-- /.container-fluid -->
	</div>
	</div>

</div>


<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		// 예약 일자 값을 설정
		var startDate="${reservationInfo.startDate}";
		var endDate="{reservationInfo.endDate}";
		if(startDate)
		$("#chosen-date").val("$");
	})
</script>