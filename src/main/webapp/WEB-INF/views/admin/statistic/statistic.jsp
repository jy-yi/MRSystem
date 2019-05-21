<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<!DOCTYPE html>
<html>

<!-- Main Content -->
<div class="container-fluid">

	<div id="content">

		<!-- Page Heading -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h1 class="h5 mb-0 text-gray-800">
				<i class="fas fa-user"></i> 관리자 > 예약 통계
			</h1>
		</div>

		<!-- Content Row -->
		<div class="row">

			<!-- Begin Page Content -->
			<div class="container-fluid">

				<!-- DataTales Example -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary">전체 예약 현황</h6>
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
										<td>$320,800</td>
										<td>$320,800</td>
									</tr>
									<tr>
										<td>Garrett Winters</td>
										<td>1</td>
										<td>Tokyo</td>
										<td>63</td>
										<td>2011/07/25</td>
										<td>$170,750</td>
										<td>$170,750</td>
										<td>$170,750</td>
									</tr>
									<tr>
										<td>Ashton Cox</td>
										<td>나</td>
										<td>San Francisco</td>
										<td>66</td>
										<td>2009/01/12</td>
										<td>$86,000</td>
										<td>$86,000</td>
										<td>$86,000</td>
									</tr>
									<tr>
										<td>Cedric Kelly</td>
										<td>다</td>
										<td>Edinburgh</td>
										<td>22</td>
										<td>2012/03/29</td>
										<td>$433,060</td>
										<td>$433,060</td>
										<td>$433,060</td>
									</tr>
									<tr>
										<td>Airi Satou</td>
										<td>갸</td>
										<td>Tokyo</td>
										<td>33</td>
										<td>2008/11/28</td>
										<td>$162,700</td>
										<td>$162,700</td>
										<td>$162,700</td>
									</tr>
									<tr>
										<td>Brielle Williamson</td>
										<td>Integration Specialist</td>
										<td>New York</td>
										<td>61</td>
										<td>2012/12/02</td>
										<td>$372,000</td>
										<td>$372,000</td>
										<td>$372,000</td>
									</tr>
									<tr>
										<td>Herrod Chandler</td>
										<td>Sales Assistant</td>
										<td>San Francisco</td>
										<td>59</td>
										<td>2012/08/06</td>
										<td>$137,500</td>
										<td>$137,500</td>
										<td>$137,500</td>
									</tr>
									<tr>
										<td>Rhona Davidson</td>
										<td>Integration Specialist</td>
										<td>Tokyo</td>
										<td>55</td>
										<td>2010/10/14</td>
										<td>$327,900</td>
										<td>$327,900</td>
										<td>$327,900</td>
									</tr>
									<tr>
										<td>Colleen Hurst</td>
										<td>Javascript Developer</td>
										<td>San Francisco</td>
										<td>39</td>
										<td>2009/09/15</td>
										<td>$205,500</td>
										<td>$205,500</td>
										<td>$205,500</td>
									</tr>
									<tr>
										<td>Sonya Frost</td>
										<td>Software Engineer</td>
										<td>Edinburgh</td>
										<td>23</td>
										<td>2008/12/13</td>
										<td>$103,600</td>
										<td>$103,600</td>
										<td>$103,600</td>
									</tr>
									<tr>
										<td>Jena Gaines</td>
										<td>Office Manager</td>
										<td>London</td>
										<td>30</td>
										<td>2008/12/19</td>
										<td>$90,560</td>
										<td>$90,560</td>
										<td>$90,560</td>
									</tr>
									<tr>
										<td>Quinn Flynn</td>
										<td>Support Lead</td>
										<td>Edinburgh</td>
										<td>22</td>
										<td>2013/03/03</td>
										<td>$342,000</td>
										<td>$342,000</td>
										<td>$342,000</td>
									</tr>
									<tr>
										<td>Charde Marshall</td>
										<td>Regional Director</td>
										<td>San Francisco</td>
										<td>36</td>
										<td>2008/10/16</td>
										<td>$470,600</td>
										<td>$470,600</td>
										<td>$470,600</td>
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

	<!-- Begin Page Content -->
	<div class="container-fluid">

		<!-- Page Heading -->
		<h1 class="h3 mb-2 text-gray-800">Charts</h1>
		<p class="mb-4">관리자 통계 페이지의 차트 그래프입니다.</p>

		<!-- Content Row -->
		<div class="row">

			<div class="col-xl-8 col-lg-7">

				<!-- Bar Chart -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary">Bar Chart</h6>
					</div>
					<canvas id="myChart" width="400" height="200"></canvas>
					<script>
						var ctx = document.getElementById('myChart')
								.getContext('2d');
						var myChart = new Chart(ctx, {
							type : 'bar',
							data : {
								labels : [ 'January', 'February', 'March',
										'April', 'May', 'June', 'August',
										'Setember', 'October', 'November',
										'December' ],
								datasets : [ {
									label : '# of Counts',
									data : [ 12, 19, 3, 5, 2, 3, 7, 5, 1, 8,
											10, 11 ],
									backgroundColor : [
											'rgba(54, 162, 235, 0.2)',
											'rgba(54, 162, 235, 0.2)',
											'rgba(54, 162, 235, 0.2)',
											'rgba(54, 162, 235, 0.2)',
											'rgba(54, 162, 235, 0.2)',
											'rgba(54, 162, 235, 0.2)',
											'rgba(54, 162, 235, 0.2)',
											'rgba(54, 162, 235, 0.2)',
											'rgba(54, 162, 235, 0.2)',
											'rgba(54, 162, 235, 0.2)',
											'rgba(54, 162, 235, 0.2)',
											'rgba(54, 162, 235, 0.2)' ],
									borderColor : [ 'rgba(54, 162, 235, 1)',
											'rgba(54, 162, 235, 1)',
											'rgba(54, 162, 235, 1)',
											'rgba(54, 162, 235, 1)',
											'rgba(54, 162, 235, 1)',
											'rgba(54, 162, 235, 1)',
											'rgba(54, 162, 235, 1)',
											'rgba(54, 162, 235, 1)',
											'rgba(54, 162, 235, 1)',
											'rgba(54, 162, 235, 1)',
											'rgba(54, 162, 235, 1)',
											'rgba(54, 162, 235, 1)' ],
									borderWidth : 2
								} ]
							},
							options : {
								scales : {
									yAxes : [ {
										ticks : {
											beginAtZero : true
										}
									} ]
								}
							}
						});
					</script>
				</div>
				<!-- End of Bar Chart -->
				<hr>
			</div>
			<!-- div class = col-xl ... -->
			
			
			<div id="selectDept">
				<p class="mb-4">조회하고 싶은 부서를 선택하세요.</p>
				<select name="dataTable_length" aria-controls="dataTable"
					class="custom-select custom-select-sm form-control form-control-sm">
					<option value="">부서를 선택하세요.</option>
					<option value="">인사지원팀</option>
					<option value="">기획팀</option>
					<option value="">인프라총괄본부</option>
					<option value="">A&I 사업부</option>
					<option value="">SI 사업부</option>
				</select>
			</div>
			
		</div>

	</div>

	<!-- /.container-fluid -->


	<!-- End of Main Content -->
</html>
