<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel= "stylesheet" type="text/css" href="/resources/css/user/reservation-chooseDate.css">
<script src='/resources/js/core/main.js'></script>
<script src='/resources/js/daygrid/main.js'></script>

<!-- Main Content -->
<div id="content">

	<!-- Begin Page Content -->
	<div class="container-fluid">
		<!-- Page Heading -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h1 class="h5 mb-0 text-gray-800"> <i class="fas fa-user"></i> 예약하기 > 예약 일자 선택 </h1>
		</div>
		
		<div class="row">
		
		<div class="col-lg-6">

             <div class="card shadow mb-4">
               <div class="card-header py-3">
                 <h6 class="m-0 font-weight-bold text-primary"> 회의실 정보 </h6>
               </div>
               <div class="card-body">
               	<img id="room_img" alt="회의실 사진" src="/resources/img/room/${roomInfo.IMAGE}">	
				<div id="room_info_div" class="background-lightgrey font-black padding-content div-border">
					<h1 class="align-center color-title">${roomInfo.ROOMNAME }</h1>
					<p id="chosen-date" class="align-center">4. 18. (목), 시간을 선택하세요</p>
					<hr>
					<ul>
						<li>회의실 위치 : ${roomInfo.WORKPLACENAME}
						<li>수용 인원 : ${roomInfo.CAPACITY}명
						<li>비치 물품 : ${roomInfo.EQUIPMENTS}
						<li>네트워크 : 
							<c:choose>
								<c:when test="${roomInfo.NWAVAILABLE eq 'Y'}">
									사용가능
								</c:when>
								<c:otherwise>
									사용불가능
								</c:otherwise>
							</c:choose>
						<li>사용요금 : 10,000원 / 시간
						<li>관리자 : ${roomInfo.ADMINNAME}
					</ul>	
				</div>
               </div>
             </div>

           </div>

           <div class="col-lg-6">

             <div class="card shadow mb-4">
               <div class="card-header py-3">
                 <h6 class="m-0 font-weight-bold text-primary">달력</h6>
               </div>
               <div class="card-body">
                 <div id='calendar'></div>
               </div>
             </div>

             <!-- Brand Buttons -->
             <div class="card shadow mb-4">
               <div class="card-header py-3">
                 <h6 class="m-0 font-weight-bold text-primary">옵션 선택</h6>
               </div>
               <div class="card-body">
				<form action="/reservation/InputReservationInfo" id="option_form" method="get">
					<input type="hidden" name="roomNo" value="${roomInfo.ROOMNO}"/>
					<input type="hidden" name="employeeNo" value=""/>
					<input type="hidden" name="startDate" value="">
					<input type="hidden" name="endDate" value="">
					<input type="hidden" name="equipments" value="">
					
					<c:forEach var="equip" items="${equipmentList}" >
						<input type="checkbox" value="${equip.EQUIP_NO}" name="checkbox-equipment" id="equipment${equip.EQUIP_NO}">
						<span class="font-checkbox"><label for="equipment${equip.EQUIP_NO}">${equip.NAME} 대여</label> </span><br>
					</c:forEach>
					
					<input type="checkbox" name="snackWant" id="snackWant" <c:if test="${!empty savedRoomInfo && (savedRoomInfo.snackWant eq 'Y')}">checked</c:if>>
					<span class="font-checkbox"><label for="snackWant">간식준비 여부</label></span>
					<br>
				</form>
               </div>
             <button class="btn btn-disabled" id="nextBtn">다음 단계</button>
             </div>

           </div>

         </div>
	</div>
	<!-- /.container-fluid -->

</div>

<!-- Modal -->
<jsp:include page="include/chooseTime.jsp" />

