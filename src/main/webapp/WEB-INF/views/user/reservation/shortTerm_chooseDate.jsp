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
						<p id="chosen-date" class="align-center">4. 18. (목), 시간을 선택하세요</p>
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
								<input type="checkbox" value="${equip.EQUIP_NO}" name="checkbox-equipment"><span class="font-checkbox">${equip.NAME} 대여</span><br>
							</c:forEach>
								<input type="checkbox" name="snackWant"><span class="font-checkbox">간식준비 여부</span><br>
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

<!-- Modal -->
<jsp:include page="include/chooseTime.jsp" />

<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery_cookie.js" type="text/javascript"></script>
<script>
	// 사용자가 캘린더에서 선택한 날짜
	var startDate=null;
	var startDay=null;
	var modalTitle=null;
	// 사용자가 시간 선택 시 시작시간인지 끝시작인지 여부를 확인하기 위한 변수
	var clickedStartTime=false;
	// 회의실 이용 시작 시간, 끝 시간
	var startTime=null;
	var endTime=null;
	var startTime_si;
	var startTime_bun;
	var endTime_si;
	var endTime_bun;
	// 회의실 사용시간
	var si=0;
	var bun=0;
	
	
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
	
		var calendar = new FullCalendar.Calendar(calendarEl, {
		   plugins: [ 'dayGrid' ]
		});
		
		calendar.render();
	  
		// 오늘 이전의 날짜는 클릭 금지
		$(".fc-past").click(false);
		
		// 캘린더 상 날짜의 클릭 이벤트
		$(".fc-day-top").on("click", function(){
			startDate=$(this).data("date");
			startDay=$(this).data("day");
			var startDateSplit=startDate.split('-');
			modalTitle=startDateSplit[0]+". "+startDateSplit[1]+". "+ startDateSplit[2]+". "+"("+startDay+") ";
			// 모달에 반영한다.
			$("#time-label").text(modalTitle+"시간을 선택하세요.");
		});
		
		// 오늘 날짜를 #chosen-date에 띄어준다.
		var today=$(".fc-today").data("date").split('-');
		$("#chosen-date").text(today[0]+". "+today[1]+". "+ today[2]+". "+"("+$(".fc-today").data("day")+") ");
		
	  //calendar.setOption('locale','ko');
	});// 모달-날짜 선택
	$(".can-reserve-time").on("click",function(){
		// 선택한 일자 색상 변경
		if(!clickedStartTime){ // 시작시간 선택
			setStartTime($(this));
			$("#choose-complete-btn").attr("disabled",false);
		} else{ // 종료시간 선택
			setEndTime($(this));
			$("#choose-complete-btn").attr("disabled",false);
		}
	});
     
    
	
	// 시작시간을 처리하는 함수
	function setStartTime(startTime_object){
		clickedStartTime=true;
		// 이전에 선택한 이력이 있을 수 있으므로 chosenTime 클래스 제거
		$(".can-reserve-time").removeClass("chosenTime");
		// 이전에 선택한 이력이 있을 수 있으므로 #startTime 제거
		$("#startTime").removeAttr("id");
		// startTime에 값을 set함
		startTime=$(startTime_object).text();
		// 이 객체에 id를 부여한다.
		$(startTime_object).attr("id","startTime");
		// 선택한 시간을 표시하기 위해 chosenTime 클래스를 추가한다.
		$(startTime_object).addClass("chosenTime");
		// 모달 라벨에 시간 표시
		$("#time-label").text(modalTitle+startTime);
		$("#chosen-date").text(modalTitle+startTime);
	}
	
	// 종료시간을 처리하는 함수
	function setEndTime(endTime_object){
		/*
			규칙
			1. 시작시간 보다 이른 종료시간을 선택할 수 없다.
			2. 시작시간과 종료시간을 선택한 후 임의의 시간을 선택할 경우 모든 선택이 초기화된다.
		*/
		
		// 종료시간을 선택한 경우
		if(typeof endTime_object !== "undefined"){
			// 종료시간을 처음 선택하는지 확인
			if(endTime==null){
				// 시작시간보다 이른 종료시간을 선택했는지 확인한다.
				endTime=$(endTime_object).text();
				if(!calculateUseTime(startTime, endTime)){
					// // 어기면 현재 선택한 시간을 시작시간으로 처리
					setStartTime(endTime_object);
					endTime=null;
					$("#endTime").removeAttr("id");
				} else{
					// 종료시간을 제대로 선택했을 경우
					// 이 객체에 id를 부여한다
					$(endTime_object).attr("id","endTime");
					// chosenTime 클래스를 추가한다.
					$(endTime_object).addClass("chosenTime");
					// #startTime객체부터 #endTime객체까지 chosenTime 클래스를 추가해준다.
					var tmp_time_si=startTime_si;
					var tmp_time_bun=startTime_bun;
					
					while(true){
						tmp_time_bun=parseInt(tmp_time_bun)+30;
						
						if(tmp_time_bun==60){
							tmp_time_si=parseInt(tmp_time_si)+1;
							tmp_time_bun='00';
						}
						if(tmp_time_si.toString()+":"+tmp_time_bun.toString() == endTime){
							break;
						}
						// chosenTime 클래스 추가
						$('.can-reserve-time:contains("'+tmp_time_si.toString()+":"+tmp_time_bun.toString()+'")').addClass('chosenTime');
					}

					// 모달 라벨에 시간 표시
					$("#time-label").text(modalTitle+startTime+"~"+endTime);
					$("#chosen-date").text(modalTitle+startTime+"~"+endTime);
				}
			} else{ // 종료시간을 선택한 후 재선택하는 경우
				// 시작시간으로 처리
				setStartTime(endTime_object);
				endTime=null;
				$("#endTime").removeAttr("id");
			};
		} else{ // 종료시간을 선택하지 않은 경우 시작 시간에 30분을 더한 시간을 종료시간에 set함
			// startTime_si, startTime_bun값을 얻어온다.
			var startTimeSplit=startTime.split(":");
			startTime_si=startTimeSplit[0];
			startTime_bun=startTimeSplit[1];
			
			if(startTime_bun=="30"){
				endTime=(parseInt(startTime_si)+1)+":00"
			} else{
				endTime=startTime_si+":30";
			}
		}
	}
	
	// 사용시간을 계산하는 함수
	function calculateUseTime(startTime_val, endTime1_val){
		var startTimeSplit=startTime_val.split(":");
		var endTimeSplit=endTime1_val.split(":");
		
		startTime_si=startTimeSplit[0];
		startTime_bun=startTimeSplit[1];
		endTime_si=endTimeSplit[0];
		endTime_bun=endTimeSplit[1];
		
		si=endTime_si-startTime_si;
		bun=endTime_bun-startTime_bun;
		if(si<0){
			return false;
		}
		
		if(bun<0){ // bun이 마이너스면 ~시간 30분
			if(si<=0){ 
				// 종료시간이 시작시간을 앞서므로 false return
				return false;
			}
			si-=1;
			bun=30;
		}
		return true;
	}
	var checkedEquipmentList=$("input[name='checkbox-equipment']:checked").val();
	// 시간 선택 완료 버튼 클릭 이벤트
	$("#choose-complete-btn").on("click",function(){
		// 다음 단계 버튼 disabled 해제
		$("#nextBtn").removeClass("btn-disabled").addClass("btn-active").attr("disabled",false);
	});
	
	// 회의실 예약 내역을 다 입력하면 active로 전환(임의로 마우스오버 시 active)
	$("#nextBtn").on("click",function(){
		console.log(startTime);
		console.log(endTime);
		// startDate와 endDate 값을 넘겨줌
		$("input[name='startDate']").val(startDate+" "+startTime);
		if(endTime==null){
			// endTime 설정하기
			setEndTime();
		}
		$("input[name='endDate']").val(startDate+" "+endTime);
		
		// 선택된 equipment 목록을 equipments input에 넣어줌
		var checkedEquipmentList=[];
		$("input:checkbox[name='checkbox-equipment']:checked").each(function () {
			checkedEquipmentList.push($(this).val());
		});
		
		$("input[name=equipments]").val(checkedEquipmentList);

		// 쿠키에 저장된 employeeNo 폼에 전달
		$("input[name=employeeNo]").val($.cookie('loginCookie'));
		// 폼 제출
		$("#option_form").submit();
	});
</script>
</html>

