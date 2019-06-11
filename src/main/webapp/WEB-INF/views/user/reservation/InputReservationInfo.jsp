<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>

<link rel= "stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/user/reservation-chooseDate.css">
<link rel= "stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/user/reservation-inputReservationInfo.css">


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
				<h1 class="h5 mb-0 text-gray-800"> <i class="fas fa-user"></i> 예약하기 > 예약 정보 입력 </h1>
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
						<p id="reservation-date" class="align-center"></p>
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
						<h4 class="color-title">예약 정보</h4>
						<hr>
						<form action="${pageContext.request.contextPath}/reservation/checkReservation" id="option_form" method="get">
							<input type="hidden" name="roomNo" value="${roomInfo.ROOMNO}"/>
							<input type="hidden" name="employeeNo" value=""/>
							<input type="hidden" name="startDate" value="">
							<input type="hidden" name="endDate" value="">
							<input type="hidden" name="equipments" value="">
							<ul>
							<!-- <div class="form-group">
							    <label for="exampleInputEmail1">Email address</label>
							    <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
							    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
							  </div> -->
								<li>
									
									<label>예약자</label>
									<input type="text" value="${employeeInfo.name }" disabled><br>
								</li>
								<li>
									<label>연락처</label>
									<input type="text" value="${employeeInfo.phone }" disabled><br>
								</li>
								<li>
									<label>이메일</label>
									<input type="text" value="${employeeInfo.email }" disabled><br>
								</li>
								<li>
									<label>회의명</label>
									<input type="text" name="name">
								</li>
								<li>
									<label>회의구분</label>
									<select name="purpose">
									    <option value="internelMeeting">내부회의</option>
									    <option value="customerMeeting">고객미팅</option>
									    <option value="education">교육</option>
									</select>
								</li>
								<li>
									<label>참여인원</label>
									<a class="btn btn-primary" href="#" id="chooseParticipationBtn"  data-toggle="modal" data-target="#chooseParticipationModal">검색</a>
									<div id="final-participation-list-div"></div>
								</li>
								<li>
									<label>주관부서</label>
									<a class="btn btn-primary" href="#" id="chooseMainDeptBtn"  data-toggle="modal" data-target="#chooseDeptModal">검색</a>
									<div id="final-mainDept-list-div"></div>
								</li>
								<li>
									<label>협조부서</label>
									<div id="final-subDept-list-div"><ul></ul></div>
								</li>
							</ul>
						</form>
					</div>
					
					<div id="option_div" class="background-lightgrey font-black padding-content div-border">
						<h4 class="color-title">선택 내역</h4>
						<hr>
						<ul id="option_list">
							<c:forEach var="equip" items="${equipmentList}" >
								<li>${equip.NAME} 대여
									<c:choose>
										<c:when test="${!(empty equip.need) and (equip.need eq true)}">
											Y
										</c:when>
										<c:otherwise>
											N
										</c:otherwise>
									</c:choose>
								</li>
							</c:forEach>
							<li>간식준비 여부 ${reservationInfo.snackWant }
							</li>
						</ul>
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
<jsp:include page="include/chooseParticipation.jsp" />
<jsp:include page="include/chooseDepartment.jsp" />

