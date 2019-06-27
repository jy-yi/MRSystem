<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Main Content -->
<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<div class="d-sm-flex align-items-center justify-content-between mb-4">
		<h1 class="h5 mb-0 text-gray-800">
			<i class="fas fa-user"></i> 관리자 > 예약 통계
		</h1>
	</div>

	<ul class="nav nav-tabs">
		<!-- 지사 목록 DB 연동 (session에 담겨있는 지사 목록) -->
		<c:forEach items="${workplaceList}" var="list" varStatus="status">
			<li class="nav-item">
				<a class="nav-link workplace-list ${status.index eq 0 ? 'active':''}" data-toggle="tab" href="#workplace${list.workplaceNo}" value="${list.workplaceNo}">${list.name}</a></li>
		</c:forEach>
	</ul>

	<!-- Content Row -->
	<div class="row">
		<div class="col-xl-8">

			<div class="tab-content">
				<c:forEach items="${workplaceList}" var="workplaceList" varStatus="status">
					<div class="tab-pane fade show ${status.index eq 0 ? 'active':''}" id="workplace${workplaceList.workplaceNo}">
	
						<!-- Bar Chart -->
						<div class="card shadow mb-4">
							<div class="card-header py-3">
								<h6 class="m-0 font-weight-bold text-primary">${workplaceList.name}</h6>
							</div>
							<div class="card-body">
								<div class="chart-bar">
									<canvas id="myBarChart${workplaceList.workplaceNo}"></canvas>
								</div>
							</div>
						</div>
						<!-- End of Bar Chart -->
					</div>
				</c:forEach>
			</div>
		</div>

		<div class="col-xl-4">
			<br>
			
			<div class="small mb-1"> 부서 : </div>
			<select id="departmentSelect" name="dataTable_length" aria-controls="dataTable" class="custom-select custom-select-sm form-control form-control-sm">
				<option value="0"> 조회하고 싶은 부서를 선택하세요. </option>
				<c:forEach items="${departmentList}" var="list">
					<option value="${list.departmentNo }">${list.name }</option>
				</c:forEach>
			</select>
	
			<hr>
	
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
		</div>
	</div>

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
					<h6 class="m-0 font-weight-bold text-primary">전체 예약 현황</h6>
				</div>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered text-center" >
							<thead>
								<tr>
									<th>No</th>
									<th width="15%">회의명</th>
									<th>회의 목적</th>
									<th>회의실</th>
									<th width="30%">기간</th>
									<th>신청자</th>
									<th width="15%">주관부서</th>
									<th>승인 상태</th>
								</tr>
							</thead>
							<tbody id="tableBody">
							</tbody>
						</table>
					</div>
				</div>
			</div>

		</div>
		<!-- /.container-fluid -->

	</div>
</div>

<!-- Bar Chart -->
<script src="/resources/js/demo/chart-bar-demo.js"></script>
<script src="/resources/js/moment.min.js"></script>

<script>
	var adminId = "${adminId}";
	console.log(adminId);
	if (adminId == "") {
		swal('접근 제한', '잘못된 접근입니다.', 'error'
		).then(function(){
		    	location.href="/user/logout";
	    });
	}
</script>

<script type="text/javascript">

$(function() {
	
	var workplaceNo = "";
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

	/* 검색 조건 미설정 시 해당 본사에 속해있는 모든 회의실 예약 정보 조회 */
	$(".workplace-list").on("click", function() {
		
		resetData(); // 지사 탭 변경 시 검색 옵션 초기화
		
		workplaceNo = $(this).attr('value');
		
		$.ajax({
	        url : "/statistic/getReservationList",
	        data : {"workplaceNo": workplaceNo},
	        type : "POST",
	        dataType : "json",
	        success : function(data){
	        	var table = '';
	        	if (data.reservationList.length == 0) {
	        		table += '<tr><td colspan="8"> 해당 기간 내 예약이 존재하지 않습니다. </td></tr>';
	        	} else {
	        		table += makeTable(data.reservationList);
	        	}
	        	$("#tableBody").empty().append(table);
				makeChart(workplaceNo, data.reservationList);	// 그래프 그려주기
	        },
	        error : function(){
	            alert("전체 예약 현황 조회 에러");
	        }
	    });
		
	
	});
	
	/* 페이지 처음 로딩 시 지사 탭 제일 처음 클릭 이벤트 디폴트 처리 */
	$(".workplace-list:first").trigger("click");	
	
	/* 검색 버튼 클릭 */
	$("#searchBtn").click(function() {
		var departmentNo = $("#departmentSelect").val();
	
		/* 검색 조건 하나라도 선택 안 했을 경우 */
		if(departmentNo == 0 || $('input[name="daterange"]').val()=='') {
			swal('잠깐!', '검색 조건을 선택하세요', 'warning');
		} else {
			$.ajax({
		        url : "/statistic/getSearchList",
		        data : {"workplaceNo" : workplaceNo,
		        		"departmentNo" : departmentNo,
		        		"startDate" : startDate,
		        		"endDate" : endDate},
		        type : "POST",
		        dataType : "json",
		        success : function(data){
		        	var table = '';
		        	if (data.searchList.length == 0) {
		        		table += '<tr><td colspan="8"> 해당 기간 내 예약이 존재하지 않습니다. </td></tr>';
		        	} else {
		        		table += makeTable(data.searchList);
		        	}
		        	$("#tableBody").empty().append(table);
		        	makeChart(workplaceNo, data.searchList);
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
	
	/* 예약 현황 목록 table 삽입 */
	function makeTable(list, table) {
		$.each(list , function(i, item){
    		table += '<tr>'
    		table += '<td> ' + (i+1) + ' </td>';
    		table += '<td> ' + item.RESNAME + ' </td>';
    		table += '<td> ' + item.PURPOSE + ' </td>';
    		table += '<td> ' + item.ROOMNAME + ' </td>';
    		table += '<td> ' + item.STARTDATE + ' - ' + item.ENDDATE + ' </td>';
    		table += '<td> ' + item.EMPNAME + ' </td>';
    		table += '<td> ' + item.DEPARTMENTNAME + ' </td>';
    		
    		if (item.STATUS == 0)
        		table += '<td class="text-success"> 승인 대기 </td>';
    		else if (item.STATUS == 1)
    			table += '<td class="text-primary"> 예약 완료 </td>';
			else if (item.STATUS == 2)
    			table += '<td class="text-danger"> 예약 반려 </td>';
			else if (item.STATUS == 3)
				table += '<td class="text-warning"> 예약 취소 </td>';
			else if (item.STATUS == 4)
    			table += '<td class="text-success"> 회의 시작 </td>';
			else if (item.STATUS == 5)
    			table += '<td class="text-primary"> 회의 종료 </td>';
			else if (item.STATUS == 6)
				table += '<td class="text-warning"> 회의 노쇼 </td>';
       });
		
		return table;
	}
	
	/* 검색 옵션 초기화 */
	function resetData() {
		// 부서 선택 select 초기화
		$("#departmentSelect").val("0").prop("selected", true);
		// Data Range Picker 초기화
		$('input[name="daterange"]').val('');
	}
});
</script>