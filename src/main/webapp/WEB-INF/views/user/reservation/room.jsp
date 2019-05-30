<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>

<link rel= "stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/user/reservation-room.css">

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
				<h1 class="h5 mb-0 text-gray-800"> <i class="fas fa-user"></i> 예약하기 > 회의실 선택 </h1>
			</div>

			<div class="row">
				<div class="card-body py-2 text-right">
					<span class="pull-right text-lg"> 본사 </span>

				</div>
			</div>

			<!-- Content Row -->
			<div class="row">

				<ul class="nav nav-tabs">
					<li class="nav-item">
						<a class="nav-link active" data-toggle="tab" href="#workplace1">본사</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-toggle="tab" href="#workplace2">삼환빌딩</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-toggle="tab"  href="#workplace3">GS 강남타워</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-toggle="tab" href="#workplace3">GS 강서타워</a>
					</li>
				</ul>
			</div>
			<div class="row">
				<div class="col-sm-6" id="room_img_div">
					<img id="room_img" alt="본사 몰디브 회의실의 사진" src="${pageContext.request.contextPath}/resources/img/maldives.jpg">
				</div>
				<div class="col-sm-6" id="room_info.div">
					<h1>몰디브</h1>
					<ul>
						<li>회의실 구분 : 회의실
						<li>회의실 위치 : GS ITM 본사 2층
						<li>수용인원 수 : 20명
						<li>비치물품 : 빔, 노트북
						<li>네트워크 : 사용가능
						<li>사용요금 : 1시간 당 10000원
						<li>관리자 : 인사지원실 이예지 대리
						<li id="btn-li"><button class="btn btn-primary btn-lg" 
						onclick="location.href='${pageContext.request.contextPath}/reservation/shortTerm_chooseDate?roomNo=1'">단기 예약하기</button>
					</ul>
				</div>	
			</div>

		</div>
		<!-- /.container-fluid -->
	</div>
	</div>

</div>
</html>
