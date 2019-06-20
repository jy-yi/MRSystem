<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel= "stylesheet" type="text/css" href="/resources/css/user/reservation-chooseDate.css">
<link rel= "stylesheet" type="text/css" href="/resources/css/user/reservation-inputReservationInfo.css">

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

			<!-- Content Row -->
			
			<div class="row">
				<div class="col-sm-6" >
					<img id="room_img" alt="회의실 사진" src="/resources/img/room/${roomInfo.IMAGE }" width="90%">
					<br>
					<div id="room_info_div" class="background-lightgrey font-black padding-content div-border">
					
						<h1 class="text-center color-title">${roomInfo.ROOMNAME }</h1>
						<p id="reservation-date" class="text-center"></p>
						
						<hr>
						<ul>
							<li>회의실 위치 : ${roomInfo.WORKPLACENAME} </li>
							<li>수용 인원 : ${roomInfo.CAPACITY}명 </li>
							<li>비치 물품 : ${roomInfo.EQUIPMENTS} </li>
							<li>네트워크 : 
								<c:choose>
									<c:when test="${roomInfo.NWAVAILABLE eq 'Y'}">
										사용 가능
									</c:when>
									<c:otherwise>
										사용 불가능
									</c:otherwise>
								</c:choose>
							</li>
							<li>사용요금 : 10,000원 / 시간
							<li>관리자 : ${roomInfo.ADMINNAME}
						</ul>	
					</div>
					<button class="btn btn-warning" id="prevBtn">이전 단계</button>
				</div>
				
				<div class="col-sm-6">
					<!-- calendar -->
					<div id="calendar_div" class="background-lightgrey font-black padding-content div-border">
						<h4 class="color-title">예약 정보</h4>
						<hr>
						<form action="/reservation/checkReservationInfo" id="option_form" method="get">
							<input type="hidden" name="roomNo" value="${roomInfo.ROOMNO}"/>
							<input type="hidden" name="startDate" value="${reservationInfo.startDate}">
							<input type="hidden" name="endDate" value="${reservationInfo.endDate}">
							<input type="hidden" name="equipments" value="">
							<input type="hidden" name="employeeNo" value=""/>
							<input type="hidden" name="participation" value="">
							<input type="hidden" name="mainDept" value="">
							<input type="hidden" name="subDept" value="">
							<input type="hidden" name="snackWant" value="${reservationInfo.snackWant }"/>	
							
							<div class="row">
								<div class="col-xs-2 col-sm-2 text-center">
									<label>예약자</label>
								</div>
								<div class="col-xs-9 col-sm-9">
									<input type="text" class="form-control" value="${employeeInfo.name }"  disabled="disabled"/>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-2 col-sm-2 text-center">
									<label>연락처</label>
								</div>
								<div class="col-xs-9 col-sm-9">
									<input type="text" class="form-control" value="${employeeInfo.phone }"  disabled="disabled"/>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-2 col-sm-2 text-center">
									<label>이메일</label>
								</div>
								<div class="col-xs-9 col-sm-9">
									<input type="text" class="form-control" value="${employeeInfo.email }"  disabled="disabled"/>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-2 col-sm-2 text-center">
									<label>회의명</label>
								</div>
								<div class="col-xs-9 col-sm-9">
									<input type="text" class="form-control" name="name"/>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-2 col-sm-2 text-center">
									<label>회의 구분</label>
								</div>
								<div class="col-xs-9 col-sm-9">
									<button class="btn btn-light dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					                   회의 선택
					                 </button>
					                 <div id="typeDropdown" class="dropdown-menu animated--fade-in" aria-labelledby="dropdownMenuButton">
					                 	<input type="hidden" name="purpose" id="purpose">
					                    <a class="dropdown-item" value="내부회의">내부회의</a>
					                    <a class="dropdown-item" value="고객미팅">고객미팅</a>
					                    <a class="dropdown-item" value="교육">교육</a>
					                 </div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-2 col-sm-2 text-center">
									<label>참여 인원</label>
								</div>
								<div class="col-xs-9 col-sm-9">
									<a class="btn btn-primary" href="#" id="chooseParticipationBtn"  data-toggle="modal" data-target="#chooseParticipationModal">검색</a>
									<div id="final-participation-list-div" class="card mb-4 py-3 border-left-primary">
	                                  <div class="card-body">
	                                  </div>
	                                </div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-2 col-sm-2 text-center">
									<label>주관부서</label>
								</div>
								<div class="col-xs-9 col-sm-9">
									<a class="btn btn-primary" href="#" id="chooseMainDeptBtn"  data-toggle="modal" data-target="#chooseDeptModal">검색</a>
									<div id="final-mainDept-list-div">
										<ul id="final-mainDept-list"></ul>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-2 col-sm-2 text-center">
									<label>협조부서</label>
								</div>
								<div class="col-xs-9 col-sm-9">
									<div id="final-subDept-list-div"><ul></ul></div>
								</div>
							</div>
						</form>
					</div>
					
					<div id="option_div" class="background-lightgrey font-black padding-content div-border">
						<h4 class="color-title">선택 내역</h4>
						<hr>
						<ul id="option_list">
							<c:forEach var="equip" items="${equipmentList}" >
								<c:choose>
									<c:when test="${!(empty equip.need) and (equip.need eq true)}">
										<li>${equip.NAME} 대여 Y</li>
										<input type="hidden" class="needEquip" value="${equip.EQUIP_NO}"/>
									</c:when>
									<c:otherwise>
										<li>${equip.NAME} 대여 N</li>
									</c:otherwise>
								</c:choose>
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