<script src="/resources/js/jquery_cookie.js" type="text/javascript"></script>
<script>
	// 뒤로 가기 버튼 막기
	history.pushState(null, null, location.href);
    window.onpopstate = function () {
        history.go(1);
	};

	// 사용자가 캘린더에서 선택한 날짜
	var startDate=null;
 	var endDate=null;
	var startDay=null;
	var endDay=null;
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
	/* 장기예약을 위한 변수 */
	var chosenDate; // 사용자가 선택한 일자
	var startDateForLongterm; // 시작일자 
	var endDateForLongterm; // 종료일자
	var chosenStartDate=false; // 시작일자를 선택했는지 여부를 확인하기 위한 변수
	var isLongTermReservation=false; // 장기예약인지 여부
	// 31일까지 있는 달
	var fullDaysMonth=[1,3,5,7,8,10,12];
	
	/* 이전페이지를 통해 돌아왔다면 데이터 넣기 */
	// 이전페이지를 통해 돌아왔다면 true
	var clickedPrevBtn=("${savedRoomInfo}"!="");
	
	$(document).ready(function(){
		if(clickedPrevBtn){
			// equipments 정보 넣기
			var savedEquipments="${savedRoomInfo.equipments}".split(',');
			$.each(savedEquipments, function(index, item){ 
				$("input:checkbox[value='"+item+"']").attr("checked", true);
			});
			startDate="${savedRoomInfo.startDate}".split(" ")[0];
			startTime="${savedRoomInfo.startDate}".split(" ")[1];
			endDate="${savedRoomInfo.endDate}".split(" ")[0];
			endTime="${savedRoomInfo.endDate}".split(" ")[1];
			
			var endTime_object=$('.can-reserve-time:contains("'+endTime+'")');
			
			/* 모달에 선택한 시간에 표시하기*/
			// 시작시간, 종료시간 선택한 효과
			$('.time:contains("'+startTime+'")').trigger("click");
	
			endTime_object.attr("id","endTime");
			// chosenTime 클래스를 추가한다.
			endTime_object.addClass("chosenTime");
			// #startTime객체부터 #endTime객체까지 chosenTime 클래스를 추가해준다.
			var tmp_time_si=startTime.split(":")[0];
			var tmp_time_bun=startTime.split(":")[1];
			
			while(true){
				tmp_time_bun=parseInt(tmp_time_bun)+30;
				
				if(tmp_time_bun==60){
					tmp_time_si=parseInt(tmp_time_si)+1;
					tmp_time_bun='00';
				}
				if(tmp_time_si.toString()+":"+tmp_time_bun == endTime){
					break;
				}
				$('.can-reserve-time:contains("'+tmp_time_si.toString()+":"+tmp_time_bun+'")').addClass('chosenTime');
			};

			// 선택한 날짜를 #chosen-date에 띄어준다.
			startDay=$('.fc-day-top[data-date="'+startDate+'"]').data("day");
			var startDateSplit=startDate.split('-');
			modalTitle=startDateSplit[0]+". "+startDateSplit[1]+". "+ startDateSplit[2]+". "+"("+startDay+") ";
			var reserveDate=startDate.split('-');
			$("#chosen-date").text(modalTitle+" "+startTime+"~"+endTime);
			
		};
	});
	
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
	
		var calendar = new FullCalendar.Calendar(calendarEl, {
		   plugins: [ 'dayGrid' ],
		   contentHeight : "auto"
		});
		
		calendar.render();
	  
		// 오늘 이전의 날짜는 클릭 금지
		$(".fc-past").click(false);
		// 다른 달의 날짜는 클릭 금지
		$(".fc-other-month").click(false);
		// 주말은 클릭 금지
		$(".fc-sat").click(false).children(".fc-day-number").addClass("fontColor-grey");
		$(".fc-sun").click(false).children(".fc-day-number").addClass("fontColor-grey");
		
		// .fc-button으로 달력 날짜 이동시 과거 날짜는 선택 못하도록 설정
		$(".fc-button").on("click",function(){
			$(".fc-past").click(false);
			$(".fc-sat").click(false).children(".fc-day-number").addClass("fontColor-grey");
			$(".fc-sun").click(false).children(".fc-day-number").addClass("fontColor-grey");

			// 장기예약일 경우 이미 날짜를 선택했다면 달력에 표시되도록
			if(isLongTermReservation){
				// 시작 날짜 표시
				$('.fc-day-top[data-date="'+startDate+'"]').css("background-color","rgba(166, 166, 239, 0.5)").append("<p class='start' style='color: white; font-size: small;'>시작</p>");
			
				if(endDate!=null){
					startDateForLongterm=new Date(startDate.split("-")[0],startDate.split("-")[1],startDate.split("-")[2],startTime.split(":")[0],startTime.split(":")[1]);
					endDateForLongterm=new Date(endDate.split("-")[0],endDate.split("-")[1],endDate.split("-")[2],endTime.split(":")[0],endTime.split(":")[1]);
					var start=new Date(startDateForLongterm.getFullYear(),startDateForLongterm.getMonth(),startDateForLongterm.getDate());
					var end=new Date(endDateForLongterm.getFullYear(),endDateForLongterm.getMonth(),endDateForLongterm.getDate());
					start.setDate(start.getDate()+1); 
					var num=0;
					while(num!=5){
						num++;
						var tmpDate=start.getFullYear()+"-"+pad(start.getMonth(),2)+"-"+pad(start.getDate(),2);
						if(start.getTime()===end.getTime()){
							$('.fc-day-top[data-date="'+tmpDate+'"]').css("background-color","rgba(166, 166, 239, 0.5)").append("<p class='end'  style='color: white; font-size: small;'>종료</p>");
							break;
						} else{
							
							$('.fc-day-top[data-date="'+tmpDate+'"]').css("background-color","rgba(166, 166, 239, 0.5)");
						}
						start.setDate(start.getDate()+1);
					};
				};
				var startDateForLongterm; // 시작일자 
				var endDateForLongterm; // 종료일자
			};
		});
		
		// 캘린더 상 날짜의 클릭 이벤트(날짜 선택)
		$(document).on("click",".fc-day-top",function(){
			
			// 날짜 재선택
			if(endDate!=null){
				/* 장기 예약 */
				if(isLongTermReservation){
					// 장기예약일 경우
					// 1. 시작일~종료일 chosenDate 삭제
					$('.fc-day-top[data-date="'+startDate+'"]').css("background-color","").children(".start").remove();
					var start=new Date(startDateForLongterm.getFullYear(),startDateForLongterm.getMonth(),startDateForLongterm.getDate());
					var end=new Date(endDateForLongterm.getFullYear(),endDateForLongterm.getMonth(),endDateForLongterm.getDate());
					start.setDate(start.getDate()+1);
					while(true){
						var tmpDate=start.getFullYear()+"-"+pad(start.getMonth(),2)+"-"+pad(start.getDate(),2);
						if(start.getTime()===end.getTime()){
							$('.fc-day-top[data-date="'+tmpDate+'"]').css("background-color","").children(".end").remove();
							break;
						} else{
							$('.fc-day-top[data-date="'+tmpDate+'"]').css("background-color","");
						};
						start.setDate(start.getDate()+1);
					};
					// 2. 변수 초기화
					chosenStartDate=false;
					startDateForLongterm=null; 
					endDateForLongterm=null;
					isLongTermReservation=false; // 장기예약인지 여부
					
					// 3. 버튼 초기화
					$("#choose-complete-btn").show().text("확인");
					$("#choose-anotherDay-btn").show();
				};
				// 달력에 표시된 시작-종료 삭제
				
				/* 단기 예약 */
				// 버튼 다시 리셋
				$("#choose-complete-btn").attr("disabled",true).removeClass("active-btn").addClass("disable-btn");	
				$("#choose-anotherDay-btn").attr("disabled",true).removeClass("active-btn").addClass("disable-btn");
				endDate=null;
				endTime=null;
				clickedStartTime=false;
			};
				
			/* 장기 예약 */
			if(isLongTermReservation && chosenStartDate){ // 시작일자를 선택한 경우
				$("#choose-complete-btn").text("종료일자 선택(장기예약)").attr("disabled",true).removeClass("active-btn").addClass("disable-btn");	
				$("#choose-anotherDay-btn").attr("disabled",true).removeClass("active-btn").addClass("disable-btn");
				// 종료 요일 설정
				endDate=$(this).data("date");
				endDay=$(this).data("day");
				// 시작일자보다 이른 종료날짜를 선택했다면
				endDateForLongterm=new Date(endDate.split("-")[0],endDate.split("-")[1],endDate.split("-")[2]);
				// 시작일자와 종료일자 같게 선택했다면 초기화
				var isEndDateSameAsStartDate=endDateForLongterm.getFullYear()==startDateForLongterm.getFullYear() &&
											 endDateForLongterm.getMonth()==startDateForLongterm.getMonth() &&
											 endDateForLongterm.getDate()==startDateForLongterm.getDate();
				if(endDateForLongterm.getTime()<startDateForLongterm.getTime() || isEndDateSameAsStartDate){
					// 리셋
					$('.fc-day-top[data-date="'+startDate+'"]').css("background-color","").children(".start").remove();
					chosenStartDate=false;
					clickedStartTime=false;
					startDateForLongterm=null; 
					endDateForLongterm=null;
					isLongTermReservation=false; // 장기예약인지 여부
					chosenDate=null;
					endDate=null;
					startTime=null;
					// 버튼 초기화
					$("#choose-complete-btn").show().text("확인").attr("disabled",true).removeClass("active-btn").addClass("disable-btn");
					$("#choose-anotherDay-btn").show().attr("disabled",true).removeClass("active-btn").addClass("disable-btn");
					// 선택된 시간 초기화
					$(".time").removeClass("chosenTime");
				}
			};
			
			if(!clickedPrevBtn && !chosenStartDate){
				startDate=$(this).data("date");
				startDay=$(this).data("day");
			}

			chosenDate=$(this).data("date");
			var chosenDay=$(this).data("day");
			var chosenDateSplit=chosenDate.split('-');
			// 모달에 반영한다.
			if(clickedPrevBtn){
				$("#time-label").text(modalTitle+startTime+"~"+endTime);
				clickedPrevBtn=false;
			} else{
				modalTitle=chosenDateSplit[0]+". "+chosenDateSplit[1]+". "+ chosenDateSplit[2]+". "+"("+chosenDay+") ";
				$("#time-label").text(modalTitle+"시간을 선택하세요.");
			}
			
			var tmp_time_si="9";
			var tmp_time_bun="00";
			
			/** 모든 시간 예약 가능하도록 초기화 */
			$('.time').addClass("can-reserve-time").removeClass("cant-reserve-time").removeClass("chosenTime");
		
			// 오늘 날짜를 클릭할 경우
			if($(this).hasClass("fc-today")){
				// 현재 시각 이전의 시간은 선택 불가
				var d=new Date();
				var year=d.getYear();
				var month=d.getMonth();
				var day=d.getDay();
				
				var date=new Date(year,month,day,9,0);
				var now=new Date(year,month,day,d.getHours(),d.getMinutes());
				var end=new Date(year,month,day,18,0);
				var tmp_time_bun;
				
				/** 모든 시간 예약 가능하도록 초기화 */
				while(now-date>0 && date-end!=0){
					tmp_time_bun=date.getMinutes()==0?"00":date.getMinutes();
					// can-reserve-time 클래스 추가
					$('.time:contains("'+date.getHours()+":"+tmp_time_bun+'")').addClass("cant-reserve-time").removeClass('can-reserve-time');
					date.setMinutes(date.getMinutes()+30)
				};
			};

			getReservationsByDate(chosenDate);
			
		});
		
		// 오늘 날짜를 #chosen-date에 띄어준다.
		var today=$(".fc-today").data("date").split('-');
		$("#chosen-date").text(today[0]+". "+today[1]+". "+ today[2]+". "+"("+$(".fc-today").data("day")+") ");
		
	});
	
	// 해당 날짜에 예약된 정보를 가져오는 함수
	function getReservationsByDate(chosenDate){
		var chosenDateSplit=chosenDate.split("-");
		var roomNo="${roomInfo.ROOMNO}";
		$.ajax({
			type:"get",
			url:"${pageContext.request.contextPath}/reservation/getReservationsByDate",
			data:{roomNo:roomNo, chosenDate:chosenDate},
			traditional:true,
			success: function(data){
				// 해당 날짜에 예약내역들이 있는지 확인
				if(data.reservations.length>0){
					$.each(data.reservations, function(index, item){
						var startDateArr=item.STARTDATE.split(" ")[0].split("-");
						var endDateArr=item.ENDDATE.split(" ")[0].split("-");
						
						var start=new Date(startDateArr[0],startDateArr[1],startDateArr[2]);
						var end=new Date(endDateArr[0],endDateArr[1],endDateArr[2]);
						var chosenDate=new Date(chosenDateSplit[0],chosenDateSplit[1],chosenDateSplit[2]);
						
						var startTimeArr=item.STARTDATE.split(" ")[1].split(":");
						var endTimeArr=item.ENDDATE.split(" ")[1].split(":");
						
						console.log("chosenDate:"+chosenDate);
						console.log("start:"+start);
						console.log("end:"+end);
						if(chosenDate-start==0){
							if(chosenDate-end==0){
								// 1. 선택한 날짜==startDate && 선택한 날짜==endDate -> 단기 예약(시작시간~끝시간)
								start=new Date(startDateArr[0],startDateArr[1],startDateArr[2],startTimeArr[0],startTimeArr[1]);
								end=new Date(endDateArr[0],endDateArr[1],endDateArr[2],endTimeArr[0],endTimeArr[1]);
								var tmp_time_bun;
								
								while(true){
									tmp_time_bun=start.getMinutes()==0?"00":start.getMinutes();
									$('.time:contains("'+start.getHours()+":"+tmp_time_bun+'")').addClass("cant-reserve-time").removeClass('can-reserve-time');
									
									start.setMinutes(start.getMinutes()+30)
									if(end-start==0){
										tmp_time_bun=start.getMinutes()==0?"00":start.getMinutes();
										$('.time:contains("'+start.getHours()+":"+tmp_time_bun+'")').addClass("cant-reserve-time").removeClass('can-reserve-time');
										break;
									}
								};
							} else{
								// 2. 선택한 날짜==startDate && 선택한 날짜!=endDate -> 장기 예약(시작시간~)
								start=new Date(startDateArr[0],startDateArr[1],startDateArr[2],startTimeArr[0],startTimeArr[1]);
								endOfDate=new Date(chosenDateSplit[0],chosenDateSplit[1],chosenDateSplit[2],18,0);
								var tmp_time_bun;
								
								while(true){
									tmp_time_bun=start.getMinutes()==0?"00":start.getMinutes();
									// can-reserve-time 클래스 추가
									$('.time:contains("'+start.getHours()+":"+tmp_time_bun+'")').addClass("cant-reserve-time").removeClass('can-reserve-time');
									
									start.setMinutes(start.getMinutes()+30)
									if(start-endOfDate==0){
										tmp_time_bun=start.getMinutes()==0?"00":start.getMinutes();
										$('.time:contains("'+start.getHours()+":"+tmp_time_bun+'")').addClass("cant-reserve-time").removeClass('can-reserve-time');
										break;
									}
								};
							}
						} else{ 
							if(chosenDate-end==0){
								// 3. 선택한 날짜!=startDate && 선택한 날짜==endDate -> 장기 예약(~끝시간)
								end=new Date(endDateArr[0],endDateArr[1],endDateArr[2],endTimeArr[0],endTimeArr[1]);
								startOfDate=new Date(chosenDateSplit[0],chosenDateSplit[1],chosenDateSplit[2],9,0);
								var tmp_time_bun;
								
								while(true){
									tmp_time_bun=startOfDate.getMinutes()==0?"00":startOfDate.getMinutes();
									// can-reserve-time 클래스 추가
									$('.time:contains("'+startOfDate.getHours()+":"+tmp_time_bun+'")').addClass("cant-reserve-time").removeClass('can-reserve-time');
									
									startOfDate.setMinutes(startOfDate.getMinutes()+30)
									if(startOfDate-end==0){
										tmp_time_bun=startOfDate.getMinutes()==0?"00":startOfDate.getMinutes();
										$('.time:contains("'+startOfDate.getHours()+":"+tmp_time_bun+'")').addClass("cant-reserve-time").removeClass('can-reserve-time');
										break;
									}
								};
							} else{
								// 4. 선택한 날짜!=startDate && 선택한 날짜!=endDate -> 장기 예약(~)
								startOfDate=new Date(chosenDateSplit[0],chosenDateSplit[1],chosenDateSplit[2],9,0);
								endOfDate=new Date(chosenDateSplit[0],chosenDateSplit[1],chosenDateSplit[2],18,0);
								var tmp_time_bun;
								
								while(true){
									tmp_time_bun=startOfDate.getMinutes()==0?"00":startOfDate.getMinutes();
									// can-reserve-time 클래스 추가
									$('.time:contains("'+startOfDate.getHours()+":"+tmp_time_bun+'")').addClass("cant-reserve-time").removeClass('can-reserve-time');
									
									startOfDate.setMinutes(startOfDate.getMinutes()+30)
									if(startOfDate-endOfDate==0){
										tmp_time_bun=startOfDate.getMinutes()==0?"00":startOfDate.getMinutes();
										$('.time:contains("'+startOfDate.getHours()+":"+tmp_time_bun+'")').addClass("cant-reserve-time").removeClass('can-reserve-time');
										break;
									}
								};
							}
						}
					});
					
				};
			},
			error: function(request,status, error) {
				alert(error);
			}	
		});
	};
	
	// 모달-시간 선택
	$(document).on("click",".can-reserve-time",function(){
		// 시작시간과 같은 종료시간을 선택한 경우 초기화
		var chosenTime=$(this).text();
		
		// 단기 예약 중 같은 시간을 클릭한 경우 초기화
		if(!isLongTermReservation && clickedStartTime && (startTime==chosenTime)){
			console.log("시작시간과 같은 종료시간을 선택한 경우 초기화");
			$('.fc-day-top[data-date="'+startDate+'"]').css("background-color","").children(".start").remove();
			chosenStartDate=false;
			clickedStartTime=false;
			startDateForLongterm=null; 
			endDateForLongterm=null;
			isLongTermReservation=false; // 장기예약인지 여부
			chosenDate=null;
			endDate=null;
			startTime=null;
			
			// 버튼 초기화
			$("#choose-complete-btn").show().text("확인").attr("disabled",true).removeClass("active-btn").addClass("disable-btn");
			$("#choose-anotherDay-btn").show().attr("disabled",true).removeClass("active-btn").addClass("disable-btn");
			// 선택된 시간 초기화
			$(".time").removeClass("chosenTime");
			
			return;
		};
		
		if(!isLongTermReservation && !chosenStartDate){
			// 선택한 일자 색상 변경
			if(!clickedStartTime){ // 시작시간 선택
				setStartTime($(this));
				startTime=$(this).text();
			} else{ // 종료시간 선택
				setEndTime($(this));
			}
		} else{ // 장기 예약
			// 현재 날짜를 종료 일자로 처리
			endTime=$(this).text();
			endDateForLongterm=new Date(chosenDate.split("-")[0],chosenDate.split("-")[1],chosenDate.split("-")[2],endTime.split(":")[0],endTime.split(":")[1]);
			var endDate=new Date(chosenDate.split("-")[0],chosenDate.split("-")[1],chosenDate.split("-")[2]);
			// 시작날짜~선택 종료 날짜 사이에 예약내역이 있으면 선택 불가
			var tmp_date=new Date(startDateForLongterm.getFullYear(),startDateForLongterm.getMonth(),startDateForLongterm.getDate());
			tmp_date.setDate(tmp_date.getDate() + 1);
			while(!(tmp_date.getTime()===endDate.getTime())){
				// 30일까지 있는 달에 31일 처리
				
				if($.inArray(tmp_date.getMonth(), fullDaysMonth) == -1 &&tmp_date.getDate()==31){
					tmp_date.setDate(tmp_date.getDate() + 1);
					continue;
				}
				getReservationsByDate(tmp_date.getFullYear()+"-"+tmp_date.getMonth()+"-"+tmp_date.getDate());
				// 예약 시작일자~종료일자 사이에 예약 내역이 있는 경우
				console.log("예약불가한가"+$('.time').hasClass("cant-reserve-time"));
				if($('.time').hasClass("cant-reserve-time")){
					console.log("예약불가");
					swal('예약 불가', '해당 일자에 예약된 내역이 있어 예약이 불가합니다.', 'error'
					).then(function(){
						// 초기화
						startDateForLongterm=null;
						clickedStartTime=false;
						isLongTermReservation=false;
						startDate=null;
						startTime=null;
						startDateForLongterm=null;
						endDate=null;
						endTime=null;
						endDateForLongterm=null;
						$('.time').addClass("can-reserve-time").removeClass("cant-reserve-time").removeClass("chosenTime");
						return;
				    });
				}
				tmp_date.setDate(tmp_date.getDate() + 1);
			};
			
			// 시작 시간부터 예약시간까지 선택
			tmp_date=new Date(endDateForLongterm.getFullYear(),endDateForLongterm.getMonth(),endDateForLongterm.getDate(),9,0);
			var tmp_time_bun;
			while(true){
				tmp_time_bun=tmp_date.getMinutes()==0?"00":tmp_date.getMinutes();
				
				// 중간에 이미 예약된 시간이 있다면 예약 불가
				if($('.time:contains("'+tmp_date.getHours()+":"+tmp_time_bun+'")').hasClass("cant-reserve-time")){
					swal('예약 불가', '해당 일자에 예약된 내역이 있어 예약이 불가합니다.', 'error'
					);
					$('.time').removeClass("chosenTime");
					clickedStartTime=false;
					isLongTermReservation=false;
					chosenStartDate=false;
					return;
				};
				// can-reserve-time 클래스 추가
				$('.time:contains("'+tmp_date.getHours()+":"+tmp_time_bun+'")').addClass("chosenTime");
				
				tmp_date.setMinutes(tmp_date.getMinutes()+30)
				if(tmp_date-endDateForLongterm==0){
					tmp_time_bun=tmp_date.getMinutes()==0?"00":tmp_date.getMinutes();
					$('.time:contains("'+tmp_date.getHours()+":"+tmp_time_bun+'")').addClass("chosenTime");
					break;
				}
			};
			// 예약이 가능한 경우
			$("#choose-complete-btn").attr("disabled",false).removeClass("disable-btn").addClass("active-btn");
		};
	});
	
	// 다른 일자를 선택하는 경우
	$("#choose-anotherDay-btn").on("click",function(){
		// 시작 일자
		startDateForLongterm=new Date(chosenDate.split("-")[0],chosenDate.split("-")[1],chosenDate.split("-")[2],startTime.split(":")[0],startTime.split(":")[1]);
		
		// 시작 시간부터 18:00까지 선택
		var startOfDate=startDateForLongterm;
		var endOfDate=new Date(chosenDate.split("-")[0],chosenDate.split("-")[1],chosenDate.split("-")[2],18,0);
		var tmp_time_bun;
		
		while(true){
			tmp_time_bun=startOfDate.getMinutes()==0?"00":startOfDate.getMinutes();
			
			if(startOfDate-endOfDate==0){
				tmp_time_bun=startOfDate.getMinutes()==0?"00":startOfDate.getMinutes();
				$('.time:contains("'+startOfDate.getHours()+":"+tmp_time_bun+'")').addClass("chosenTime");
				break;
			}
			
			// 중간에 이미 예약된 시간이 있다면 예약 불가
			if($('.time:contains("'+startOfDate.getHours()+":"+tmp_time_bun+'")').hasClass("cant-reserve-time")){
				var ment;
				
				if(startOfDate.getMinutes()==0){
					ment=startOfDate.getHours()+'시에는 예약이 불가합니다.';
				} else{
					ment=startOfDate.getHours()+'시'+startOfDate.getMinutes()+'분에는 예약이 불가합니다.';
				}
				swal('예약 불가', ment, 'error').then(function(){
					chosenStartDate=false;
					startDateForLongterm=null; 
					isLongTermReservation=false; // 장기예약인지 여부
					
					// 3. 버튼 초기화
					$("#choose-complete-btn").show().text("확인").attr("disabled",true).removeClass("active-btn").addClass("disable-btn");
					$("#choose-anotherDay-btn").show().attr("disabled",true).removeClass("active-btn").addClass("disable-btn");
					
			    });

				$('.time').removeClass("chosenTime");
				clickedStartTime=false;
				return;
			};
			// can-reserve-time 클래스 추가
			$('.time:contains("'+startOfDate.getHours()+":"+tmp_time_bun+'")').addClass("chosenTime");
			
			startOfDate.setMinutes(startOfDate.getMinutes()+30)
			
		};
		// 시작 일자 선택 완료
		chosenStartDate=true;
		// 장기 예약 여부
		isLongTermReservation=true;
		// 달력에 시작날짜 표시하기
		$('.fc-day-top[data-date="'+chosenDate+'"]').css("background-color","rgba(166, 166, 239, 0.5)").append("<p class='start' style='color: white; font-size: small;'>시작</p>");
		// 이 버튼 숨김
		$(this).hide();
		// 모달 종료
		$("#chooseTimeModal").modal("hide");
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
		$("#time-label").text(modalTitle+startTime+"~");
		$("#chosen-date").text(modalTitle+startTime+"~");
		// 버튼 attr 변경
		$("#choose-complete-btn").attr("disabled",true).removeClass("active-btn").addClass("disable-btn");
		$("#choose-anotherDay-btn").attr("disabled",false).removeClass("disable-btn").addClass("active-btn");
	}
	
	// 시간 선택 모달이 show되는 이벤트
	$("#chooseTimeModal").on('shown', function(){
	    // 이미 시작 시간을 선택했다면 종료일자 선택 버튼 숨김
	    if(chosenStartDate){
	    	$("#choose-anotherDay-btn").hide();
	    }
	});
	
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
				endDate=startDate;
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
						if(tmp_time_si.toString()+":"+tmp_time_bun == endTime){
							break;
						}
						// chosenTime 클래스 추가
						$('.can-reserve-time:contains("'+tmp_time_si.toString()+":"+tmp_time_bun+'")').addClass('chosenTime');
					}

					// 모달 라벨에 시간 표시
					$("#time-label").text(modalTitle+startTime+"~"+endTime);
					$("#chosen-date").text(modalTitle+startTime+"~"+endTime);
					
					// 버튼 attr 변경
					$("#choose-anotherDay-btn").attr("disabled",true).removeClass("active-btn").addClass("disable-btn");
					$("#choose-complete-btn").attr("disabled",false).removeClass("disable-btn").addClass("active-btn");
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
		if(isLongTermReservation){
			// 장기예약일 경우
			// 1. 시작일~종료일 chosenDate 표시
			var start=new Date(startDateForLongterm.getFullYear(),startDateForLongterm.getMonth(),startDateForLongterm.getDate());
			var end=new Date(endDateForLongterm.getFullYear(),endDateForLongterm.getMonth(),endDateForLongterm.getDate());
			start.setDate(start.getDate()+1);
			while(true){
				var tmpDate=start.getFullYear()+"-"+pad(start.getMonth(),2)+"-"+pad(start.getDate(),2);
				
				if(start.getTime()===end.getTime()){
					
					$('.fc-day-top[data-date="'+tmpDate+'"]').css("background-color","rgba(166, 166, 239, 0.5)").append("<p class='end'  style='color: white; font-size: small;'>종료</p>");
					break;
				} else{
					
					$('.fc-day-top[data-date="'+tmpDate+'"]').css("background-color","rgba(166, 166, 239, 0.5)");
				};
				start.setDate(start.getDate()+1);
			};
			
			// 2. 모달에 날짜 표시
			modalTitle= startDateForLongterm.getFullYear()+". "+startDateForLongterm.getMonth()+". "+startDateForLongterm.getDate()
						+". ("+startDay+") "+startTime+" ~ "
						+endDateForLongterm.getFullYear()+". "+endDateForLongterm.getMonth()+". "+endDateForLongterm.getDate()+". ("+endDay+") "+endTime;
			$("#chosen-date").text(modalTitle);
		};
	});
	
	
	// 숫자 n을 width 자리 수로 만들어주는 함수
	function pad(n, width) {
		  n = n + '';
		  return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
	}
	
	// 회의실 예약 내역을 다 입력하면 active로 전환
	$("#nextBtn").on("click",function(){
		// startDate와 endDate 값을 넘겨줌
		$("input[name='startDate']").val(startDate+" "+startTime);
		$("input[name='endDate']").val(endDate+" "+endTime);
		
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
