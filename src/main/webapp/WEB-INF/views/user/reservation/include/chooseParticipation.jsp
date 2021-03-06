<%@ page contentType="text/html; charset=UTF-8"%>
<link rel="stylesheet" href="/resources/css/style.css">
<style>
	.modal-header{
		display: inline-block;
	}

	.modal-footer{
		text-align: center !important;
	}
	
	#ganada-list {
		list-style: none;
		line-height: 2;
	}

	#ganada-list-div:hover{
		cursor: pointer;
	}

	#particaption-list-div{
		color: #464646;
	}
	
	#custom-search-input{
		margin-top: 3%;
	}
	
	#search-employee-list>ul{
		margin-top: 20px;
	    line-height: 2;
	    list-style: inside;
	}
	
	#search-employee-list>ul>li:hover {
		cursor: pointer;
	}
	
	.delete-participation-btn{
		padding: 0;
	}
	
	.participation-list{
		list-style: none;
		line-height: 2;
    	overflow-x: hidden;
	    display: inline-block;
	    width: 100%;
	    padding: 0;
	}
	
	.participation-list::before{
		margin-right: 7px;
    	content: "참여인원 : ";
	}
	
	.participation-list>li{
		margin-right: 5px;
	}
	
	#searchBtn:hover {
		cursor: pointer;
	}
}
	
</style>

<!-- 회의 참여 인원 검색 모달 -->
<div class="modal fade" id="chooseParticipationModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			
			<div class="modal-body">
				<form>
					<div class="row">
						<div class="col-md-2" id="ganada-list-div">
							<div class="scrollbar" id="style-7">
						      <div class="force-overflow">
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
						    </div>
						</div>
				        <div class="col-md-7">
				        	
				            <div id="custom-search-input">
					            <div class="input-group md-form form-sm form-2 pl-0">
									<input type="text" id="searchByName" class="form-control input-lg my-0 py-1" placeholder="성명을 입력하세요." />
									<div class="input-group-append">
										<span class="input-group-text lighten-2" id="searchBtn">
											<i class="fas fa-search" aria-hidden="true"></i>
										</span>
									</div>
								</div>
				                <div id="search-employee-list">
				                	<ul></ul>
				                </div>
				            </div>
				        </div>
				        <div class="col-md-3" id="particaption-list-div">
				        	<div class="scrollbar2" id="style-7">
						      <div class="force-overflow">
					      		<ul class="participation-list"></ul>
						      </div>
						    </div>
						</div>
				      </div>
			      </form>
			</div>
			<div class="modal-footer">
				<button class="btn btn-md" id="choose-complete-btn" type="button" data-dismiss="modal" disabled="disabled">확인</button>
			</div>
		</div>
	</div>
</div>

<script>
/* 모달 사라졌을 때 입력 값 초기화 */
$('.modal').on('hidden.bs.modal', function (e) {
  $(this).find('form')[0].reset();
});
</script>