<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<!DOCTYPE html>
<html>

<script>
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');

		var calendar = new FullCalendar.Calendar(calendarEl, {
			plugins : [ 'interaction', 'dayGrid' ],
			defaultDate : '2019-04-12',
			editable : true,
			eventLimit : true, // allow "more" link when too many events
			events : [ {
				title : 'All Day Event',
				start : '2019-04-01'
			}, {
				title : 'Long Event',
				start : '2019-04-07',
				end : '2019-04-10'
			}, {
				groupId : 999,
				title : 'Repeating Event',
				start : '2019-04-09T16:00:00'
			}, {
				groupId : 999,
				title : 'Repeating Event',
				start : '2019-04-16T16:00:00'
			}, {
				title : 'Conference',
				start : '2019-04-11',
				end : '2019-04-13'
			}, {
				title : 'Meeting',
				start : '2019-04-12T10:30:00',
				end : '2019-04-12T12:30:00'
			}, {
				title : 'Lunch',
				start : '2019-04-12T12:00:00'
			}, {
				title : 'Meeting',
				start : '2019-04-12T14:30:00'
			}, {
				title : 'Happy Hour',
				start : '2019-04-12T17:30:00'
			}, {
				title : 'Dinner',
				start : '2019-04-12T20:00:00'
			}, {
				title : 'Birthday Party',
				start : '2019-04-13T07:00:00'
			}, {
				title : 'Click for Google',
				url : 'http://google.com/',
				start : '2019-04-28'
			} ]
		});

		calendar.render();
		calendar.setOption('locale', 'ko'); // 달력 한국어 설정
	});
</script>

<style>
#calendar {
	max-width: 1300px;
	margin: 0 auto;
	background-color: white;
}
</style>

<!-- Main Content -->
<div id="content">

	<!-- Begin Page Content -->
	<div class="container-fluid">

		<div class="row">

			<!-- Begin Page Content -->
			<div class="container-fluid">

				<!-- Page Heading -->
				<div
					class="d-sm-flex align-items-center justify-content-between mb-4">
					<h1 id="name" class="h5 mb-0 text-gray-800">
						<i class="fas fa-user"></i> 대시보드 > 재동 본사
					</h1>
				</div>

				<!-- Content Row -->
				<div class="row">

					<ul class="nav nav-tabs">
						<li class="nav-item"><a class="nav-link active" id="wp1"
							data-toggle="tab" href="#workplace1">재동 본사</a></li>
						<li class="nav-item"><a class="nav-link" id="wp2"
							data-toggle="tab" href="#workplace2">삼환빌딩</a></li>
						<li class="nav-item"><a class="nav-link" id="wp3"
							data-toggle="tab" href="#workplace3">GS 강남타워</a></li>
						<li class="nav-item"><a class="nav-link" id="wp4"
							data-toggle="tab" href="#workplace4">GS 강서타워</a></li>
					</ul>

					<div class="tab-content">
						<div id="calendar"></div>
					</div>
				</div>

			</div>
			<!-- /.container-fluid -->
		</div>
	</div>

</div>
<!-- End of Main Content -->


<script type="text/javascript">
	$(function() {
		$("#wp1").click(function() {
			$("#name").text(" 대시보드 > 재동 본사 ");
		});
		$("#wp2").click(function() {
			$("#name").text(" 대시보드 > 삼환빌딩 ");
		});
		$("#wp3").click(function() {
			$("#name").text(" 대시보드 > GS 강남타워 ");
		});
		$("#wp4").click(function() {
			$("#name").text(" 대시보드 > GS 강서타워 ");
		});
	});
</script>
</body>

</html>
