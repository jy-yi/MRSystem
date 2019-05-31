<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.min.css" />
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker3.min.css" />
<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.min.js"></script>

<!-- Main Content -->
<div id="content">

	<!-- Begin Page Content -->
	<div class="container-fluid">

		<!-- Page Heading -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h1 class="h5 mb-0 text-gray-800">
				<i class="fas fa-user"></i> 지사/회의실 관리 > 비품 관리
			</h1>
		</div>

		<!-- Content Row -->
		<div class="row">

			<!-- Begin Page Content -->
			<div class="container-fluid">

				<!-- DataTales Example -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary">비품 목록</h6>
					</div>
					<div class="card-body py-2 text-right">
						<a href="#" class="btn btn-secondary btn-icon-split" data-toggle="modal" data-target="#addEquipModal"> 
							<span class="icon text-white-50 pull-right"> <i class="fas fa-plus-circle"></i> </span> <span class="text">비품 추가</span>
						</a>
					</div>

					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
								<thead>
									<tr>
										<th>No</th>
										<th>이름</th>
										<th>구매일</th>
										<th>비치 장소</th>
										<th>수정</th>
										<th>삭제</th>
									</tr>
								</thead>

								<tbody>
									<c:choose>
										<c:when test="${empty equipmentList}">
											<td colspan="9" class="text-center">비품이 존재하지 않습니다.</td>
										</c:when>
										<c:otherwise>
											<c:forEach items="${equipmentList}" var="list" varStatus="status">
												<tr>
													<td>${status.count }</td>
													<td>${list.EQUIPNAME }</td>
													<td>${list.BUYDATE }</td>
													<td>${list.ROOMNAME }</td>
													<td><a href="/reservation/statusCalendar" class="btn btn-primary"> <span class="text">수정</span> </a></td>
													<td>
														<button class="btn btn-danger"> 삭제 </button>
														<input type="hidden" id="equipmentNo" name="equipmentNo" value="${list. EQUIPNO}">
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
	<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->

<!-- Modal -->
<jsp:include page="include/addEquipment.jsp" />
<jsp:include page="include/editEquipment.jsp" />

<script type="text/javascript">
	
	/* 삭제 버튼 클릭 */
	$(document).on("click", ".btn-danger", function() {
		var equipmentNo = $(this).next().val();	// 삭제 버튼을 클릭한 비품의 번호
		
		swal({
			title: '정말 삭제하시겠습니까?',
			text: "이후 복구는 불가능합니다.",
			type: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
  		    confirmButtonText: 'Yes',
  		    cancelButtonText: 'No',
  		}).then( (result) => {
  			if (result.value) {
	  			$.ajax({
					url : "/resource/deleteEquipment",
					type : "POST",
					data : {
						equipmentNo : equipmentNo,
					}, success : function(data) {
						swal('Success!', '비품 삭제가 완료되었습니다.', 'success'
				    		).then(function(){
	  		    		    	location.href="/resource/equipmentList";
	  		    		    });
					}
				});
  			}
  			  
  		});
	});
</script>