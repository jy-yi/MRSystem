<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>GS ITM 회의실 예약 시스템</title>


<style type="text/css">
/* 로딩 */
#Progress_Loading
{
   position: fixed;
    left: 0;
    top: 0;
    background: #00000099;
    width: 100%;
    height: 100%;
    z-index: 1001;
}
#Progress_Loading > img {
    position: fixed;
    left: 45%;
    top: 40%;
	width: 200px;
}

@media (max-width: 768px) {
	#Progress_Loading > img {
        left: 37%;
	    top: 39%;
	    width: 223px;
	}
}
@media (max-width: 415px) {
	#Progress_Loading > img {
        left: 30%;
	    top: 40%;
	    width: 168px;
	}
}

@media (max-width: 360px) {
	#Progress_Loading > img {
        left: 30%;
	    top: 40%;
	    width: 140px
	}
}

</style>

<!-- 파비콘 설정 -->
<link rel="shortcut icon" href="/resources/img/calendar.ico">

<!-- Custom fonts for this template-->
<link href="/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="/resources/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom styles for table page -->
<link href="/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

<!-- Icon -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.8.1/css/all.css"
	integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf"
	crossorigin="anonymous">
	
<!-- Bootstrap core JavaScript-->
<script src="/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Page table plugins -->
<script src="/resources/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

<!-- Page level plugins -->
<script src="/resources/vendor/chart.js/Chart.min.js"></script>

<!-- Page table custom scripts -->
<script src="/resources/js/demo/datatables-demo.js"></script>

<!-- SweetAlert JavaScript -->
<script src="/resources/js/sweetalert2.min.js"></script>
<script src="/resources/js/sweetalert2.all.js"></script>
<script src="/resources/js/sweetalert2.all.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/promise-polyfill"></script>

<!-- Calendar -->
<link href='/resources/packages/core/main.css' rel='stylesheet' />
<link href='/resources/packages/daygrid/main.css' rel='stylesheet' />
<script src='/resources/packages/core/main.js'></script>
<script src='/resources/packages/interaction/main.js'></script>
<script src='/resources/packages/daygrid/main.js'></script>
<script src='/resources/packages/core/locales-all.js'></script>

<!-- Date Picker -->
<link rel="stylesheet" type="text/css" href="/resources/css/datepicker3.css" />
<script type="text/javascript" src="/resources/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap-datepicker.kr.js"></script>

<!-- Date Range Picker -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

<style type="text/css">
@font-face {
	font-family: "setFont";
	src: url("/resources/fonts/A타이틀고딕2.TTF") format("truetype");
}

body, div, h1, h2, h3, h4, h5, h6 {
	font-family: setFont;
}
</style>

</head>

<body id="page-top">

	<div id="wrapper">

		<tiles:insertAttribute name="sidebar" />

		<div id="content-wrapper">
			<tiles:insertAttribute name="header" />
			<tiles:insertAttribute name="content" />
			<tiles:insertAttribute name="footer" />
		</div>
	</div>
	
	<!-- 로딩바 -->
   <div id="Progress_Loading">
		<img src="/resources/img/loading.gif"/>
   </div>

</body>

<!-- Custom scripts for all pages-->
<script src="/resources/js/sb-admin-2.min.js"></script>
<!-- 로딩 -->
<script>
$(document).ready(function(){
   $('#Progress_Loading').hide(); //첫 시작시 로딩바를 숨겨준다.
})
.ajaxStart(function(){
   $('#Progress_Loading').show(); //ajax 실행 시 로딩바를 보여준다.
})
.ajaxStop(function(){
   $('#Progress_Loading').hide(); //ajax 종료 시 로딩바를 숨겨준다.
});
</script>

</html>