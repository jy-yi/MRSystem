<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>

<!DOCTYPE html>
<html>

<!-- Main Content -->
<div id="content">

	<!-- Begin Page Content -->
	<div class="container-fluid">

		<!-- Page Heading -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h1 class="h5 mb-0 text-gray-800">
				<i class="fas fa-user"></i> 지사/회의실 관리 > 지사 관리
			</h1>
		</div>

		<!-- Content Row -->
		<div class="row">

			<!-- Begin Page Content -->
			<div class="container-fluid">

				<!-- DataTales Example -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary">지사 목록</h6>
					</div>
					<div class="card-body py-2 text-right">
						<a href="#" class="btn btn-secondary btn-icon-split" data-toggle="modal" data-target="#addWorkplaceModal"> 
							<span class="icon text-white-50 pull-right"> 
								<i class="fas fa-plus-circle"></i>
							</span> 
							<span class="text">지사 추가</span>
						</a>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
								<thead>
									<tr>
										<th>No</th>
										<th>이름</th>
										<th>주소</th>
										<th>수정</th>
										<th>삭제</th>
									</tr>
								</thead>

								<tbody>
									<tr>
										<td>1</td>
										<td>$320,800</td>
										<td>$320,800</td>
										<td><a href="/reservation/statusCalendar" class="btn btn-primary"> <span class="text">수정</span> </a></td>
										<td><a href="/reservation/statusCalendar" class="btn btn-danger"> <span class="text">삭제</span> </a></td>
									</tr>
									<tr>
										<td>2</td>
										<td>$320,800</td>
										<td>$320,800</td>
										<td><a href="/reservation/statusCalendar" class="btn btn-primary"> <span class="text">수정</span> </a></td>
										<td><a href="/reservation/statusCalendar" class="btn btn-danger"> <span class="text">삭제</span> </a></td>
									</tr>
									<tr>
										<td>3</td>
										<td>$320,800</td>
										<td>$320,800</td>
										<td><a href="/reservation/statusCalendar" class="btn btn-primary"> <span class="text">수정</span> </a></td>
										<td><a href="/reservation/statusCalendar" class="btn btn-danger"> <span class="text">삭제</span> </a></td>
									</tr>
									<tr>
										<td>4</td>
										<td>$320,800</td>
										<td>$320,800</td>
										<td><a href="/reservation/statusCalendar" class="btn btn-primary"> <span class="text">수정</span> </a></td>
										<td><a href="/reservation/statusCalendar" class="btn btn-danger"> <span class="text">삭제</span> </a></td>
									</tr>
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


<!-- Modal -->
<jsp:include page="include/addWorkplace.jsp" />


<script type="text/javascript">
// 	$(function() {
// 		swal('Good job!', 'You clicked the button!', 'success')
// 	});
</script>
</body>

</html>
