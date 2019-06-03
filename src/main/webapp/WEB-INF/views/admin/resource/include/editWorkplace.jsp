<%@ page contentType="text/html; charset=UTF-8"%>

<!-- 다음 우편번호 API -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<!-- Add Work place Modal-->
<div class="modal fade" id="editWorkplaceModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">지사 수정</h5>
				<button type="button" class="close" data-dismiss="modal"> &times;</button>
			</div>
			
			<form action="/resource/editWorkplace" method="post">
				<div class="modal-body">
					
					<div class="form-group">
						<div class="row">
							<div class="col-xs-2 col-sm-2 text-center">
								<label> 이름</label>
							</div>
							<div class="col-xs-9 col-sm-9">
								<input type="text" class="form-control" id="editName" name="name" placeholder="지사 이름을 입력하세요" required="required" />
							</div>
						
							<div class="clearfix"></div>
						</div>
						
						<br>
						
						<div class="row">
							<div class="col-xs-2 col-sm-2 text-center">
								<label>위치</label>
							</div>
							<div class="col-xs-7 col-sm-7">
								<input type="text" class="form-control" id="editAddress" name="address" placeholder="위치를 입력하세요" required="required" />
							</div>
							
							<div class="col-xs-2 col-sm-2">
								<a class="btn btn-warning" id="locationBtn" href="#">검색</a>
							</div>
							
							<input type="hidden" id="editWorkplaceNo" name="workplaceNo" />
							
							<div class="clearfix"></div>
						</div>
					</div>
				</div>
				
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
					<input type="submit" class="btn btn-primary" value="수정">
				</div>
			</form>
		</div>
	</div>
</div>

<script>
	$("#locationBtn, #editAddress").click(function() {
		new daum.Postcode({
            oncomplete: function(data) {
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 주소 정보를 해당 필드에 넣는다.
                $("#editAddress").val(addr);
            }
        }).open();
	});
	
	/* 모달 사라졌을 때 입력 값 초기화 */
	$('.modal').on('hidden.bs.modal', function (e) {
	  $(this).find('form')[0].reset()
	});

	var workplaceNo="";
	var workplaceName="";
    var workplaceAddress="";
	
	$(function() {     
        $('#editWorkplaceModal').on('show.bs.modal', function(event) {          
        	workplaceNo = $(event.relatedTarget).data('workplaceno');
        	workplaceName = $(event.relatedTarget).data('workplacename');
        	workplaceAddress = $(event.relatedTarget).data('workplaceaddress');
        	
        	 $("#editWorkplaceNo").val(workplaceNo);
        	 $("#editName").val(workplaceName);
    	     $("#editAddress").val(workplaceAddress);
        });
    });
	
</script>