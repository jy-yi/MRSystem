<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Main Content -->
<div id="content">

	<!-- Begin Page Content -->
	<div class="container-fluid">

		<!-- Page Heading -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h1 class="h5 mb-0 text-gray-800">
				<i class="fas fa-user"></i> 예약 관리 > 예약 완료 목록
			</h1>
		</div>

		<!-- Content Row -->
		<div class="row">

			<!-- Begin Page Content -->
			<div class="container-fluid">

				<!-- DataTales Example -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary"> 예약 완료 목록</h6>
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
										<th>결재자</th>
										<th>상태</th>
									</tr>
								</thead>

								<tbody>
									<c:choose>
										<c:when test="${empty successList}">
											<td colspan="9" class="text-center"> 완료된 예약이 존재하지 않습니다.</td>
										</c:when>
										<c:otherwise>
											<c:forEach items="${successList}" var="list" varStatus="status">
												<tr>
													<td> ${status.count} </td>
													<td> ${list.RESNAME}</td>
													<td> ${list.PURPOSE}</td>
													<td> ${list.ROOMNAME}</td>
													<td> ${list.STARTDATE} - ${list.ENDDATE}</td>
													<td> ${list.EMPNAME}</td>
													<td> ${list.MGRNAME}</td>
													
													<c:if test="${list.STATUS eq 0 }">
														<td> <span class="text-danger"> 미사용 </span> </td>
													</c:if>
													
													<c:if test="${list.STATUS eq 1 }">
														<td> <span class="text-warning"> 사용 중 </span> </td>
													</c:if>
													
													<c:if test="${list.STATUS eq 2 }">
														<td> <span class="text-primary"> 사용 완료 </span></td>
													</c:if>
													
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
	<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->