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
				<i class="fas fa-user"></i> 마이페이지 > 예약 현황
			</h1>
		</div>

		<!-- Content Row -->
		<div class="row">

			<!-- Earnings (Monthly) Card Example -->
			<div class="col-xl-12 col-md-12 mb-6">
				<div class="card border-left-info shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-xs font-weight-bold text-info text-uppercase mb-1">Tasks</div>
								<div class="row no-gutters align-items-center">
									<div class="col-auto">
										<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">50%</div>
									</div>
									<div class="col">
										<div class="progress progress-sm mr-2">
											<div class="progress-bar bg-info" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">
											</div>
										</div>
									</div>
								</div>
							</div>
							<a href="/reservation/statusCalendar" class="btn btn-primary btn-icon-split">
			                    <span class="text">달력형</span>
		                    </a>
						</div>
					</div>
				</div>
			</div>
		</div>

		<p>
		<p>

		<!-- Content Row -->
		<div class="row">

			<!-- Begin Page Content -->
			<div class="container-fluid">

				<!-- DataTales Example -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary">나의 예약 현황</h6>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-bordered" id="dataTable" width="100%"
								cellspacing="0">
								<thead>
									<tr>
										<th>No</th>
										<th>회의명</th>
										<th>회의 목적</th>
										<th>회의실</th>
										<th>기간</th>
										<th>주관부서</th>
										<th>승인 상태</th>
										<th>취소</th>
									</tr>
								</thead>

								<tbody>
									<tr>
										<td>1</td>
										<td>가</td>
										<td>Edinburgh</td>
										<td>61</td>
										<td>2011/04/25</td>
										<td>$320,800</td>
										<td> <span class="text-primary"> 완료 </span></td>
										<td><a href="#" class="btn btn-danger"> <span class="text">취소</span></a></td>
									</tr>
									<tr>
										<td>Garrett Winters</td>
										<td>1</td>
										<td>Tokyo</td>
										<td>63</td>
										<td>2011/07/25</td>
										<td>$170,750</td>
										<td> <span class="text-primary"> 완료 </span></td>
										<td><a href="#" class="btn btn-danger"> <span class="text">취소</span></a></td>
									</tr>
									<tr>
										<td>Ashton Cox</td>
										<td>나</td>
										<td>San Francisco</td>
										<td>66</td>
										<td>2009/01/12</td>
										<td>$86,000</td>
										<td> <span class="text-danger"> 반려 </span></td>
										<td><a href="#" class="text-gray-900"> 반려 사유 </a></td>
									</tr>
									<tr>
										<td>Cedric Kelly</td>
										<td>다</td>
										<td>Edinburgh</td>
										<td>22</td>
										<td>2012/03/29</td>
										<td>$433,060</td>
										<td> <span class="text-danger"> 반려 </span></td>
										<td><a href="#" class="text-gray-900"> 반려 사유 </a></td>
									</tr>
									<tr>
										<td>Airi Satou</td>
										<td>갸</td>
										<td>Tokyo</td>
										<td>33</td>
										<td>2008/11/28</td>
										<td>$162,700</td>
										<td> <span class="text-danger"> 반려 </span></td>
										<td><a href="#" class="text-gray-900"> 반려 사유 </a></td>
									</tr>
									<tr>
										<td>Brielle Williamson</td>
										<td>Integration Specialist</td>
										<td>New York</td>
										<td>61</td>
										<td>2012/12/02</td>
										<td>$372,000</td>
										<td> <span class="text-warning"> 대기 </span></td>
										<td><a href="#" class="btn btn-danger"> <span class="text">취소</span></a></td>
									</tr>
									<tr>
										<td>Herrod Chandler</td>
										<td>Sales Assistant</td>
										<td>San Francisco</td>
										<td>59</td>
										<td>2012/08/06</td>
										<td>$137,500</td>
										<td> <span class="text-warning"> 대기 </span></td>
										<td><a href="#" class="btn btn-danger"> <span class="text">취소</span></a></td>
									</tr>
									<tr>
										<td>Rhona Davidson</td>
										<td>Integration Specialist</td>
										<td>Tokyo</td>
										<td>55</td>
										<td>2010/10/14</td>
										<td>$327,900</td>
										<td> <span class="text-warning"> 대기 </span></td>
										<td><a href="#" class="btn btn-danger"> <span class="text">취소</span></a></td>
									</tr>
									<tr>
										<td>Colleen Hurst</td>
										<td>Javascript Developer</td>
										<td>San Francisco</td>
										<td>39</td>
										<td>2009/09/15</td>
										<td>$205,500</td>
										<td> <span class="text-primary"> 완료 </span></td>
										<td><a href="#" class="btn btn-danger"> <span class="text">취소</span></a></td>
									</tr>
									<tr>
										<td>Sonya Frost</td>
										<td>Software Engineer</td>
										<td>Edinburgh</td>
										<td>23</td>
										<td>2008/12/13</td>
										<td>$103,600</td>
										<td> <span class="text-primary"> 완료 </span></td>
										<td><a href="#" class="btn btn-danger"> <span class="text">취소</span></a></td>
									</tr>
									<tr>
										<td>Jena Gaines</td>
										<td>Office Manager</td>
										<td>London</td>
										<td>30</td>
										<td>2008/12/19</td>
										<td>$90,560</td>
										<td> <span class="text-danger"> 반려 </span></td>
										<td><a href="#" class="text-gray-900"> 반려 사유 </a></td>
									</tr>
									<tr>
										<td>Quinn Flynn</td>
										<td>Support Lead</td>
										<td>Edinburgh</td>
										<td>22</td>
										<td>2013/03/03</td>
										<td>$342,000</td>
										<td> <span class="text-danger"> 반려 </span></td>
										<td><a href="#" class="text-gray-900"> 반려 사유 </a></td>
									</tr>
									<tr>
										<td>Charde Marshall</td>
										<td>Regional Director</td>
										<td>San Francisco</td>
										<td>36</td>
										<td>2008/10/16</td>
										<td>$470,600</td>
										<td> <span class="text-warning"> 대기 </span></td>
										<td><a href="#" class="btn btn-danger"> <span class="text">취소</span></a></td>
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


</body>

</html>