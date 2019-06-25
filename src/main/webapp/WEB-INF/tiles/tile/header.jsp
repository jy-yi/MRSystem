<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="m" uri="urlDecode"%> 

<body>
	<!-- Topbar -->
	<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

		<!-- Sidebar Toggle (Topbar) 화면 크기 줄었을 때, 〓 버튼 -->
		<button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
			<i class="fa fa-bars"></i>
		</button>

		<!-- Topbar Navbar -->
		<ul class="navbar-nav ml-auto">

			<div class="topbar-divider d-none d-sm-block"></div>

			<!-- Nav Item - User Information -->
			<li class="nav-item dropdown no-arrow">
				<a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
					<span class="mr-2 d-none d-lg-inline text-gray-600 small"> ${login.name} (${login.employeeNo}) </span> 
					<img class="img-profile rounded-circle" src="/resources/img/profile.png">
				</a> 
				
				<!-- Dropdown - User Information -->
				<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
					<a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal"> 
						<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i> 로그아웃
					</a>
				</div>
			</li>

		</ul>

		<!-- Scroll to Top Button-->
		<a class="scroll-to-top rounded" href="#page-top"> 
			<i class="fas fa-angle-up"></i>
		</a>

		<!-- Logout Modal-->
		<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel"> 로그아웃 하시겠습니까? </h5>
						<button class="close" type="button" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true"> &times; </span>
						</button>
					</div>
					<div class="modal-body"> 회의실 예약 관리 시스템을 종료하려면, <br> 아래에서 "로그아웃"  버튼을 클릭하세요. </div>
					<div class="modal-footer">
						<button class="btn btn-secondary" type="button" data-dismiss="modal"> 취소 </button>
						<a class="btn btn-primary" href="/user/logout"> 로그아웃 </a>
					</div>
				</div>
			</div>
		</div>
	</nav>
	<!-- End of Topbar -->
</body>
