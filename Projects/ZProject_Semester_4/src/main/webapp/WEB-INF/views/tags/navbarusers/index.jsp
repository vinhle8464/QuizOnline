
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>



<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<!-- Modal -->
	<div class="modal fade" id="login" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog modal-dialog-centered modal-lg"
			role="document">
			<div class="modal-content">
				<div class="modal-header tit-up">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title">Customer Login</h4>
				</div>
				<div class="modal-body customer-box">
					<!-- Nav tabs -->
					<ul class="nav nav-tabs">
						<li><a class="active" href="#Login" data-toggle="tab">Login</a></li>
						<li><a href="#Registration" data-toggle="tab">Registration</a></li>
					</ul>
					<!-- Tab panes -->
					<div class="tab-content">
						<div class="tab-pane active" id="Login">
							<form
								action="${pageContext.request.contextPath }/user/account/process-login"
								method="post" role="form" class="form-horizontal">
								<div class="form-group">
									<div class="col-sm-12">
										<input class="form-control" name="username"
											placeholder="Username" type="text">
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12">
										<input class="form-control" name="password"
											placeholder="Password" type="password">
									</div>
								</div>
								<div class="row">
									<div class="col-sm-10">
										<a
											href="${pageContext.request.contextPath }/oauth2/authorization/google"
											class="btn btn-light btn-radius btn-brd grd1"> Sign in
											using Google </a>
										<button type="submit"
											class="btn btn-light btn-radius btn-brd grd1">Sign
											In</button>
										<a class="for-pwd" href="javascript:;">Forgot your
											password?</a>
									</div>
								</div>
							</form>
						</div>
						<div class="tab-pane" id="Registration">
							<s:form method="post" modelAttribute="account"
								enctype="multipart/form-data"
								action="${pageContext.request.contextPath }/user/account/register">
								<div class="form-group">
									<div class="col-sm-12">
										<s:input path="username" class="form-control"
											placeholder="User name" />
										<s:errors path="username" cssClass="form-control" />
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12">
										<s:password path="password" class="form-control"
											placeholder="Password" />
										<s:errors path="password" cssClass="form-control" />
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12">
										<input name="repassword" type="password" class="form-control"
											placeholder="Retype password">
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12">
										<s:input path="fullname" class="form-control"
											placeholder="Full name" />
										<s:errors path="fullname" cssClass="form-control" />
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12">
										<s:input path="addr" class="form-control"
											placeholder="Address" />
										<s:errors path="addr" cssClass="form-control" />
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12">
										<s:radiobutton value="true" path="gender" class="form-control" />
										Male
										<div class="input-group-append">
											<div class="input-group-radio"></div>
										</div>
										<s:radiobutton value="false" path="gender"
											class="form-control" />
										Female
										<div class="input-group-append">
											<div class="input-group-radio"></div>
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12">
										<s:input path="dob" class="form-control" id="dob"
											placeholder="Date of Birth" />
										<s:errors path="dob" cssClass="form-control" />
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12">
										<s:input path="phone" class="form-control" placeholder="Phone" />
										<s:errors path="phone" cssClass="form-control" />
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12">
										<s:input path="email" class="form-control" placeholder="Email" />
										<s:errors path="email" cssClass="form-control" />
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12">
										<input class="form-control" type="file" name="file"
											placeholder="Avatar">
										<s:errors path="avatar" cssClass="form-control" />
									</div>
								</div>
								<div class="form-group">
									<input type="checkbox" id="agreeTerms" name="terms"
										value="true"> <label for="agreeTerms"> I agree
										to the <a href="#">terms</a>
									</label>

								</div>
								<div class="row">
									<div class="col-sm-10">
										<input type="hidden" name="role" value="3"> <input
											type="hidden" name="avatar" value="no ava"> <input
											type="submit" class="btn btn-light btn-radius btn-brd grd1"
											value="Save
											&amp; Continue">
										<button type="button"
											class="btn btn-light btn-radius btn-brd grd1">
											Cancel</button>
									</div>
								</div>
							</s:form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="container-fluid">
		<a class="navbar-brand" href="index.html"> <img
			src="${pageContext.request.contextPath}/resources/user/images/logo.png"
			alt="" />
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbars-host" aria-controls="navbars-rs-food"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="icon-bar"></span> <span class="icon-bar"></span> <span
				class="icon-bar"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbars-host">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item active"><a class="nav-link"
					href="${pageContext.request.contextPath}/user/home">Home</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath}/user/about">About Us</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="dropdown-a"
					data-toggle="dropdown">Course </a>
					<div class="dropdown-menu" aria-labelledby="dropdown-a">
						<c:forEach var="category" items="${categories }">
							<a class="dropdown-item"
								href="${pageContext.request.contextPath}/user/course/index?categoryId=${category.categoryId }">${category.title }
							</a>
						</c:forEach>

					</div></li>

				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath}/user/teacher">Teachers</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath}/user/pricing">Pricing</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath}/user/contact">Contact</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li><a class="hover-btn-new log orange" href="#"
					data-toggle="modal" data-target="#login"><span>Book Now</span></a></li>
			</ul>
		</div>
	</div>
</nav>