<%@ page contentType="text/html; charset=UTF-8"%>
<style>
	.modal-header{
		display: inline-block;
	}

	.modal-footer{
		text-align: center !important;
	}

	#ganada-list-div{
	    overflow: scroll;
    	height: 300px;
    	overflow-x: hidden;
	}
	
	#ganada-list-div:hover{
		cursor: pointer;
	}
	
	#ganada-list-div>ul>li{
		list-style: none;
		line-height: 2;
	}

	.padding-left-12{
		padding-left: 12px;
	}
	
	#particaption-list-div{
		color: #464646;
	}
	
	#custom-search-input{
		margin-top: 20px;
	}
	
	
</style>

<!-- Add Work place Modal-->
<div class="modal fade" id="chooseParticipationModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			
			<div class="modal-body">
				<div class="row">
					<div class="col-md-2" id="ganada-list-div">
						<ul id="ganada-list">
							<li>ㄱ</li>
							<li>ㄴ</li>
							<li>ㄷ</li>
							<li>ㄹ</li>
							<li>ㅁ</li>
							<li>ㅂ</li>
							<li>ㅅ</li>
							<li>ㅇ</li>
							<li>ㅈ</li>
							<li>ㅊ</li>
							<li>ㅋ</li>
							<li>ㅌ</li>
							<li>ㅍ</li>
							<li>ㅎ</li>
						</ul>
					</div>
			        <div class="col-md-10">
			        	<div id="particaption-list-div" class="padding-left-12">
			        		<span>참여인원 : </span>
			    			<span id="participationList">참여인원목록</span>
			        	</div>
			            <div id="custom-search-input">
			                <div class="input-group col-md-12">
			                    <input type="text" class="form-control input-lg" placeholder="성명을 입력하세요." />
			                    <span class="input-group-btn">
			                        <button class="btn btn-info btn-lg" type="button">
			                            <i class="glyphicon glyphicon-search"></i>
			                        </button>
			                    </span>
			                </div>
			            </div>
			        </div>
			      </div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-secondary btn-md" id="choose-complete-btn" type="button" data-dismiss="modal" disabled>확인</button>
			</div>
		</div>
	</div>
</div>
