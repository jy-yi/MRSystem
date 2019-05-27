<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>

<link rel= "stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/user-reservation-chooseDate.css">
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
				<div class="col-sm-6 left-padding-zero" >
					<img id="room_img" alt="본사 몰디브 회의실의 사진" src="${pageContext.request.contextPath}/resources/img/maldives.jpg">	
					<div id="room_info_div" class="background-lightgrey font-black padding-content">
						<h1 class="align-center color-title">몰디브</h1>
						<p class="align-center">4. 18. (목), 시간을 선택하세요</p>
						<hr>
						<ul>
							<li>회의실 이름 : 대회의실
							<li>회의실 구분 : 대회의실
							<li>회의실 위치 : GS ITM 본사 2층
							<li>수용인원 수 : 20명
							<li>비치물품 : 빔, 노트북
							<li>네트워크 : 사용가능
							<li>사용요금 : 1시간 당 10000원
							<li>관리자 : 인사지원실 이예지 대리
							
						</ul>	
					</div>
				</div>
				<div class="col-sm-6">
					<!-- calendar -->
					<div id="calendar_div" class="background-lightgrey font-black padding-content">
						<div id='calendar'></div>
					</div>
					
					<div id="option_div" class="background-lightgrey font-black padding-content">
						<h4 class="color-title">옵션 선택</h4>
						<hr>
						<form action="" id="option_form">
							<input type="checkbox" name="" value=""><span class="font-checkbox">노트북 대여</span><br>
							<input type="checkbox" name="" value=""><span class="font-checkbox">빔프로젝트 대여</span><br>
							<input type="checkbox" name="" value=""><span class="font-checkbox">간식준비 여부</span><br>
						</form>
					</div>
					<button class="btn btn-disabled" id="nextBtn">다음 단계</button>
				</div>
			</div>
		</div>
		<!-- /.container-fluid -->
	</div>
	</div>

</div>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script>

      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');

        var calendar = new FullCalendar.Calendar(calendarEl, {
          plugins: [ 'dayGrid' ]
        });

        calendar.render();
      });
      
      // 회의실 예약 내역을 다 입력하면 active로 전환(임의로 클릭시 active)
      $("#nextBtn").on("mouseover",function(){
    	 $(this).removeClass('btn-disabled').addClass('btn-active'); 
      });

</script>
</html>

