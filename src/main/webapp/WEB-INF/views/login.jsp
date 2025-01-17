<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Registration and Login System</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container-fluid">
			<a class="navbar-brand" href="/">Registration and Login System</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
		</div>
	</nav>
	<br/>
	<br/>
	<br/>
	<div class="container">
		<div class="row">
			<div class="col-md-6 offset-md-3">
				<!-- Show an error message if there's a login error -->
				<div id="error-message" style="display: none;">
					<div class="alert alert-danger">Invalid Email and Password.</div>
				</div>
				<!-- Show a success message if the user has logged out -->
				<div id="logout-message" style="display: none;">
					<div class="alert alert-success">You have been logged out.</div>
				</div>
				<div class="card">
					<div class="card-header">
						<h3 class="text-center">Login Form</h3>
					</div>
					<div class="card-body">
						<form method="post" action="/login" class="form-horizontal"
							role="form">
							<div class="mb-3">
								<label for="username" class="control-label">Email <em style="color: #ff0000;">*</em></label> <input
									type="text" id="username" name="username" class="form-control"
									placeholder="Email" />
							</div>
							<div class="mb-3">
								<label for="password" class="control-label">Password <em style="color: #ff0000;">*</em></label> <input
									type="password" id="password" name="password"
									class="form-control" placeholder="Password" />
							</div>
							<div class="mb-3">
								<button type="submit" class="btn btn-primary">Login</button>
								<span> Not registered? <a href="/register">
										Register/SignUp Here</a>
								</span>
							</div>
						</form>
						<div>
							<a href="/oauth2/authorization/google">Login with Google</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>