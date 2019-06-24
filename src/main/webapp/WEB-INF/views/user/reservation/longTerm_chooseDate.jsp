<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel= "stylesheet" type="text/css" href="/resources/css/user/reservation-chooseDate.css">
<script src='/resources/js/core/main.js'></script>
<script src='/resources/js/daygrid/main.js'></script>

<!-- Main Content -->
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

			<!-- Content Row -->
			
			<div class="row">
				<div class="col-sm-6 left-padding-zero" >
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
				<div class="col-sm-6">
					<!-- calendar -->
					<div id="calendar_div" class="background-lightgrey font-black padding-content div-border">
						<div id='calendar'></div>
					</div>
					
					<div id="option_div" class="background-lightgrey font-black padding-content div-border">
						<h4 class="color-title">옵션 선택</h4>
						<hr>
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
		<!-- /.container-fluid -->
	</div>
	</div>

</div>

<!-- Modal -->
<jsp:include page="include/chooseTime.jsp" />

<script src="/resources/js/jquery_cookie.js" type="text/javascript"></script>
<script>
/**
 고쳐야 할 점
 1) 모달을 통해 예약시간을 선택한 후 다른 날짜의 모달을 켜도 예약시간이 남아있다.->다른 날짜를 선택할 경우 모달 초기화할 필요 있음
 2) 30분만 예약하여 다음페이지로 넘어간 후 다시 이 페이지로 돌아오면 예약시간에 변화가 생김 ex)10:00 선택 후 돌아오면 10:00~10:30으로 처리돼 시간 선택 모달도 달라져 있다.
 */
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
	/* 장기예약을 위한 변수 */
	var chosenDate; // 사용자가 선택한 일자
	var startDateForLongterm; // 시작일자 
	var endDateForLongterm; // 종료일자
	var chosenStartDate=false; // 시작일자를 선택했는지 여부를 확인하기 위한 변수
	
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
			$('.can-reserve-time:contains("'+startTime+'")').trigger("click");
	
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
		   plugins: [ 'dayGrid' ]
		});
		
		calendar.render();
	  
		// 오늘 이전의 날짜는 클릭 금지
		$(".fc-past").click(false).children("span");
		// 다른 달의 날짜는 클릭 금지
		$(".fc-other-month").click(false);
		
		// .fc-button으로 달력 날짜 이동시 과거 날짜는 선택 못하도록 설정
		$(".fc-button").on("click",function(){
			$(".fc-past").click(false).children("span");
		});
		
		// 캘린더 상 날짜의 클릭 이벤트 ///끌릭
		$(document).on("click",".fc-day-top",function(){
			/* 장기 예약 */
			if(chosenStartDate){ // 시작일자를 선택한 경우
				$("#choose-complete-btn").text("종료일자 선택");	
				$("#choose-anotherDay-btn").attr("disabled",true);
				// 시작일자를 재선택 할 수 있도록 변수 초기화
				//chosenStartDate=false;
			}
			
			if(!clickedPrevBtn){
				startDate=$(this).data("date");
				startDay=$(this).data("day");
			}
			var startDateSplit=startDate.split('-');
			chosenDate=$(this).data("date");
			// 모달에 반영한다.
			if(clickedPrevBtn){
				$("#time-label").text(modalTitle+startTime+"~"+endTime);
				clickedPrevBtn=false;
			} else{
				modalTitle=startDateSplit[0]+". "+startDateSplit[1]+". "+ startDateSplit[2]+". "+"("+startDay+") ";
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
						
						var startDate=new Date(startDateArr[0],startDateArr[1],startDateArr[2]);
						var endDate=new Date(endDateArr[0],endDateArr[1],endDateArr[2]);
						var chosenDate=new Date(chosenDateSplit[0],chosenDateSplit[1],chosenDateSplit[2]);
						
						var startTimeArr=item.STARTDATE.split(" ")[1].split(":");
						var endTimeArr=item.ENDDATE.split(" ")[1].split(":");
						
						if(chosenDate-startDate==0){
							if(chosenDate-endDate==0){
								// 1. 선택한 날짜==startDate && 선택한 날짜==endDate -> 단기 예약(시작시간~끝시간)
								startDate=new Date(startDateArr[0],startDateArr[1],startDateArr[2],startTimeArr[0],startTimeArr[1]);
								endDate=new Date(endDateArr[0],endDateArr[1],endDateArr[2],endTimeArr[0],endTimeArr[1]);
								// 예약 앞뒤로 30분 간격을 준다
								startDate.setMinutes(startDate.getMinutes()-30);
								endDate.setMinutes(endDate.getMinutes()+30);
								var tmp_time_bun;
								
								while(true){
									tmp_time_bun=startDate.getMinutes()==0?"00":startDate.getMinutes();
									$('.time:contains("'+startDate.getHours()+":"+tmp_time_bun+'")').addClass("cant-reserve-time").removeClass('can-reserve-time');
									
									startDate.setMinutes(startDate.getMinutes()+30)
									if(endDate-startDate==0){
										tmp_time_bun=startDate.getMinutes()==0?"00":startDate.getMinutes();
										$('.time:contains("'+startDate.getHours()+":"+tmp_time_bun+'")').addClass("cant-reserve-time").removeClass('can-reserve-time');
										break;
									}
								};
							} else{
								// 2. 선택한 날짜==startDate && 선택한 날짜!=endDate -> 장기 예약(시작시간~)
								startDate=new Date(startDateArr[0],startDateArr[1],startDateArr[2],startTimeArr[0],startTimeArr[1]);
								endOfDate=new Date(chosenDateSplit[0],chosenDateSplit[1],chosenDateSplit[2],18,0);
								// 예약 앞에 30분 간격을 준다
								startDate.setMinutes(startDate.getMinutes()-30);
								var tmp_time_bun;
								
								while(true){
									tmp_time_bun=startDate.getMinutes()==0?"00":startDate.getMinutes();
									// can-reserve-time 클래스 추가
									$('.time:contains("'+startDate.getHours()+":"+tmp_time_bun+'")').addClass("cant-reserve-time").removeClass('can-reserve-time');
									
									startDate.setMinutes(startDate.getMinutes()+30)
									if(startDate-endOfDate==0){
										tmp_time_bun=startDate.getMinutes()==0?"00":startDate.getMinutes();
										$('.time:contains("'+startDate.getHours()+":"+tmp_time_bun+'")').addClass("cant-reserve-time").removeClass('can-reserve-time');
										break;
									}
								};
							}
						} else{ 
							if(chosenDate-endDate==0){
								// 3. 선택한 날짜!=startDate && 선택한 날짜==endDate -> 장기 예약(~끝시간)
								endDate=new Date(endDateArr[0],endDateArr[1],endDateArr[2],endTimeArr[0],endTimeArr[1]);
								startOfDate=new Date(chosenDateSplit[0],chosenDateSplit[1],chosenDateSplit[2],9,0);
								// 예약 뒤에 30분 간격을 준다
								endDate.setMinutes(endDate.getMinutes()+30);
								var tmp_time_bun;
								
								while(true){
									tmp_time_bun=startOfDate.getMinutes()==0?"00":startOfDate.getMinutes();
									// can-reserve-time 클래스 추가
									$('.time:contains("'+startOfDate.getHours()+":"+tmp_time_bun+'")').addClass("cant-reserve-time").removeClass('can-reserve-time');
									
									startOfDate.setMinutes(startOfDate.getMinutes()+30)
									if(startOfDate-endDate==0){
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
		if(!chosenStartDate){
			// 선택한 일자 색상 변경
			if(!clickedStartTime){ // 시작시간 선택
				setStartTime($(this));
				$("#choose-complete-btn").attr("disabled",false);
				$("#choose-anotherDay-btn").attr("disabled",false);
				startTime=$(this).text();
			} else{ // 종료시간 선택
				setEndTime($(this));
				$("#choose-complete-btn").attr("disabled",false);
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
				getReservationsByDate(tmp_date.getFullYear()+"-"+tmp_date.getMonth()+"-"+tmp_date.getDate());
				if($('.time').hasClass("cant-reserve-time")){
					alert("예약 불가!");
					break;
				}

				tmp_date.setDate(tmp_date.getDate() + 1);
			};
			
			// 시작 시간부터 18:00까지 선택
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
			
			// 중간에 이미 예약된 시간이 있다면 예약 불가
			if($('.time:contains("'+startOfDate.getHours()+":"+tmp_time_bun+'")').hasClass("cant-reserve-time")){
				alert(startOfDate.getHours()+"시 "+startOfDate.getMinutes()+"분에는 예약이 불가합니다.");
				$('.time').removeClass("chosenTime");
				clickedStartTime=false;
				return;
			};
			// can-reserve-time 클래스 추가
			$('.time:contains("'+startOfDate.getHours()+":"+tmp_time_bun+'")').addClass("chosenTime");
			
			startOfDate.setMinutes(startOfDate.getMinutes()+30)
			if(startOfDate-endOfDate==0){
				tmp_time_bun=startOfDate.getMinutes()==0?"00":startOfDate.getMinutes();
				$('.time:contains("'+startOfDate.getHours()+":"+tmp_time_bun+'")').addClass("chosenTime");
				break;
			}
		};
		// 시작 일자 선택 완료
		chosenStartDate=true;
		// 달력에 시작날짜 표시하기
		$('.fc-day-top[data-date="'+chosenDate+'"]').css("background-color","rgba(166, 166, 239, 0.5)").text("시작");
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
	
	// 회의실 예약 내역을 다 입력하면 active로 전환
	$("#nextBtn").on("click",function(){
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
