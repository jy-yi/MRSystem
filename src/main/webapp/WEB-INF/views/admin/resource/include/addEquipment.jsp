<%@ page contentType="text/html; charset=UTF-8"%>


<!-- Add Work place Modal-->
<div class="modal fade" id="addStuffModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">비품 추가</h5>
				<button type="button" class="close" data-dismiss="modal"> &times;</button>
			</div>
			
			<div class="modal-body">
				
				<div class="form-group">
					<div class="row">
						<div class="col-xs-2 col-sm-2 text-center">
							<label> 비품명 </label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="text" class="form-control" id="nameForId" name="name" placeholder="비품 이름을 입력하세요" />
						</div>
					
						<div class="clearfix"></div>
					</div>
					
					<br>
					
					<div class="row">
						<div class="col-xs-2 col-sm-2 text-center">
							<label> 구매일 </label>
						</div>
						<div class="col-xs-9 col-sm-9">
							<input type="date" class="form-control" id="nameForId" name="name" placeholder="위치를 입력하세요" />
						</div>
					
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
			
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
				<a class="btn btn-primary" href="#">추가</a>
			</div>
		</div>
	</div>
</div>

<script>
	/* 모달 사라졌을 때 입력 값 초기화 */
	$('.modal').on('hidden.bs.modal', function (e) {
	  $(this).find('form')[0].reset()
	});
</script>