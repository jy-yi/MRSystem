<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.15/css/bootstrap-multiselect.css" type="text/css">
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.15/js/bootstrap-multiselect.min.js"></script>

<!-- Main Content -->
<div id="content">

	<!-- Begin Page Content -->
	<div class="container-fluid">

		<!-- Page Heading -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h1 class="h5 mb-0 text-gray-800">
				<i class="fas fa-user"></i> 지사/회의실 관리 > 회의실 관리
			</h1>
		</div>

		<!-- Content Row -->
		<div class="row">

			<ul class="nav nav-tabs">
				<!-- 지사 목록 DB 연동 (session에 담겨있는 지사 목록) -->
				<c:forEach items="${workplaceList}" var="list" varStatus="status">
					<li class="nav-item"><a class="nav-link  ${status.index eq 0 ? 'active':''}" data-toggle="tab" href="#workplace${list.workplaceNo}">${list.name}</a></li>
				</c:forEach>
			</ul>

			<div class="card-body py-2 text-right">
				<a href="#" class="btn btn-secondary btn-icon-split" data-toggle="modal" data-target="#addRoomModal"> 
					<span class="icon text-white-50 pull-right"> 
						<i class="fas fa-plus-circle"></i>
					</span> 
					<span class="text">회의실 추가</span>
				</a>
			</div>

			<div class="tab-content">
				<c:forEach items="${workplaceList}" var="workplaceList" varStatus="status">
					<div class="tab-pane fade show ${status.index eq 0 ? 'active':''}" id="workplace${workplaceList.workplaceNo}">
					
						<div class="row">
							<c:forEach items="${roomList}" var="list">
								<c:if test="${workplaceList.workplaceNo eq list.WORKPLACENO}">
									<div class="col-xl-4 col-md-4 mb-4">
										<div class="card shadow mb-4">
											<div class="card-header py-3">
												<h5 class="m-0 font-weight-bold text-primary"> ${list.ROOMNAME} 
													<span style="float:right"> 
														<i class="fas fa-edit"></i>
														<i class="fas fa-trash-alt"></i> 
													</span> 
													<input type="hidden" id="roomNo" name="roomNo" value="${list.ROOMNO}">
												</h5>
												
											</div>
											<div class="card-body">
												<div class="text-center"><img alt="회의실 사진" src="/resources/img/room/${list.IMAGE}" width="80%"></div>
												<p>
												<div>수용 인원 : ${list.CAPACITY}명</div>
												<div>비치 물품 : <span id="equipList"></span></div>
												<div>네트워크 : ${list.NWAVAILABLE eq 'Y' ? "사용 가능":"사용 불가능" }</div>
												<div>관리자 : ${list.DEPTNAME } ${list.ADMINNAME }</div>
											</div>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</c:forEach>
				
			</div>
		</div>

	</div>
	<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->


<!-- Modal -->
<jsp:include page="include/addRoom.jsp" />
<jsp:include page="include/editRoom.jsp" />

<script type="text/javascript">

/* 회의실 별 비품 목록 AJAX */
$(function() {
	$('.card').each(function(i, e){
		$.ajax({
	        url : "/resource/getEquipmentList",
	        data : {roomNo: $(e).find("#roomNo").val()},
	        type : "POST",
	        dataType : "json",
	        success : function(data){
	            var str = '';
	            $.each(data.equipmentList , function(i, item){
	                str += item.NAME + " ";
	           });
	            
	            $(e).find("#equipList").append(str); 
	        },
	        error : function(){
	            alert("회의실 별 비품 목록 조회 에러");
	        }
	    });
	});
	
});


$(function() {
	$('.fa-edit').click(function(){
		$('#editRoomModal').modal("show");
	});
	
	/* 휴지통 아이콘 클릭 */
	$(".fa-trash-alt").click(function() {
		Swal.fire({
			  title: 'Are you sure?',
			  text: "You won't be able to revert this!",
			  type: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: 'Yes, delete it!'
			}).then((result) => {
			  if (result.value) {
			    Swal.fire(
			      'Deleted!',
			      'Your file has been deleted.',
			      'success'
			    )
			  }
			});
		
	});
});
</script>
