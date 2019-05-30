<%@ page contentType="text/html; charset=UTF-8"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.15/css/bootstrap-multiselect.css" type="text/css">
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.15/js/bootstrap-multiselect.min.js"></script>

<!-- Add Equipment Modal-->
<div class="modal fade" id="addEquipModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">비품 추가</h5>
				<button type="button" class="close" data-dismiss="modal"> &times;</button>
			</div>
			
			<form action="#" method="post">
				<div class="modal-body">
					
					<div class="form-group">
						<div class="row">
							<div class="col-xs-2 col-sm-2 text-center">
								<label> 비품명 </label>
							</div>
							<div class="col-xs-9 col-sm-9">
								<input type="text" class="form-control" id="name" name="name" placeholder="비품 이름을 입력하세요" />
							</div>
						
							<div class="clearfix"></div>
						</div>
						
						<br>
						
						<div class="row">
							<div class="col-xs-2 col-sm-2 text-center">
								<label> 구매일 </label>
							</div>
							<div class="col-xs-9 col-sm-9">
				                <div class="input-group input-append date" id="datePicker">
				                    <input type="date" class="form-control" name="buyDate" />
				                    <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
							</div>
						
							<div class="clearfix"></div>
						</div>
						
						<br>
						
						<div class="row">
							<div class="col-xs-2 col-sm-2 text-center">
								<label> 비치장소 </label>
							</div>
							<div class="col-xs-9 col-sm-9">
								<select id="option-droup-demo" multiple="multiple" class="form-control">
							        <optgroup label="본사">
							            <option value="jQuery">몰디브</option>
							            <option value="Bootstrap">하와이</option>
							            <option value="HTML">교육실</option>
							        </optgroup>
							        <optgroup label="삼환빌딩">
							            <option value="Java">회의실1</option>
							            <option value="csharp">회의실2</option>
							            <option value="Python">회의실3</option>
							        </optgroup>
							        <optgroup label="GS 칼텍스">
							            <option value="MySQL">회의실A</option>
							            <option value="Oracle">회의실B</option>
							            <option value="MSSQL">회의실C</option>
							        </optgroup>        
							    </select>
							</div>
						
							<div class="clearfix"></div>
						</div>
					</div>
				</div>
			</form>
			
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
				<a class="btn btn-primary" href="#">추가</a>
			</div>
		</div>
	</div>
</div>

<script>
	$(function() {
	    $('#datePicker').datepicker({
            format: 'yyyy-mm-dd'
        });
	    
	    $('#option-droup-demo').multiselect({buttonWidth: '340px'});
	});
	
	/* 모달 사라졌을 때 입력 값 초기화 */
	$('.modal').on('hidden.bs.modal', function (e) {
	  $(this).find('form')[0].reset()
	});
	
</script>