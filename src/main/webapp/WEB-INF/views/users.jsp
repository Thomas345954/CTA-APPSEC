<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registration and Login System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="/">Registration and Login System</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>
</nav>
<br />
<br />
<br />
<div class="container">
    <div class="row col-md-8 offset-md-2">
        <div class="card">
            <!-- Show a success message if registration was successful -->
            <div id="success-message" style="display: none;">
                <div class="alert alert-info">You've successfully registered to our app!</div>
            </div>
            <div class="card-header">
                <h2 class="text-center">Registration</h2>
            </div>
            <div class="card-body">
                <form method="post" action="/register/save" role="form">
                    <div class="form-group mb-3">
                        <label class="form-label">First Name</label>
                        <input class="form-control"
                               id="firstName"
                               name="firstName"
                               placeholder="Enter first name"
                               type="text"
                        />
                        <p class="text-danger" id="firstName-error" style="display: none;"></p>
                    </div>

                    <div class="form-group mb-3">
                        <label class="form-label">Last Name</label>
                        <input class="form-control"
                               id="lastName"
                               name="lastName"
                               placeholder="Enter last name"
                               type="text"
                        />
                        <p class="text-danger" id="lastName-error" style="display: none;"></p>
                    </div>
                    <div class="form-group mb-3">
                        <label class="form-label">Email</label>
                        <input class="form-control"
                               id="email"
                               name="email"
                               placeholder="Enter email address"
                               type="email"
                        />
                        <p class="text-danger" id="email-error" style="display: none;"></p>
                    </div>
                    <div class="form-group mb-3">
                        <label class="form-label">Password</label>
                        <input class="form-control"
                               id="password"
                               name="password"
                               placeholder="Enter password"
                               type="password"
                        />
                        <p class="text-danger" id="password-error" style="display: none;"></p>
                    </div>

                    <div class="form-group mb-3">
                        <button class="btn btn-primary" type="submit">Register</button>
                        <span>Already registered? <a href="/login">Login here</a></span>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/right-click.jsp" %>
</body>
</html>