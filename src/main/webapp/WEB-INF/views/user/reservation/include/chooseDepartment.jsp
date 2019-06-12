<%@ page contentType="text/html; charset=UTF-8"%>
<style>
	#MainDept-list::before{
		margin-right: 7px;
    	content: "주관부서 : ";
	}
	
	#MainDept-list{
		list-style: none;
	    display: flex;
	    padding: 0;
	}
	
	#participation-list::before{
		margin-right: 7px;
    	content: "참여인원 : ";
	}
	
	#MainDept-list>li{
		margin-right: 5px;
	}
	
	#department-list>ul>li:hover{
		cursor: pointer;
	}
	
	.delete-department-btn{
		padding: 0;
	}
</style>

<!-- Add Work place Modal-->
<div class="modal fade" id="chooseDeptModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-body">
				<ul id="MainDept-list"></ul>
			    <div id="department-list">
			    	<ul></ul>
			    </div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-md" id="dept-choose-complete-btn" type="button" data-dismiss="modal" disabled="disabled">확인</button>
				<button class="btn btn-md btn-danger" id="choose-cancel-btn" type="button" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>
