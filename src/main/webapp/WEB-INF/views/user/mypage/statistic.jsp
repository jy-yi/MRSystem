<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.table {
	display: table;
	text-align: center;
}

.rHeader {
	color: #ffffff;
	background: #6c7ae0;
}
</style>


<!-- Main Content -->
<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<div class="d-sm-flex align-items-center justify-content-between mb-4">
		<h1 class="h5 mb-0 text-gray-800">
			<i class="fas fa-user"></i> 마이페이지 > 예약 통계
		</h1>
	</div>

	<!-- 개인 및 부서 통계 표 -->

	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">나의 예약 횟수 및 비용</h6>
		</div>
		<div class="card-body">

			<table class="table" border="2">
				<tr class="rHeader">
					<td colspan="2">개인</td>
					<td colspan="2">부서</td>
				</tr>

				<tr>
					<td>횟수</td>
					<td>비용</td>
					<td>횟수</td>
					<td>비용</td>
				</tr>
				<tr>
					<c:forEach items="${getIndividual}" var="list" varStatus="status">
						<td>${list.COUNT}</td>
						<td>${list.SUM}</td>
					</c:forEach>
					<c:forEach items="${getDepartment}" var="list" varStatus="status">
						<td>${list.COUNT}</td>
						<td>${list.SUM}</td>
					</c:forEach>
				</tr>

			</table>
		</div>
	</div>
	
	<!-- 개인 및 부서 통계 표 끝 -->
	<div>
		<div class="small mb-1"> 기간 : </div>
		<input type="text" class="form-control" name="daterange" placeholder="조회하고 싶은 날짜를 선택하세요." />
	</div>
	
	<hr>

	<div class="text-right">
		<button id="resetBtn" class="btn btn-info">
			<span>초기화</span>
		</button>
		<button id="searchBtn" class="btn btn-warning">
			<span>검색</span>
		</button>
	</div>


<!-- /.container-fluid -->

<div id="content">

	<!-- Content Row -->
	<div class="row">

		<!-- Begin Page Content -->
		<div class="container-fluid">

			<!-- DataTales Example -->
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">나의 예약 통계 목록</h6>
				</div>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
							<thead>
								<tr>
									<th>No</th>
									<th>회의명</th>
									<th>회의 목적</th>
									<th>회의실</th>
									<th>기간</th>
									<th>주관부서</th>
									<th>승인 상태</th>
									<th>취소</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
										<c:when test="${empty userAllList}">
											<td colspan="9" class="text-center"> 예약이 존재하지 않습니다.</td>
										</c:when>
										<c:otherwise>
											<c:forEach items="${userAllList}" var="list" varStatus="status">
												<tr>
													<td> ${status.count} </td>
													<td> ${list.RESERVATIONNAME}</td>
													<td> ${list.PURPOSE}</td>
													<td> ${list.ROOMNO}</td>
													<td> ${list.STARTDATE} - ${list.ENDDATE}</td>
													<td> ${list.DEPARTMENTNAME}</td>
													
													<td>
														<c:if test="${list.STATUS eq 0 }">
															<span class="text-success"> 대기 </span>
														</c:if>
													
														<c:if test="${list.STATUS eq 1 }">
															<span class="text-primary"> 승인 </span> 
														</c:if>
													
														<c:if test="${list.STATUS eq 2 }">
															 <span class="text-danger"> 반려 </span>
														</c:if>
														
														<c:if test="${list.STATUS eq 3 }">
															 <span class="text-warning"> 예약 취소 </span>
														</c:if>
														
													</td>
													
													
													<td>
														<c:if test="${list.STATUS eq 0 }">
															<a href="#" class="btn btn-danger"> <span class="text">취소</span> </a>
															<input type="hidden" id="reservationNo" name="reservationNo" value="${list.RESERVATIONNO}">
														</c:if>
														
														<c:if test="${list.STATUS eq 1 }">
															<a href="#" class="btn btn-danger"> <span class="text">취소</span> </a>
															<input type="hidden" id="reservationNo" name="reservationNo" value="${list.RESERVATIONNO}">
														</c:if>
														
														<c:if test="${list.STATUS eq 2 }">
															<a href="#" class="btn btn-danger"> <span class="text">취소</span> </a>
															<input type="hidden" id="reservationNo" name="reservationNo" value="${list.RESERVATIONNO}">
														</c:if>
														
														<c:if test="${list.STATUS eq 3	 }">
															<span class="text-warning"> 취소 완료 </span>
														</c:if>
													</td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</div>

		</div>
		<!-- /.container-fluid -->

	</div>
</div>

<script type="text/javascript">

$(function() {
	
	var startDate = "";
	var endDate = "";
	
	/* Date Range Picker */
	$('input[name="daterange"]').daterangepicker({
		autoUpdateInput : false, 
		locale: {
	      format: 'YYYY-MM-DD',
    	  cancelLabel: '취소',
	    }
	}, function(start, end, label) {
	    startDate = start.format('YYYY-MM-DD');
	    endDate = end.format('YYYY-MM-DD');
	});	

	/* 날짜 선택 완료 시 데이트 포맷 */
	$('input[name="daterange"]').on('apply.daterangepicker', function(ev, picker) {
		$(this).val(picker.startDate.format('YYYY-MM-DD') + ' ~ ' + picker.endDate.format('YYYY-MM-DD'));
	});
	
	$('input[name="daterange"]').on('cancel.daterangepicker', function(ev, picker) {
	      $(this).val('');
	  });

	
	/* 검색 버튼 클릭 */
	$("#searchBtn").click(function() {
	
		/* 검색 조건 하나라도 선택 안 했을 경우 */
		if($('input[name="daterange"]').val()=='') {
			swal('잠깐!', '검색 조건을 선택하세요', 'warning');
		} else {
			$.ajax({
		        url : "/mypage/getUserSearchList",
		        data : {"startDate" : startDate,
		        		"endDate" : endDate},
		        type : "POST",
		        dataType : "json",
		        success : function(data){
		        	var table = '';
		        	if (data.userSearchList.length == 0) {
		        		table += '<tr><td colspan="8"> 해당 기간 내 예약이 존재하지 않습니다. </td></tr>';
		        	} else {
		        		table += makeTable(data.userSearchList);
		        	}
		        	//$("#tableBody").empty().append(table);
		        	//makeChart(workplaceNo, data.searchList);
		        },
		        error : function(){
		            alert("검색 예약 현황 조회 에러");
		        }
			});
		}
		
	});
	
 	/* 초기화 버튼 클릭 */
	$("#resetBtn").on("click", function() {
		resetData();
		$("a[value=" + workplaceNo + "]").trigger("click");	// 현재 선택된 지사 탭에서 검색된 리스트 -> 전체 리스트로 초기화
	});
	
	/* 검색 옵션 초기화 */
	function resetData() {
		// Data Range Picker 초기화
		$('input[name="daterange"]').val('');
	}
});
</script>