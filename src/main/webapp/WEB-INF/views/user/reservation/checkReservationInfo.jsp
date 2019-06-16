<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>

<link rel= "stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/user/reservation-checkReservationInfo.css">

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
				<h1 class="h5 mb-0 text-gray-800"> <i class="fas fa-user"></i> 예약하기 > 예약 정보 확인 </h1>
			</div>
		</div>
		
		<!-- Content Row -->
		<div class="row">
			<div class="col-xs-12" id="reservationInfoDiv">
				<h1>예약 확인</h1>
				<ul>
					<li><b>회의실 명</b><span>${roomInfo.ROOMNAME }</span>
					<li><b>시간</b><span>${useTime }분</span>
					<li><b>가격</b><span>${price }원</span>
					<li><b>예약자 명</b><span>${employeeDto.name }</span>
					<li><b>연락처</b><span>${employeeDto.phone }</span>
					<li><b>이메일</b><span>${employeeDto.email }</span>
					
				</ul>
			</div>
		</div>
	</div>
	</div>
</div>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery_cookie.js" type="text/javascript"></script>
<script>

</script>