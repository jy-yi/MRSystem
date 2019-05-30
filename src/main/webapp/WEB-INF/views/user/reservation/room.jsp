<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>

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
				<li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#qwe">본사</a></li>
				<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#asd">삼환빌딩</a></li>
				<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#zxc">GS 강남타워</a></li>
				<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#zxc">GS 강서타워</a></li>
			</ul>

			<div class="tab-content">
				<div class="tab-pane fade show active" id="qwe">

					<div class="row">
						<div class="col-xl-4 col-md-4 mb-4">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h5 class="m-0 font-weight-bold text-primary"> 몰디브 
										<span style="float:right"> 
											<a href="/reservation/shortTerm_chooseDate/${roomNo}" class="btn btn-warning"> <span class="text">단기 예약</span> </a>
											<a href="#" class="btn btn-primary"> <span class="text">장기 예약</span> </a>
										</span> 
									</h5>
									
								</div>
								<div class="card-body">
									<div class="text-center"><img alt="회의실 사진" src="/resources/img/room1.jpg" width="80%"></div>
									<p>
									<div>구분 : 회의실</div>
									<div>위치 : 본사 2층</div>
									<div>수용 인원 : 20명</div>
									<div>비치 물품 : 빔프로젝터 노트북</div>
									<div>네트워크 : 사용 가능</div>
									<div>사용 요금 : 10,000원/시간</div>
									<div>관리자 : 인사지원실 이예지</div>
								</div>
							</div>
						</div>
						<div class="col-xl-4 col-md-4 mb-4">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h5 class="m-0 font-weight-bold text-primary"> 몰디브 
										<span style="float:right"> 
											<i class="fas fa-edit"></i>
											<i class="fas fa-trash-alt"></i> 
										</span> 
									</h5>
									
								</div>
								<div class="card-body">
									<div class="text-center"><img alt="회의실 사진" src="/resources/img/room1.jpg" width="80%"></div>
									<p>
									<div>구분 : 회의실</div>
									<div>위치 : 본사 2층</div>
									<div>수용 인원 : 20명</div>
									<div>비치 물품 : 빔프로젝터 노트북</div>
									<div>네트워크 : 사용 가능</div>
									<div>사용 요금 : 10,000원/시간</div>
									<div>관리자 : 인사지원실 이예지</div>
								</div>
							</div>
						</div>
						<div class="col-xl-4 col-md-4 mb-4">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h5 class="m-0 font-weight-bold text-primary"> 몰디브 
										<span style="float:right"> 
											<i class="fas fa-edit"></i>
											<i class="fas fa-trash-alt"></i> 
										</span> 
									</h5>
									
								</div>
								<div class="card-body">
									<div class="text-center"><img alt="회의실 사진" src="/resources/img/room1.jpg" width="80%"></div>
									<p>
									<div>구분 : 회의실</div>
									<div>위치 : 본사 2층</div>
									<div>수용 인원 : 20명</div>
									<div>비치 물품 : 빔프로젝터 노트북</div>
									<div>네트워크 : 사용 가능</div>
									<div>사용 요금 : 10,000원/시간</div>
									<div>관리자 : 인사지원실 이예지</div>
								</div>
							</div>
						</div>
						<div class="col-xl-4 col-md-4 mb-4">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h5 class="m-0 font-weight-bold text-primary"> 몰디브 
										<span style="float:right"> 
											<i class="fas fa-edit"></i>
											<i class="fas fa-trash-alt"></i> 
										</span> 
									</h5>
									
								</div>
								<div class="card-body">
									<div class="text-center"><img alt="회의실 사진" src="/resources/img/room1.jpg" width="80%"></div>
									<p>
									<div>구분 : 회의실</div>
									<div>위치 : 본사 2층</div>
									<div>수용 인원 : 20명</div>
									<div>비치 물품 : 빔프로젝터 노트북</div>
									<div>네트워크 : 사용 가능</div>
									<div>사용 요금 : 10,000원/시간</div>
									<div>관리자 : 인사지원실 이예지</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="asd">
					<div class="row">
						<div class="col-xl-4 col-md-4 mb-4">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h5 class="m-0 font-weight-bold text-primary"> 몰디브 
										<span style="float:right"> 
											<i class="fas fa-edit"></i>
											<i class="fas fa-trash-alt"></i> 
										</span> 
									</h5>
									
								</div>
								<div class="card-body">
									<div class="text-center"><img alt="회의실 사진" src="/resources/img/room1.jpg" width="80%"></div>
									<p>
									<div>구분 : 회의실</div>
									<div>위치 : 본사 2층</div>
									<div>수용 인원 : 20명</div>
									<div>비치 물품 : 빔프로젝터 노트북</div>
									<div>네트워크 : 사용 가능</div>
									<div>사용 요금 : 10,000원/시간</div>
									<div>관리자 : 인사지원실 이예지</div>
								</div>
							</div>
						</div>
						<div class="col-xl-4 col-md-4 mb-4">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h5 class="m-0 font-weight-bold text-primary"> 몰디브 
										<span style="float:right"> 
											<i class="fas fa-edit"></i>
											<i class="fas fa-trash-alt"></i> 
										</span> 
									</h5>
									
								</div>
								<div class="card-body">
									<div class="text-center"><img alt="회의실 사진" src="/resources/img/room1.jpg" width="80%"></div>
									<p>
									<div>구분 : 회의실</div>
									<div>위치 : 본사 2층</div>
									<div>수용 인원 : 20명</div>
									<div>비치 물품 : 빔프로젝터 노트북</div>
									<div>네트워크 : 사용 가능</div>
									<div>사용 요금 : 10,000원/시간</div>
									<div>관리자 : 인사지원실 이예지</div>
								</div>
							</div>
						</div>
						<div class="col-xl-4 col-md-4 mb-4">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h5 class="m-0 font-weight-bold text-primary"> 몰디브 
										<span style="float:right"> 
											<i class="fas fa-edit"></i>
											<i class="fas fa-trash-alt"></i> 
										</span> 
									</h5>
									
								</div>
								<div class="card-body">
									<div class="text-center"><img alt="회의실 사진" src="/resources/img/room1.jpg" width="80%"></div>
									<p>
									<div>구분 : 회의실</div>
									<div>위치 : 본사 2층</div>
									<div>수용 인원 : 20명</div>
									<div>비치 물품 : 빔프로젝터 노트북</div>
									<div>네트워크 : 사용 가능</div>
									<div>사용 요금 : 10,000원/시간</div>
									<div>관리자 : 인사지원실 이예지</div>
								</div>
							</div>
						</div>
						<div class="col-xl-4 col-md-4 mb-4">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h5 class="m-0 font-weight-bold text-primary"> 몰디브 
										<span style="float:right"> 
											<i class="fas fa-edit"></i>
											<i class="fas fa-trash-alt"></i> 
										</span> 
									</h5>
									
								</div>
								<div class="card-body">
									<div class="text-center"><img alt="회의실 사진" src="/resources/img/room1.jpg" width="80%"></div>
									<p>
									
									<div>위치 : 본사 2층</div>
									<div>수용 인원 : 20명</div>
									<div>비치 물품 : 빔프로젝터 노트북</div>
									<div>네트워크 : 사용 가능</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="zxc">
					<p>Curabitur dignissim quis nunc vitae laoreet. Etiam ut mattis
						leo, vel fermentum tellus. Sed sagittis rhoncus venenatis. Quisque
						commodo consectetur faucibus. Aenean eget ultricies justo.</p>
				</div>

			</div>
		</div>

		</div>
		<!-- /.container-fluid -->
	</div>
	</div>

</div>

<script type="text/javascript">
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