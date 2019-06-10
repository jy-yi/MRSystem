<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Main Content -->
<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<div class="d-sm-flex align-items-center justify-content-between mb-4">
		<h1 class="h5 mb-0 text-gray-800">
			<i class="fas fa-user"></i> 마이페이지 > 예약 통계
		</h1>
	</div>

	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">나의 예약 횟수 및 비용</h6>
		</div>
		<div class="card-body">
			
			<table class="table" border="2">
				<tr class="rHeader">
					<td colspan="2">개인</td>
					<td  colspan="2">부서</td>
				</tr>
				
				<tr>	
					<td>횟수</td>
					<td>비용</td>
					<td>횟수</td>
					<td>비용</td>
				</tr>
				
				<tr>
					<td>2</td>
					<td>50000</td>
					<td>25</td>
					<td>255,000</td>
				</tr>
				
			</table>
		</div>

	</div>
	
	<p class="mb-4">조회하고 싶은 날짜를 선택하세요.</p>

			<input type="text" name="datefilter" value="" style="width: 250px;"/>

			<script type="text/javascript">
				$(function() {

					$('input[name="datefilter"]').daterangepicker({
						autoUpdateInput : false,
						locale : {
							cancelLabel : 'Clear'
						}
					});

					$('input[name="datefilter"]').on(
							'apply.daterangepicker',
							function(ev, picker) {
								$(this).val(
										picker.startDate.format('YYYY/MM/DD')
												+ ' - '
												+ picker.endDate
														.format('YYYY/MM/DD'));
							});

					$('input[name="datefilter"]').on('cancel.daterangepicker',
							function(ev, picker) {
								$(this).val('');
							});

				});
			</script>
</div>




<!-- /.container-fluid -->

<div id="content">

	<!-- Content Row -->
	<div class="row2">

		<!-- Begin Page Content -->
		<div class="container-fluid">

			<!-- DataTales Example -->
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">나의 예약 통계 목록</h6>
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