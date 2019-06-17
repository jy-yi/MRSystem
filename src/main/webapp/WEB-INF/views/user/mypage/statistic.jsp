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
				<thead>
					<tr class="rHeader">
						<th colspan="2">개인</th>
						<th colspan="2">부서</th>
					</tr>
					<tr>
						<td>횟수</td>
						<td>비용</td>
						<td>횟수</td>
						<td>비용</td>
					</tr>
				</thead>
				<tbody id="tableBody2">
					<tr>
						<td id="countIn"></td>
						<td id="sumIn"></td>
						<td id="countDe"></td>
						<td id="sumDe"></td>
					</tr>
				</tbody>
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
						<table class="table table-bordered text-center" >
							<thead>
								<tr>
									<th>No</th>
									<th>회의명</th>
									<th>회의 목적</th>
									<th>회의실번호</th>
									<th>기간</th>
									<th>주관부서</th>
									<th>승인 상태</th>
								</tr>
							</thead>
							
							<tbody id="tableBody"></tbody>
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
	
	var employeeNo = "";
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

	/* 검색 조건 미설정 시 모든 예약 정보 조회 */
	$(function allList() {
		resetData(); 
		
		employeeNo = $(this).attr('value');
		
		$.ajax({
	        url : "/statistic/getUserAllList",
	        data : {"employeeNo": employeeNo},
	        type : "POST",
	        success : function(data){
	        	//alert(JSON.stringify(data.getIndividual));
	        	var table = '';
	        	if (data.userAllList.length == 0) {
	        		table += '<tr><td colspan="8"> 해당 기간 내 예약이 존재하지 않습니다. </td></tr>';
	        	} else {
	        		table += makeTable(data.userAllList);
	        	}
	        	$("#tableBody").empty().append(table);
				$('#countIn').text(data.getIndividual.COUNT);
				$('#sumIn').text(data.getIndividual.SUM);
				$('#countDe').text(data.getDepartment.COUNT);
				$('#sumDe').text(data.getDepartment.SUM);
	        },
	        error : function(){
	            alert("전체 예약 현황 조회 에러");
	        }
	    });
	});
	
	/* 검색 버튼 클릭 */
	$("#searchBtn").click(function() {
		
		/* 검색 조건 하나라도 선택 안 했을 경우 */
		if($('input[name="daterange"]').val()=='') {
			swal('잠깐!', '검색 조건을 선택하세요', 'warning');
		} else {
			$.ajax({
		        url : "/statistic/getUserSearchList",
		        data : {"employeeNo" : employeeNo,
		        		"startDate" : startDate,
		        		"endDate" : endDate},
		        type : "POST",
		        dataType : "json",
		        success : function(data){
		        	alert(JSON.stringify(data.getIndividualDate));
		        	var table = '';
		        	if (data.userSearchList.length == 0) {
		        		table += '<tr><td colspan="8"> 해당 기간 내 예약이 존재하지 않습니다. </td></tr>';
		        	} else {
		        		table += makeTable(data.userSearchList);
		        	}
		        	$("#tableBody").empty().append(table);
		        	$('#countIn').text(data.getIndividualDate.COUNT);
					$('#sumIn').text(data.getIndividualDate.SUM);
					$('#countDe').text(data.getDepartmentDate.COUNT);
					$('#sumDe').text(data.getDepartmentDate.SUM);
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
		
	});
	
	/* 리스트 table 삽입 */
	function makeTable(list, table) {
		$.each(list , function(i, item){
    		table += '<tr>'
    		table += '<td> ' + (i+1) + ' </td>';
    		table += '<td> ' + item.RESERVATIONNAME + ' </td>';
    		table += '<td> ' + item.PURPOSE + ' </td>';
    		table += '<td> ' + item.ROOMNO + ' </td>';
    		table += '<td> ' + item.STARTDATE + ' - ' + item.ENDDATE + ' </td>';
    		table += '<td> ' + item.DEPARTMENTNAME + ' </td>';
    		
    		if (item.STATUS == 0)
        		table += '<td class="text-success"> 승인 대기 </td>';
    		else if (item.STATUS == 1)
    			table += '<td class="text-primary"> 예약 완료 </td>';
			else if (item.STATUS == 2)
    			table += '<td class="text-danger"> 예약 반려 </td>';
			else
				table += '<td class="text-warning"> 예약 취소 </td>';
    		table += '</tr>';
       });
		
		return table;
	}
	
	/* 검색 옵션 초기화 */
	function resetData() {
		// Data Range Picker 초기화
		$('input[name="daterange"]').val('');
	}
});
</script>