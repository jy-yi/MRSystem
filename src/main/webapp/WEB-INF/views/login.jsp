<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>

<script>
$(function(){
	var status = getUrlParams();
	var result = status.result;
	if(result == "error") {
		swal({
            title: '',
            html: '사이트에 등록되지 않은 아이디이거나, <br/> 아이디 또는 비밀번호를 잘못 입력하셨습니다.',
            type: 'warning',
            confirmButtonText: 'OK'
          });
	}
	
});
function getUrlParams() {
    var params = {};
    window.location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, 
    		function(str, key, value) { params[key] = value; });
    return params;
}
</script>

<body class="bg-gradient-primary">

  <div class="container">

    <!-- Outer Row -->
    <div class="row justify-content-center">

      <div class="col-xl-10 col-lg-12 col-md-9">

        <div class="card o-hidden border-0 shadow-lg my-5">
          <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
              <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
              <div class="col-lg-6">
                <div class="p-5">
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">GS ITM 회의실 예약 시스템</h1>
                  </div>
                  <form class="user" action="/user/login" method="post">
                    <div class="form-group">
                      <input type="text" class="form-control form-control-user" id="employeeNo" name="employeeNo" placeholder="IT0000">
                    </div>
                    <div class="form-group">
                      <input type="password" class="form-control form-control-user" id="password" name="password" placeholder="Password">
                    </div>
                    <div class="form-group">
                      <div class="custom-control custom-checkbox small">
                        <input type="checkbox" class="custom-control-input" id="customCheck" name="useCookie">
                        <label class="custom-control-label" for="customCheck">Remember Me</label>
                      </div>
                    </div>
                     <hr>
                    <input type="submit" value="로그인" class="btn btn-primary btn-user btn-block">
                    <hr>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

    </div>

  </div>

</body>

</html>
