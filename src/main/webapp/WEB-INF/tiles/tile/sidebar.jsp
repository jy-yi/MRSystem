<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
$(function(){
	
	var url = $(location).attr('pathname');
	
	var pageSubmitFn = function(url) {
		
		if (url == '/reservation/statusList')
			url = '/reservation/statusCalendar';	// 예약 현황 - 달력형, 리스트형
		
		var aTag = $('a[href="'+url+'"]');
		if(aTag.hasClass('low-menu')) {
			$(".low-menu").removeClass("active"); 
			$('a[href="'+url+'"]').addClass("active");
			
			$('.menu').removeClass("active").addClass("collapsed");
			$('a[href="'+url+'"]').parent().parent().parent().addClass("active").removeClass("collapsed");
			$('a[href="'+url+'"]').parent().parent().prev().removeClass("collapsed");
			
			$('.collapse').removeClass("show");
			$('a[href="'+url+'"]').parent().parent().addClass("show");
		} else if(aTag.hasClass('nav-link')) {
			// 하나짜리
			aTag.parent().addClass('active');
		}
	}
	
	pageSubmitFn(url);
});
 	
</script>

<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

	<!-- Sidebar - Brand -->
	<a class="sidebar-brand d-flex align-items-center justify-content-center" href="/reservation/statusCalendar">
		<div class="sidebar-brand-icon rotate-n-15">
			<i class="fas fa-laugh-wink"></i>
		</div> 
		<div class="sidebar-brand-text mx-3">GS ITM</div>
	</a>

	<c:choose>
		<c:when test="${empty adminId}">
			<!-- Divider -->
			<hr class="sidebar-divider">
		
			<!-- Heading -->
			<div class="sidebar-heading">User</div>
		
			<!-- Nav Item - My Page -->
			<li id="mypage" class="menu nav-item">
				<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseMyPage" aria-expanded="true" aria-controls="collapseMyPage"> 
					<i class="fas fa-user"></i> <span>마이 페이지</span>
				</a>
				
				<div id="collapseMyPage" class="collapse" aria-labelledby="collapseMyPage" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<a id="statusCalendar" class="collapse-item low-menu" href="/reservation/statusCalendar">예약 현황</a> 
						<a id="userStatistic" class="collapse-item low-menu" href="/statistic/mypage">예약 통계</a>
					</div>
				</div>
			</li>
		
			<li class="nav-item">
				<a class="nav-link" href="/reservation/dashboard">
					<i class="fas fa-tachometer-alt"></i>
					<span>대시보드</span>
				</a>
			</li>
		
			<li class="nav-item">
				<a class="nav-link" href="/reservation/room">
					<i class="far fa-calendar-check"></i>
					<span>회의실 예약</span>
				</a>
			</li>
			
		
			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">
		</c:when>
		<c:otherwise>
			
			<hr class="sidebar-divider d-none d-md-block">
		
			<!-- Heading -->
			<div class="sidebar-heading">Administrator </div>
			
			<li class="nav-item">
				<a class="nav-link" href="/reservation/dashboard">
					<i class="far fa-calendar-alt"></i>
					<span>예약 현황</span>
				</a>
			</li>
		
			<!-- Nav Item - My Page -->
			<li id="adminReservation" class="menu nav-item">
				<a class="nav-link collapsed" href="/" data-toggle="collapse" data-target="#collapseAdmin" aria-expanded="true" aria-controls="collapseAdmin"> 
					<i class="fas fa-cogs"></i> <span>예약 관리</span>
				</a>
				
				<div id="collapseAdmin" class="collapse" aria-labelledby="collapseAdmin" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<a class="collapse-item low-menu" href="/reservation/approvalWaitingList">승인 대기 목록</a> 
						<a class="collapse-item low-menu" href="/reservation/approvalCancelList">승인 반려 목록</a> 
						<a class="collapse-item low-menu" href="/reservation/reservationSuccessList">예약 완료 목록</a> 
						<a class="collapse-item low-menu" href="/reservation/reservationCancelList">예약 취소 목록</a>
					</div>
				</div>
			</li>
		
			<!-- Nav Item - Pages Collapse Menu -->
			<li id="resource" class="menu nav-item">
			<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseResource" aria-expanded="true" aria-controls="collapseResource"> 
				<i class="fas fa-building"></i> <span>지사/회의실 관리</span>
			</a>
			
				<div id="collapseResource" class="collapse" aria-labelledby="collapseResource" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<a class="collapse-item low-menu" href="/resource/workplaceList">지사 관리</a> 
						<a class="collapse-item low-menu" href="/resource/roomList"">회의실 관리</a> 
						<a class="collapse-item low-menu" href="/resource/equipmentList">비품 관리</a>
					</div>
				</div>
			</li>
			
			<li class="nav-item">
				<a class="nav-link" href="/statistic/statistic">
					<i class="far fa-chart-bar"></i>
					<span>통계 관리</span>
				</a>
			</li>
		
			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">
		</c:otherwise>
	</c:choose>

      <!-- Sidebar Toggler (Sidebar) -->
      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>

</ul>
<!-- End of Sidebar -->
