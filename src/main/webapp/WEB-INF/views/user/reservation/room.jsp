<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel= "stylesheet" type="text/css" href="/resources/css/user/reservation-room.css">

<!-- Main Content -->
<div id="content">

	<!-- Begin Page Content -->
	<div class="container-fluid">

	<div class="row">

		<!-- Begin Page Content -->
		<div class="container-fluid">

			<!-- Page Heading -->
			<div class="d-sm-flex align-items-center justify-content-between mb-4">
				<h1 class="h5 mb-0 text-gray-800"> <i class="fas fa-user"></i> 예약하기 > 회의실 선택 </h1>
			</div>

		<!-- Content Row -->
		<div class="row">

			<ul class="nav nav-tabs">
				<!-- 지사 목록 DB 연동 (session에 담겨있는 지사 목록) -->
				<c:forEach items="${workplaceList}" var="list" varStatus="status">
					<li class="nav-item"><a class="nav-link  ${status.index eq 0 ? 'active':''}" data-toggle="tab" href="#workplace${list.workplaceNo}">${list.name}</a></li>
				</c:forEach>
			</ul>

			<div class="tab-content">
				<c:forEach items="${workplaceList}" var="workplaceList" varStatus="status">
					<div class="tab-pane fade show ${status.index eq 0 ? 'active':''}" id="workplace${workplaceList.workplaceNo}">
						<div class="row">
							<c:forEach items="${roomList}" var="list">
								<c:if test="${workplaceList.workplaceNo eq list.WORKPLACENO}">
									<div class="col-xl-4 col-md-4 mb-4">
										<div class="card shadow mb-4" style="height: 30em">
											<div class="card-header py-3">
												<h5 class="m-0 font-weight-bold text-primary"> ${list.ROOMNAME}
												 
												<span style="float:right"> 
													<a href="/reservation/shortTerm_chooseDate/${list.ROOMNO}" class="btn btn-warning"> <span class="text">단기 예약</span> </a>
													<a href="/reservation/longTerm_chooseDate/${list.ROOMNO}" class="btn btn-primary"> <span class="text">장기 예약</span> </a>
												</span> 
												
													<input type="hidden" id="roomNo" name="roomNo" value="${list.ROOMNO}">
												</h5>
												
											</div>
											<div class="card-body">
												<div class="text-center"><img alt="회의실 사진" src="/resources/img/room/${list.IMAGE}" width="80%" height="200em"></div>
												<p>
												<div>구분 : ${list.ROOMTYPE}</div>
												<div>수용 인원 : ${list.CAPACITY}명</div>
												<div>비치 물품 : <span id="equipList"></span></div>
												<div>네트워크 : ${list.NWAVAILABLE eq 'Y' ? "사용 가능":"사용 불가능" }</div>
												<div>사용 요금 : 10,000원/시간</div>
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
	</div>

</div>

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
</script>