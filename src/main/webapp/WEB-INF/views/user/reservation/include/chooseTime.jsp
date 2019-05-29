<%@ page contentType="text/html; charset=UTF-8"%>
<style>
	#time-label{
		color: #464646;	
	}
	
	#reservation-info{
		margin: 7px 0 0 10px;
	    font-size: 15px;
	}
	
	#choose-complete-btn{
	    background-color: rgb(54,93,205);
	    color: white;
	    display: inline;
	    width: 50%;
	}
	
	.modal-footer{
		display: inline;
	    text-align: center;
	 }
	 
	 #amTimeScheduleList > li{
	 	display: inline;
	 	margin: 10px;
	 }
	 
	 #pmTimeScheduleList > li{
	 	display: inline;
	 	margin: 10px;
	 }
	
	 .can-reserve-time{
	 	width: 70px; 
	    height: 40px;	    
   		padding-top: 8px;
	    margin-top: 20px;
	    background-color: rgb(221,227,247);
	    color: white;
	    display: inline-block;
	    text-align: center;
	    border: 1px solid darkgray;
	 }
	 
	 #amTimeScheduleList span:hover, #pmTimeScheduleList span:hover{
	 	cursor: pointer;
	 }
	 
	 #amTimeSchedule>span, #pmTimeSchedule>span{
	 	padding-left: 59px;
	 	color: gray;
	 }
	 
	 #amTimeScheduleList, #pmTimeScheduleList{
	 	margin: 0;
	 	padding-left: 50px;
	 }
	 
	 #pmTimeSchedule{
	 	margin-top: 20px;
	 }
	 
	 .modal-body{
	 	margin-bottom: 15px;
	 }
	 
	 .modal{
	 	text-align: center;
	 }
	 
	 @media screen and (min-width: 768px) { 
        .modal:before {
                display: inline-block;
                vertical-align: middle;
                content: " ";
                height: 100%;
        }
	}
	 
	.modal-dialog {
	        display: inline-block;
	        text-align: left;
	        vertical-align: middle;
	}
</style>

<!-- Add Work place Modal-->
<div class="modal fade" id="chooseTimeModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="time-label"> 4. 18. (목), 시간을 선택하세요.</h5>
				<p id="reservation-info">30분 단위 예약가능 </p>
				<button type="button" class="close" data-dismiss="modal"> &times;</button>
			</div>
			<div class="modal-body">
		        <div id="amTimeSchedule">
		        	<span>오전</span>
		        	<ul id="amTimeScheduleList">
		        		<li><span class="can-reserve-time">9:00</span></li>
		        		<li><span class="can-reserve-time">9:30</span></li>
		        		<li><span class="can-reserve-time">10:00</span></li>
		        		<li><span class="can-reserve-time">10:30</span></li>
		        		<li><span class="can-reserve-time">11:00</span></li>
		        		<li><span class="can-reserve-time">11:30</span></li>
		        	</ul>
		        </div>
		        <div id="pmTimeSchedule">
		        	<span>오후</span>
		        	<ul id="pmTimeScheduleList">
		        		<li><span class="can-reserve-time">12:00</span></li>
		        		<li><span class="can-reserve-time">12:30</span></li>
		        		<li><span class="can-reserve-time">13:00</span></li>
		        		<li><span class="can-reserve-time">13:30</span></li>
		        		<li><span class="can-reserve-time">14:00</span></li>
		        		<li><span class="can-reserve-time">14:30</span></li>
		        		<li><span class="can-reserve-time">15:00</span></li>
		        		<li><span class="can-reserve-time">15:30</span></li>
		        		<li><span class="can-reserve-time">16:00</span></li>
		        		<li><span class="can-reserve-time">16:30</span></li>
		        		<li><span class="can-reserve-time">17:00</span></li>
		        		<li><span class="can-reserve-time">17:30</span></li>
		        		<li><span class="can-reserve-time">18:00</span></li>
		        	</ul>
		        </div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-secondary btn-md" id="choose-complete-btn" type="button" data-dismiss="modal" disabled>예약시간 선택</button>
			</div>
		</div>
	</div>
</div>
