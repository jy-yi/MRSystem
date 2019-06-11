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
									<canvas id="myBarChart"></canvas>
								</div>
							</div>
						</div>
						<!-- End of Bar Chart -->
					</div>
				</c:forEach>
			</div>
		</div>

		<div class="col-xl-4">
			<div id="selectDept">
				<p>조회하고 싶은 부서를 선택하세요.</p>
				<select name="dataTable_length" aria-controls="dataTable"
					class="custom-select custom-select-sm form-control form-control-sm">
					<option value="0"> --- 부서 선택 --- </option>
					<c:forEach items="${departmentList}" var="list">
						<option value="${list.departmentNo }">${list.name }</option>
					</c:forEach>
				</select>
			</div>
	
			<hr>
	
			<div>
				<p>조회하고 싶은 날짜를 선택하세요.</p>
				<div>
					<input type="text" class="form-control" name="datefilter" />
				</div>
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
						<table class="table table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>No</th>
									<th>회의명</th>
									<th>회의 목적</th>
									<th>회의실</th>
									<th>기간</th>
									<th>신청자</th>
									<th>주관부서</th>
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

<script type="text/javascript">

/* Date Range Picker */
$(function() {
	$('input[name="datefilter"]').daterangepicker({
		autoUpdateInput : false,
		locale : {
			cancelLabel : 'Clear'
		}
	});

	$('input[name="datefilter"]').on('apply.daterangepicker', function(ev, picker) {
			$(this).val(picker.startDate.format('YYYY/MM/DD') + ' - ' + picker.endDate.format('YYYY/MM/DD'));
	});

	$('input[name="datefilter"]').on('cancel.daterangepicker', function(ev, picker) {
			$(this).val('');
	});

});

$(function() {
	/* 검색 조건 미설정 시 해당 본사에 속해있는 모든 회의실 예약 정보 조회 */
	$(".workplace-list").on("click", function() {
		$.ajax({
	        url : "/statistic/getReservationList",
	        data : {workplaceNo: $(this).attr('value')},
	        type : "POST",
	        dataType : "json",
	        success : function(data){
	        	var table = '';
	        	if (data.reservationList.length == 0) {
	        		table += '<tr><td  colspan="8"> 해당 기간 내 예약이 존재하지 않습니다. </td></tr>';
	        	} else {
		        	$.each(data.reservationList , function(i, item){
		        		table += '<tr>'
		        		table += '<td> ' + (i+1) + ' </td>';
		        		table += '<td> ' + item.RESNAME + ' </td>';
		        		table += '<td> ' + item.PURPOSE + ' </td>';
		        		table += '<td> ' + item.ROOMNAME + ' </td>';
		        		table += '<td> ' + item.STARTDATE + ' - ' + item.ENDDATE + ' </td>';
		        		table += '<td> ' + item.EMPNAME + ' </td>';
		        		table += '<td> ' + item.DEPARTMENTNAME + ' </td>';
		        		table += '<td> ' + item.STATUS + ' </td>';
		        		table += '</tr>';
		           });
	        	}
	        	$("#tableBody").empty().append(table);
	        },
	        error : function(){
	            alert("전체 예약 현황 조회 에러");
	        }
	    });
	});
	
	/* 페이지 처음 로딩 시 지사 탭 제일 처음 클릭 이벤트 디폴트 처리 */
	$(".workplace-list:first").trigger("click");	
});

</script>