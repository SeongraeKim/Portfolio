<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<!-- Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>




</head>
<body>

<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
  Launch demo modal
</button>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

	<!-- <!--Modal: Login / Register Form-->
	<div class="modal fade" id="modalLRForm" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog cascading-modal" role="document">
			Content
			<div class="modal-content">

				Modal cascading tabs
				<div class="modal-c-tabs">

					Nav tabs
					<ul class="nav nav-tabs md-tabs tabs-2 light-blue darken-3"
						role="tablist">
						<li class="nav-item"><a class="nav-link active"
							data-toggle="tab" href="#panel7" role="tab"><i
								class="fas fa-user mr-1"></i> Login</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab"
							href="#panel8" role="tab"><i class="fas fa-user-plus mr-1"></i>
								Register</a></li>
					</ul>

					Tab panels
					<div class="tab-content">
						Panel 7
						<div class="tab-pane fade in show active" id="panel7"
							role="tabpanel">

							Body
							<div class="modal-body mb-1">
								<div class="md-form form-sm mb-5">
									<i class="fas fa-envelope prefix"></i> <input type="email"
										id="modalLRInput10"
										class="form-control form-control-sm validate"> <label
										data-error="wrong" data-success="right" for="modalLRInput10">Your
										email</label>
								</div>

								<div class="md-form form-sm mb-4">
									<i class="fas fa-lock prefix"></i> <input type="password"
										id="modalLRInput11"
										class="form-control form-control-sm validate"> <label
										data-error="wrong" data-success="right" for="modalLRInput11">Your
										password</label>
								</div>
								<div class="text-center mt-2">
									<button class="btn btn-info">
										Log in <i class="fas fa-sign-in ml-1"></i>
									</button>
								</div>
							</div>
							Footer
							<div class="modal-footer">
								<div class="options text-center text-md-right mt-1">
									<p>
										Not a member? <a href="#" class="blue-text">Sign Up</a>
									</p>
									<p>
										Forgot <a href="#" class="blue-text">Password?</a>
									</p>
								</div>
								<button type="button"
									class="btn btn-outline-info waves-effect ml-auto"
									data-dismiss="modal">Close</button>
							</div>

						</div>
						/.Panel 7

						Panel 8
						<div class="tab-pane fade" id="panel8" role="tabpanel">

							Body
							<div class="modal-body">
								<div class="md-form form-sm mb-5">
									<i class="fas fa-envelope prefix"></i> <input type="email"
										id="modalLRInput12"
										class="form-control form-control-sm validate"> <label
										data-error="wrong" data-success="right" for="modalLRInput12">Your
										email</label>
								</div>

								<div class="md-form form-sm mb-5">
									<i class="fas fa-lock prefix"></i> <input type="password"
										id="modalLRInput13"
										class="form-control form-control-sm validate"> <label
										data-error="wrong" data-success="right" for="modalLRInput13">Your
										password</label>
								</div>

								<div class="md-form form-sm mb-4">
									<i class="fas fa-lock prefix"></i> <input type="password"
										id="modalLRInput14"
										class="form-control form-control-sm validate"> <label
										data-error="wrong" data-success="right" for="modalLRInput14">Repeat
										password</label>
								</div>

								<div class="text-center form-sm mt-2">
									<button class="btn btn-info">
										Sign up <i class="fas fa-sign-in ml-1"></i>
									</button>
								</div>

							</div>
							Footer
							<div class="modal-footer">
								<div class="options text-right">
									<p class="pt-1">
										Already have an account? <a href="#" class="blue-text">Log
											In</a>
									</p>
								</div>
								<button type="button"
									class="btn btn-outline-info waves-effect ml-auto"
									data-dismiss="modal">Close</button>
							</div>
						</div>
						/.Panel 8
					</div>

				</div>
			</div>
			/.Content
		</div>
	</div>
	Modal: Login / Register Form

	<div class="text-center">
		<a href="" class="btn btn-default btn-rounded my-3"
			data-toggle="modal" data-target="#modalLRForm">Launch Modal
			LogIn/Register</a>
	</div>
 -->
</body>
</html>