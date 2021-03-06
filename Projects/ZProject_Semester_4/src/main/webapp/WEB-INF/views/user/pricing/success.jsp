<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Success</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/user/css/stylePayment.css">
</head>
<body>
	<div class="servicebot--embeddable servicebot--rf-embeddable servicebot--request-user-form-wrapper custom">
		<div class="rf--form-wrapper summary-shown">
			<div class="rf--form">
				<div class="rf--form-content">
					<div class="rf--basic-info"></div>
					<div class="rf--form-elements">
						<div class="_success-ui">
							<i class="fa fa-check" aria-hidden="true"></i>
							<img class="_svg-icon" src="${pageContext.request.contextPath }/resources/user/images/logosite.png">
							<h2 class="_success-heading">Success</h2>
							<span class="_success-message">Purchase Completed! You should receive an email shortly.</span>
							<a href="${pageContext.request.contextPath }/user/account/logout">Login Again</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="servicebot-logo-footer">
			<span class="_text">Checkout generated by Servicebot <img src=""></span>
		</div>
	</div>
</body>
</html>