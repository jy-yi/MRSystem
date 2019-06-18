<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
th {
	width: 20%;
}
</style>

<!-- Main Content -->

<div id="content">

	<!-- Begin Page Content -->
	<div class="container-fluid">

		<div class="row">

			<!-- Begin Page Content -->
			<div class="container-fluid">
				<!-- Page Heading -->
				<div
					class="d-sm-flex align-items-center justify-content-between mb-4">
					<h1 class="h5 mb-0 text-gray-800">
						<i class="fas fa-user"></i> 예약하기 > 예약 정보 확인
					</h1>
				</div>
			</div>

			<!-- Content Row -->
			<div class="col-lg-1"></div>
			<div class="col-lg-10">
				<div class="card shadow mb-10">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary">예약 정보</h6>
					</div>
					<div class="card-body">
					
						<table class="table table-bordered text-center" >
							<tr>
								<th>회의실</th>
								<td>${roomInfo.ROOMNAME}</td>
							</tr>
							<tr>
								<th>회의명</th>
								<td>${meetingName}</td>
							</tr>
							<tr>
								<th>회의 목적</th>
								<td>${purpose}</td>
							</tr>
							<tr>
								<th>예약일</th>
								<td>${date}</td>
							</tr>
							<tr>
								<th>예약자</th>
								<td>${employeeDto.name}</td>
							</tr>
							<tr>
								<th>가격</th>
								<td>${price}원</td>
							</tr>
							<tr>
								<th>연락처</th>
								<td>${employeeDto.phone}</td>
							</tr>
							<tr>
								<th>이메일</th>
								<td>${employeeDto.email}</td>
							</tr>
							<tr>
								<th>참여 인원</th>
								<td>
									<c:forEach items="${participation }" var="emp">
										${emp.NAME}(${emp.DEPARTMENTNAME})
									</c:forEach>
								</td>
							</tr>
							<tr>
								<th>주관 부서</th>
								<td>
									<c:forEach items="${mainDept}" var="dept">
										${dept.NAME}
									</c:forEach> 
								</td>
							</tr>
							<c:if test="!empty ${subDept }">
								<tr>
									<th>협조 부서</th>
									<td>
										<c:forEach items="${subDept}" var="dept">
											${dept.NAME}
										</c:forEach> 
									</td>
								</tr>
							</c:if>
							<c:if test="!empty ${equipments }">
								<tr>
									<th>비품 대여 신청 목록</th>
									<td>
										<c:forEach items="${equipments }" var="equipment">
											${equipment.NAME}
										</c:forEach>
									</td>
								</tr>
							</c:if>
						</table>
					</div>
				</div>
				
				<hr>
				
				<div class="text-center">
					<button class="btn btn-primary col-lg-1" onclick="doReserve()">신청</button>
					<button class="btn btn-danger col-lg-1" onclick="">취소</button>
				</div>
			</div>
		</div>
		<br>
	</div>
</div>
<script>
	function doReserve() {
		alert("예약이 완료되었습니다.");
	}
</script>
