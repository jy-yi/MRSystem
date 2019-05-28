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
						<h1 class="align-center color-title">몰디브</h1>
						<p class="align-center">4. 18. (목), 시간을 선택하세요</p>
						<hr>
						<ul>
							<li>회의실 이름 : 몰디브
							<li>회의실 구분 : 회의실
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
					<div id="calendar_div" class="background-lightgrey font-black padding-content div-border">
						<div id='calendar'></div>
					</div>
					
					<div id="option_div" class="background-lightgrey font-black padding-content div-border">
						<h4 class="color-title">옵션 선택</h4>
						<hr>
						<form action="" id="option_form">
							<input type="checkbox" name="" value=""><span class="font-checkbox">노트북 대여</span><br>
							<input type="checkbox" name="" value=""><span class="font-checkbox">빔프로젝트 대여</span><br>
							<input type="checkbox" name="" value=""><span class="font-checkbox">간식준비 여부</span><br>
						</form>
					</div>
					<button class="btn btn-disabled" id="nextBtn" data-toggle="modal" data-target="#chooseTimeModal" disabled>다음 단계</button>
				</div>
			</div>
		</div>
		<!-- /.container-fluid -->
	</div>
	</div>

</div>

<!-- Modal -->
<jsp:include page="include/chooseTime.jsp" />

<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script>
	// 사용자가 캘린더에서 선택한 날짜
	var chosenDate=null;
	var modalTitle=null;
	// 사용자가 시간 선택 시 시작시간인지 끝시작인지 여부를 확인하기 위한 변수
	var clickedStartTime=false;
	// 회의실 이용 시작 시간, 끝 시간
	var startTime=null;
	var endTime=null;
	// 회의실 사용시간
	var userTime=0;
	
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
	
		var calendar = new FullCalendar.Calendar(calendarEl, {
		   plugins: [ 'dayGrid' ]
		});
		document.getElementsByClassName("fc-day").onclick=function(){
			console.log("클릭!");
		}
	
		calendar.render();
	  
		// 캘린더 상 날짜의 클릭 이벤트
		$(".fc-day-top").on("click", function(){
			chosenDate=$(this).data("date");
			var chosenDateSplit=chosenDate.split('-');
			modalTitle=chosenDateSplit[0]+". "+chosenDateSplit[1]+". "+ chosenDateSplit[2]+". "+"("+$(this).data("day")+") ";
			// 모달에 반영한다.
			$("#time-label").text(modalTitle+"시간을 선택하세요.");
		});
	  //calendar.setOption('locale','ko');
	});
    
	// 모달-날짜 선택
	$(".can-reserve-time").on("click",function(){
		// 선택한 일자 색상 변경
		$(this).addClass("chosenTime");
		
		if(!clickedStartTime){
			// 사용자가 처음으로 버튼을 누른다면 시작시간으로 체크
			clickedStartTime=true;
			startTime=$(this).text();
			// 사용시간
			useTime=30;
			// modal title에 반영
			$("#time-label").text(modalTitle+startTime+"("+useTime+"분)");
		} else{
			// 시작시간이 입력된 상태라면 종료시간으로 체크
			var endTime=$(this).text();
			// 사용시간
			userTime=endTime-startTime;
			calculateUseTime(startTime,endTime);
			// modal title에 반영
			$("#time-label").text(modalTitle+startTime+"~"+endTime+"("+useTime+"시간)");
		}
		
		
	});
     
	// 사용시간을 계산하는 함수
	function calculateUseTime(startTime, endTime){
		var startTimeSplit=startTime.split(":");
		var startTime_si=startTimeSplit[0];
		var startTime_bun=startTimeSplit[1];
		var endTimeSplit=endTime.split(":");
		var endTime_si=endTimeSplit[0];
		var endTime_bun=endTimeSplit[1];
		
		console.log(endTime_si-startTime_si);
	}
	
	// 회의실 예약 내역을 다 입력하면 active로 전환(임의로 마우스오버 시 active)
	$("#nextBtn").on("mouseover",function(){
	$(this).removeClass('btn-disabled').addClass('btn-active'); 
	});
</script>
</html>

