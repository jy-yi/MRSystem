<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel= "stylesheet" type="text/css" href="/resources/css/user/reservation-checkReservationInfo.css">

<!-- Main Content -->
	
<div id="content">

	<!-- Begin Page Content -->
	<div class="container-fluid">

	<div class="row">

		<!-- Begin Page Content -->
		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="d-sm-flex align-items-center justify-content-between mb-4">
				<h1 class="h5 mb-0 text-gray-800"> <i class="fas fa-user"></i> 예약하기 > 예약 정보 확인 </h1>
			</div>
		</div>
		
		<!-- Content Row -->
		<div class="row">
			<div class="col-xs-12" id="reservationInfoDiv">
				<h1>예약 확인</h1>
				<ul>
					<li><b>회의실 명</b><span>${roomInfo.ROOMNAME }</span>
					<li><b>일자</b><span>${date }</span>
					<li><b>가격</b><span>${price }원</span>
					<li><b>예약자 명</b><span>${employeeDto.name }</span>
					<li><b>연락처</b><span>${employeeDto.phone }</span>
					<li><b>이메일</b><span>${employeeDto.email }</span>
					<li><b>회의 명</b><span>${meetingName }</span>
					<li><b>회의목적</b><span>${purpose }</span>
					<li><b>참여인원</b>
						<c:forEach items="${participation }" var="emp">
							<span>${emp.NAME}(${emp.DEPARTMENTNAME})</span>
						</c:forEach>
					<li><b>주관부서</b>
						<c:forEach items="${mainDept }" var="dept">
							<span>${dept.NAME }</span>
						</c:forEach>
					<c:if test="!empty ${subDept }">
						<li><b>협조부서</b>
						<c:forEach items="${subDept }" var="dept">
							<span>${dept.NAME }</span>
						</c:forEach>
					</c:if>
					<c:if test="!empty ${equipments }">
						<li><b>선택내역</b>
						<c:forEach items="${equipments }" var="equipment">
							<span>${equipment.NAME }</span>
						</c:forEach>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
	</div>
</div>
<script src="/resources/js/jquery_cookie.js" type="text/javascript"></script>
