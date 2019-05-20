<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
				<i class="fas fa-user"></i> 지사/회의실 관리 > 회의실 관리
			</h1>
		</div>

		<div class="row">
			<div class="card-body py-2 text-right">
				<span class="pull-right text-lg"> 본사 </span>

			</div>
		</div>

		<!-- Content Row -->
		<div class="row">

			<ul class="nav nav-tabs">
				<li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#qwe">본사</a></li>
				<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#asd">삼환빌딩</a></li>
				<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#zxc">GS 강남타워</a></li>
				<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#zxc">GS 강서타워</a></li>
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
				<div class="tab-pane fade show active" id="qwe">

					<div class="row">
						<div class="col-xl-4 col-md-4 mb-4">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-primary">Basic Card Example</h6>
								</div>
								<div class="card-body">The styling for this basic card
									example is created by using default Bootstrap utility classes.
									By using utility classes, the style of the card component can
									be easily modified with no need for any custom CSS!</div>
							</div>
						</div>
						<div class="col-xl-4 col-md-4 mb-4">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-primary">Basic Card Example</h6>
								</div>
								<div class="card-body">The styling for this basic card
									example is created by using default Bootstrap utility classes.
									By using utility classes, the style of the card component can
									be easily modified with no need for any custom CSS!</div>
							</div>
						</div>
						<div class="col-xl-4 col-md-4 mb-4">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-primary">Basic Card Example</h6>
								</div>
								<div class="card-body">The styling for this basic card
									example is created by using default Bootstrap utility classes.
									By using utility classes, the style of the card component can
									be easily modified with no need for any custom CSS!</div>
							</div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="asd">
					<p>Nunc vitae turpis id nibh sodales commodo et non augue.
						Proin fringilla ex nunc. Integer tincidunt risus ut facilisis
						tristique.</p>
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
<!-- End of Main Content -->


<!-- Modal -->
<jsp:include page="include/addRoom.jsp" />


<script type="text/javascript">
	// 	$(function() {
	// 		swal('Good job!', 'You clicked the button!', 'success')
	// 	});
</script>
</body>

</html>