<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript">
	// 회의 참여자 사원번호를 담은 배열
	var participation=new Array();
	var chosung;
	var keyword;
	// 부서를 담은 배열
	var departmentList;
	var mainDept=new Array();
	
	/* 예약 일자 */
	$(function(){
		// 예약 일자 값을 설정
		Date.prototype.format = function (f) {
		    if (!this.valueOf()) return " ";
		    var weekKorShortName = ["일", "월", "화", "수", "목", "금", "토"];
		    var d = this;
		
		    return f.replace(/(yyyy|yy|MM|dd|KS|KL|ES|EL|HH|hh|mm|ss|a\/p)/gi, function ($1) {
		        switch ($1) {
		            case "yyyy": return d.getFullYear(); // 년 (4자리)
		            case "MM": return (d.getMonth() + 1).zf(2); // 월 (2자리)
		            case "dd": return d.getDate().zf(2); // 일 (2자리)
		            case "KS": return weekKorShortName[d.getDay()]; // 요일 (짧은 한글)
		            case "HH": return d.getHours().zf(2); // 시간 (24시간 기준, 2자리)
		            case "mm": return d.getMinutes().zf(2); // 분 (2자리)
		            case "a/p": return d.getHours() < 12 ? "오전" : "오후"; // 오전/오후 구분
		            default: return $1;
		        }
		    });
		};

		String.prototype.string = function (len) { var s = '', i = 0; while (i++ < len) { s += this; } return s; };
		String.prototype.zf = function (len) { return "0".string(len - this.length) + this; };
		Number.prototype.zf = function (len) { return this.toString().zf(len); };

		// 예약 시작날짜와 종료날짜
		var startDate=new Date("${reservationInfo.startDate}");
		var endDate=new Date("${reservationInfo.endDate}");
		
		var reserved_date;
		// 시작일자와 종료일자가 같으면 시간만 보여준다
		if(startDate.getFullYear()==endDate.getFullYear() &&
		   startDate.getMonth()==endDate.getMonth() &&
		   startDate.getDay()==endDate.getDay()){
			reserved_date=startDate.format('yyyy. MM. dd(KS) HH:mm')+"~"+endDate.format('HH:mm');
		} else{
			reserved_date=startDate.format('yyyy. MM. dd(KS) HH:mm')+"~"+endDate.format('yyyy. MM. dd(KS) HH:mm');
		}
		$("#reservation-date").text(reserved_date);
	})
	
	/* 사원 검색 */
	// 모달 초성 선택 이벤트
	$("#ganada-list>li").on("click",function(){
		chosung=$(this).text();
		keyword=null;
		getEmployeeList();
	});
	
	// 사원 목록을 가져오는 함수
	function getEmployeeList(){
		// 초성에 의한 검색일 경우
		if(chosung!=null && keyword==null){
			$.ajax({
				type:"get",
				url:"${pageContext.request.contextPath}/reservation/getEmployeeListByChosung",
				data : {"chosung" : chosung},
				success: function(data){
					var employeeList=data.employeeList;
					// 초성에 해당하는 사원들의 목록을 모달에 뿌려줌
					$("#search-employee-list > ul").empty();
					$.each(employeeList, function(index, item){
						// 해당 사원이 참여자 목록 배열에 없으면 뿌려줌
						var found=participation.some(function(obj){
							return obj.employeeNo==item.EMPLOYEENO;
						});
						if(!found){
							$("#search-employee-list > ul").append("<li>"
								+"<a onclick='addParticipation(\""+item.EMPLOYEENO+"\", \""+item.NAME+"\")'>"+item.NAME+"( "+item.DEPARTMENTNAME+")</a>"
								+"</li>");
						}
					})
				},
				error: function(xhr, status, error) {
					alert(error);
				}	
			});
		} else{ // 키워드에 의한 검색일 경우
			$.ajax({
				type:"get",
				url:"${pageContext.request.contextPath}/reservation/getEmployeeListBySearching",
				data : {"keyword" : keyword},
				success: function(data){
					// 해당 사원이 참여자 목록 배열에 없으면 뿌려줌
					var found=participation.some(function(obj){
						return obj.employeeNo==item.EMPLOYEENO;
					});
					if(!found){
						$("#search-employee-list > ul").append("<li>"
							+"<a onclick='addParticipation(\""+item.EMPLOYEENO+"\", \""+item.NAME+"\")'>"+item.NAME+"( "+item.DEPARTMENTNAME+")</a>"
							+"</li>");
					}
				},
				error: function(xhr, status, error) {
					alert(error);
				}	
			});
		}
	}
	
	// 참여 사원 추가 함수
	function addParticipation(employeeNo, name){
		console.log(participation);
		// 해당 사원을 배열에 추가한다.
		participation.push({"employeeNo":employeeNo, "name":name});
		$(".participation-list").append("<li>"+name
				+"<i style='display:none'>"+employeeNo+"</i>"
				+"<button class='btn btn-default delete-participation-btn'>x</button></li>");
		// 사원 목록을 업데이트한다.
		updateParticipationList();
		// 검색 사원 목록을 업데이트한다.
		getEmployeeList();
		// 참여자가 한 명이라도 있을 경우 모달의 확인 버튼 Active
		if(participation.length>=1){
			$("#choose-complete-btn").addClass("btn-primary").attr("disabled",false);
		}
	}
	
	// 참여자 삭제 이벤트
	$(document).on("click",".delete-participation-btn",function(){
		var employeeNo=$(this).prev().text();
		// 사원번호 배열에서 해당 사원을 삭제한다.
		var index;
		participation.some(function(entry, i) {
		    if (entry.employeeNo == employeeNo) {
		        participation.splice(i,1);
		        return true;
		    };
		});	
		// 참여 사원 목록을 업데이트한다.
		updateParticipationList();
		// 검색 사원 이름 reset
		getEmployeeList();
		// 참여자가 없을 경우 모달의 확인 버튼 disabled
		if(participation.length==0){
			$("#choose-complete-btn").removeClass("btn-primary").attr("disabled",true);
			$("#final-participation-list-div").hide();
		}
		
	});
	
	// 참여 사원 목록을 업데이트하는 함수
	function updateParticipationList(){
		$(".participation-list").empty();
		// 참여 사원 목록을 업데이트한다.
		$.each(participation, function(index, item){
			$(".participation-list")
				.append("<li>"+item.name+"<i style='display:none'>"+item.employeeNo+"</i>"
						+"<button class='btn btn-default delete-participation-btn'>x</button></li>");
		});
	}
	
	// 이름 검색을 통한 사원 조회
	$("#searchBtn").on("click",function(){
		keyword=$("#searchByName").val();
		chosung=null;
		getEmployeeList();
	});
	
	// 취소 버튼 클릭할 경우 reset
	$("#choose-cancel-btn").on("click",function(){
		participation=new Array();
		$("#search-employee-list>ul").empty();
		$(".participation-list>li").empty();
	})
	
	// 확인 버튼 클릭할 경우 참여 사원 목록을 화면에 뿌림
	$("#choose-complete-btn").on("click",function(){
		$("#final-participation-list-div").empty();
		$(".participation-list").clone().appendTo("#final-participation-list-div");
		$("#final-participation-list-div").show();
		$("#final-participation-list-div>ul").attr("id","user-chosen-participation");
	});
	
	/* 부서 */
	// 주관부서 버튼 클릭 이벤트
	$("#chooseMainDeptBtn").on("click",function(){
		if(departmentList==null){
			departmentList=new Array();
			
			// Object 배열 데이터 직렬화
			var jsonData = JSON.stringify(participation);
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath}/reservation/getDepartmentList",
				traditional:true,
				data : {"jsonData" : jsonData},
				dataType: "json",
				success: function(data){
					$.each(data.departmentList, function(index, item){
						departmentList.push({"dept_no":item.DEPT_NO,"name":item.NAME});
					})
					getDepartmentList();
				},
				error: function(xhr, status, error) {
					alert(error);
				}	
			});
		} else{
			getDepartmentList();
		}
	});
	
	// 부서정보를 가져오는 함수
	function getDepartmentList(){
		$("#department-list>ul").empty();
		$.each(departmentList, function(index, item){
			$("#department-list>ul").append("<i style='display:none'>"+item.dept_no+"</i><li>"+item.name+"</li>");
		});
	};
	
	// 부서 선택 이벤트
	$(document).on("click","#department-list>ul>li",function(){
		var deptNo=$(this).prev().text();
		var deptName=$(this).text();
		var deptInfo={"dept_no":deptNo, "name":deptName};
		
		// 선택한 부서를 departmentList에서 삭제한다.
		departmentList.splice(deptInfo,1);
		// 선택한 부서를 mainDept 배열에 넣는다.
		mainDept.push(deptInfo);
		// 선택한 부서 정보를 모달에 뿌려준다.
		$("#MainDept-list").append("<li>"+deptName
				+"<i style='display:none'>"+deptNo+"</i>"
				+"<button class='btn btn-default delete-participation-btn'>x</button></li>");
		// 부서 목록을 업데이트한다.
		getDepartmentList();
		// 선택한 부서가 1개 이상이면 확인 버튼 active
		if(mainDept.length>=1){
			$("#dept-choose-complete-btn").addClass("btn-primary").attr("disabled",false);
		} else{
			$("#dept-choose-complete-btn").addClass("btn-primary").attr("disabled",true);
		}
	});
	
	
	// 부서 선택 완료 이벤트
	$("#dept-choose-complete-btn").on("click",function(){
		// MainDept 요소들을 화면에 뿌려준다.
		$("#final-mainDept-list-div").empty();
		$("#MainDept-list").clone().appendTo("#final-mainDept-list-div");
		$("#final-mainDept-list-div>ul").attr("id","final-mainDept-list-div");
		// 남은 부서들을 협조부서에 뿌려준다.
		$("#final-subDept-list-div>ul").empty();
		$.each(departmentList, function(index, item){
			$("#final-subDept-list-div>ul").append("<i style='display:none'>"+item.dept_no+"</i><li>"+item.name+"</li>");
		});
	});
</script>