<script src="/resources/js/jquery_cookie.js" type="text/javascript"></script>
<script>

	// 회의 참여자 사원번호를 담은 배열
	var participation=new Array();
	var chosung;
	var keyword;
	// 부서를 담은 배열
	var departmentList;
	var mainDept=null;
	var neverChosenMainDept=true;
	
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
	
	/******************
		사원
	*******************/
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
				url:"/reservation/getEmployeeListByChosung",
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
									+"<a onclick='addParticipation(\""+item.EMPLOYEENO+"\", \""+item.NAME+"\", \""+item.DEPARTMENTNAME+"\")'>"+item.NAME+"("+item.DEPARTMENTNAME+")</a>"
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
				url:"/reservation/getEmployeeListBySearching",
				data : {"keyword" : keyword},
				success: function(data){
					// 해당 사원이 참여자 목록 배열에 없으면 뿌려줌
					var found=participation.some(function(obj){
						return obj.employeeNo==item.EMPLOYEENO;
					});
					if(!found){
						$("#search-employee-list > ul").append("<li>"
							+"<a onclick='addParticipation(\""+item.EMPLOYEENO+"\", \""+item.NAME+"\", \""+item.DEPARTMENTNAME+"\")'>"+item.NAME+"("+item.DEPARTMENTNAME+")</a>"
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
	function addParticipation(employeeNo, name, departmentName){
		// 해당 사원을 배열에 추가한다.
		participation.push({"employeeNo":employeeNo, "name":name, "departmentName":departmentName});
		// 사원 목록을 업데이트한다.
		updateParticipationList();
		// 검색 사원 목록을 업데이트한다.
		getEmployeeList();
		// 참여자가 한 명이라도 있을 경우 모달의 확인 버튼 Active
		if(participation.length>=1){
			$("#choose-complete-btn").addClass("btn-primary").attr("disabled",false);
		}
		// 폼을 다 채웠는지 확인하는 함수
		checkFormInput();
	}
	
	// 참여자 삭제 이벤트
	$(document).on("click",".delete-participation-btn",function(){
		var employeeNo=$(this).prev().text();
		// 사원번호 배열에서 해당 사원을 삭제한다.
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
				.append("<li>"+item.name+"("+item.departmentName+")"+"<i style='display:none'>"+item.employeeNo+"</i>"
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
		
		// 부서 목록 업데이트
		if(departmentList!=null){
			// DB에서 다시 departmentList를 가져옴
			getDepartmentListFromDb();
		}
	});
	
	
	/******************
		부서
	*******************/
	
	// 주관부서 버튼 클릭 이벤트
	$("#chooseMainDeptBtn").on("click",function(){
		if(departmentList==null){
			departmentList=new Array();
			getDepartmentListFromDb();
		} else{
			getDepartmentList();
		}
	});
	
	// DB에서 ajax를 이용해 부서정보를 가져오는 함수
	function getDepartmentListFromDb(){
		// participation배열에서 employeeNo 값으로만 배열 생성
		var employeeNoArr=participation.map(function(a){
			return a.employeeNo;
		})
		
		// mainDept배열에서 deptNo 값으로만 배열 생성
		var mainDeptNoArr=null;
		if(mainDept!=null){
			mainDeptNoArr=mainDept.map(function(a){
				return a.deptNo;
			});
		}
			
		$.ajax({
			type:"get",
			url:"/reservation/getDepartmentList",
			traditional:true,
			data : {"employeeNoArr" : employeeNoArr,
					"mainDeptList" : mainDeptNoArr},
			success: function(data){
				$.each(data.departmentList, function(index, item){
					departmentList.push({"deptNo":item.DEPT_NO,"name":item.NAME});
				})
				getDepartmentList();
			},
			error: function(xhr, status, error) {
				alert(error);
			}	
		});
	}
	
	// 부서정보를 가져오는 함수
	function getDepartmentList(){
		$("#department-list>ul").empty();
		$.each(departmentList, function(index, item){
			$("#department-list>ul").append("<i style='display:none'>"+item.deptNo+"</i><li>"+item.name+"</li>");
		});
	};
	
	// 주관부서를 append하는 함수
	function appendMainDept(){
		$("#final-mainDept-list").empty();
		$.each(mainDept, function(index, item){
			$("#final-mainDept-list").append("<li>"+item.name
					+"<i style='display:none'>"+item.deptNo+"</i>"
					+"<button type='button' class='btn btn-default delete-department-btn'>x</button></li>");
		});
	};
	
	// 협조부서를 append하는 함수
	function appendSubDept(){
		$("#final-subDept-list-div>ul").empty();
		$.each(departmentList, function(index, item){
			$("#final-subDept-list-div>ul").append("<li>"+item.name
					+"<i style='display:none'>"+item.deptNo+"</i>"
					+"<button type='button' class='btn btn-default delete-department-btn'>x</button></li>");
		});
	}
	
	// 부서 선택 이벤트
	$(document).on("click","#department-list>ul>li",function(){
		if(neverChosenMainDept){
			mainDept=new Array();
			neverChosenMainDept=false;
		};
		var deptNo=$(this).prev().text();
		var deptName=$(this).text();
		var deptInfo={"deptNo":deptNo, "name":deptName};
		
		// 선택한 부서를 departmentList에서 삭제한다.
		departmentList.splice(deptInfo,1);
		// 선택한 부서를 mainDept 배열에 넣는다.
		mainDept.push(deptInfo);
		// 주관 부서 정보를 모달에 뿌려준다.
		$("#MainDept-list").empty();
		$.each(mainDept, function(index, item){
			$("#MainDept-list").append("<li>"+item.name
					+"<i style='display:none'>"+item.deptNo+"</i>"
					+"<button type='button' class='btn btn-default delete-department-btn'>x</button></li>");
		});
		// 부서 목록을 업데이트한다.
		getDepartmentList();
		// 선택한 부서가 1개 이상이면 확인 버튼 active
		if(mainDept.length>=1){
			$("#dept-choose-complete-btn").addClass("btn-primary").attr("disabled",false);
		} else{
			$("#dept-choose-complete-btn").addClass("btn-primary").attr("disabled",true);
		}

		// 폼을 다 채웠는지 확인하는 함수
		checkFormInput();
	});
	
	
	// 부서 선택 완료 이벤트
	$("#dept-choose-complete-btn").on("click",function(){
		// MainDept 요소들을 화면에 뿌려준다.
		appendMainDept();
		// 남은 부서들을 협조부서에 뿌려준다.
		appendSubDept();
	});
	
	// 부서 삭제 이벤트
	$(document).on("click",".delete-department-btn",function(){
		var deptName;
		var deptNo=$(this).prev().text();
		var index;
		var isMainDept=mainDept.some(function(entry, i) {
		    if (entry.deptNo == deptNo) {
		    	index=i;
		        return true;
		    };
		});
		
		if(isMainDept){ // 주관 부서를 삭제한다면
			// 주관부서는 무조건 1개 이상이여야 한다.
			if(mainDept.length==1){
				alert("회의실 예약을 위해선 1개 이상의 부서가 주관해야합니다.");
				return;
			}
			// 해당 부서 협조 부서 배열에 push
			deptName=mainDept[index].name;
			mainDept.splice(index,1);
			departmentList.push({"deptNo":deptNo,"name":deptName});
		}else{ // 협조 부서를 삭제한다면
			// 해당 부서 주관 부서 배열에 push
			departmentList.some(function(entry, i) {
			    if (entry.deptNo == deptNo) {
			    	deptName=entry.name;
			    	departmentList.splice(i,1);
			        return true;
			    };
			});
			mainDept.push({"deptNo":deptNo,"name":deptName});
		}
		// 화면에 반영
		getDepartmentList();
		appendMainDept();
		appendSubDept();
	});
	
	// 회의명 작성 이벤트
	$("input[name='name']").on("propertychange change keyup paste input",function(){
		checkFormInput();
	});
	
	// 폼을 다 채웠는지 확인하는 함수
	function checkFormInput(){
		// 회의명을 채웠는지 확인
		if($("input[name='name']").val()!=''){
			// 참여인원과 주관부서를 선택했는지 확인
			if(participation.length!=0 && mainDept.length!=0){
				// 폼의 모든 요소를 채웠으면 버튼 active
				$("#nextBtn").removeClass("btn-disabled").addClass("btn-active").attr("disabled",false);
			}
		}
	}
	
	// 회의실 예약 내역을 다 입력하면 active로 전환
	$("#nextBtn").on("click",function(){
		// 쿠키에 저장된 employeeNo 폼에 전달
		$("input[name=employeeNo]").val($.cookie('loginCookie'));
		// participation배열에서 employeeNo 값으로만 배열 생성
		var employeeNoArr=participation.map(function(a){
			return a.employeeNo;
		});
		var mainDeptNoArr=mainDept.map(function(a){
			return a.deptNo;
		});
		var subDeptNoArr=departmentList.map(function(a){
			return a.deptNo;
		});
		// 참여사원, 주관부서, 협조부서를 폼에 전달
		$("input[name=participation]").val(employeeNoArr);
		$("input[name=mainDept]").val(mainDeptNoArr);
		$("input[name=subDept]").val(subDeptNoArr);
		// 필요한 equipment 목록을 폼에 전달
		var equipments=new Array();
		$(".needEquip").each(function(){
			equipments.push($(this).val());
		});
		$("input[name=equipments]").val(equipments);
		// 폼 제출
		$("#option_form").submit();
	});
	
	/* 회의 구분 드롭박스 선택 시 텍스트 변경 */
	$('#typeDropdown a').on('click', function() {
	    $('#dropdownMenuButton').text($(this).text());
	    $('#purpose').val($(this).attr('value'));
	});
	
	/* 이전 버튼 클릭 시 이전 페이지로 이동 */
	$("#prevBtn").on("click",function(){
		// 필요한 equipment 목록을 폼에 전달
		var equipments=new Array();
		$(".needEquip").each(function(){
			equipments.push($(this).val());
		});
		$("input[name=equipments]").val(equipments);
		
		$("#option_form").attr("action","/reservation/shortTerm_chooseDate/"+"${roomInfo.ROOMNO}").submit();
		//location.href="/reservation/shortTerm_chooseDate/${roomInfo.ROOMNO}";
	})
</script>
