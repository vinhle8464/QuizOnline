<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="mt" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<mt:layout_admin title="Question">

	<jsp:attribute name="content">

<link rel="stylesheet"
			href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
	<script type="text/javascript">
		/* Add and remove answer */
		$(document)
				.on(
						'click',
						'.addAnswer',
						function() {
							var $div = ' <div><br><input name="answerTitle">	True: <input type="checkbox" name="answerStatus" value="1"> &nbsp; False: <input type="checkbox" name="answerStatus" value="0"> &nbsp;	&nbsp;	&nbsp;<input style="color: red; border:none; background-color: white;" type="button" value="X" class="removeAnswer"></div>';
							$("#answers").append($div);
						});

		$(document).on('click', '.removeAnswer', function() {
			$(this).parent('div').remove();
		});
		/* Add and remove answer */

		function openDeleteModal(questionId) {
			$('#questionID').val(questionId);
		}
		function openEditModal(questionId) {
			$
					.ajax({
						type : 'GET',
						url : '${pageContext.request.contextPath }/faculty/ajax/findquestionbyid',
						data : {
							questionId : questionId
						},
						success : function(question) {
							$('#questionId').val(question.questionId);
							$('#quizId').val(question.quiz.quizId);
							$('#title').val(question.title);
							$('#explainDetail').val(question.explainDetail);
							$('#status').val(question.status);
						}
					});
		}
	</script>
		 <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Question Page</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Question Page</li>
            </ol>
          </div>
        </div>
      </div>
			<!-- /.container-fluid -->
    </section>
		  <!-- Main content -->
    <section class="content">

      <!-- Default box -->
		<div class="card">
	        <div class="card-header">
	          <h3 class="card-title">Quiz: ${questions[0].quiz.title }</h3>
	
	          <div class="card-tools">
	            <button type="button" class="btn btn-tool"
							data-card-widget="collapse" title="Collapse">
	              <i class="fas fa-minus"></i>
	            </button>
	          
	          </div>
	        </div>
	    <div class="card-body">          
		<div class="">
		<div class="table-responsive">
			<div class="table-wrapper">
				<div class="table-title">
					<div class="row">
						<div class="col-sm-6">
							<h2>Manage <b>Questions</b>
											</h2>
						</div>
						<div class="col-sm-6">
							<a href="#addEmployeeModal" class="btn btn-success"
												data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add New Question</span></a>
											
						</div>
					</div>
				</div>
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th>
								
							</th>
						
														<th> <a
												href="${pageContext.request.contextPath}/faculty/question/pagination?currentPage=${currentPage}&pageSize=${pageSize}&sort=title&quizId=${quizId}">Title</a></th>
							<th style="text-align: center;"> <a href="#">Number of Answers</a></th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
	
	      
	    			  <c:choose>
	        <c:when test="${questions.size() > 0 }">
					<c:forEach var="question" items="${questions}" varStatus="i">
						<tr>
							<td>
								${i.index + 1 }
							</td>
							
							<td>${question.title }</td>
							<td style="text-align: center;">${question.answers.size() }</td>
							
							<td>
								<a href="#editEmployeeModal" id="${question.questionId }"
															onclick="openEditModal(id);" class="edit"
															data-toggle="modal"><i class="material-icons"
																data-toggle="tooltip" title="Edit">&#xE254;</i></a>
								<a href="#deleteEmployeeModal" id="${question.questionId }"
															onclick="openDeleteModal(id);" class="delete"
															data-toggle="modal"><i class="material-icons"
																data-toggle="tooltip" title="Delete">&#xE872;</i></a>
							</td>
						</tr>
						</c:forEach>
						  </c:when>
	        <c:otherwise>
	            <tr align="center">
	                <td colspan="5">No Users available</td>
	            </tr>
	        </c:otherwise>
	    </c:choose>
					</tbody>
				</table>
				
				
	<div>
	
	    <c:if test="${questions.size() > 0 }">
	        <div class="panel-footer">
	 
			<select style="color: #566787;" name="pageSize"
												onchange="location = this.value;">
			 <option value="">PageSize</option>
			 <option
													value="${pageContext.request.contextPath}/faculty/question/pagination?currentPage=1&pageSize=5&sort=${sort}&quizId=${quizId}">5</option>
			 <option
													value="${pageContext.request.contextPath}/faculty/question/pagination?currentPage=1&pageSize=10&sort=${sort}&quizId=${quizId}">10</option>
			 <option
													value="${pageContext.request.contextPath}/faculty/question/pagination?currentPage=1&pageSize=25&sort=${sort}&quizId=${quizId}">25</option>
			  <option
													value="${pageContext.request.contextPath}/faculty/question/pagination?currentPage=1&pageSize=50&sort=${sort}&quizId=${quizId}">50</option>
			</select>
	
		&nbsp;&nbsp;
		<span>Showing <strong>${currentPage > 1 ? currentPage * pageSize - pageSize : 1}</strong> to <strong>${pageSize * currentPage}</strong> out of <b>${totalElements}</b> entries</span>
	         
	            <ul class="pagination">
	            			<li
													class="${currentPage > 1 ? 'page-item' : 'page-item disabled'}">
	                        <a
													href="${pageContext.request.contextPath}/faculty/question/pagination?currentPage=1&pageSize=${pageSize}&sort=${sort}&quizId=${quizId}"
													class="page-link">First</a>
	                    </li>
	                    
	                     <li
													class="${currentPage > 1 ? 'page-item' : 'page-item disabled'}">
	                        <a
													href="${pageContext.request.contextPath}/faculty/question/pagination?currentPage=${currentPage - 1}&pageSize=${pageSize}&sort=${sort}&quizId=${quizId}"
													class="page-link">Previous</a>
	                    </li>
	                    
	                    
	                 <!--  // start number of page -->
	                 
	                    <!--   //  totalpage <= 5 -->
	          
	             
	                 <c:if test="${totalPages <= 5 && currentPage <= 5 }">
		                <c:forEach begin="0" end="${totalPages - 1}"
														var="page">
		                    <li
															class="${currentPage == page + 1 ? 'page-item active' : 'page-item' }">
		                        <a
															href="${pageContext.request.contextPath}/faculty/question/pagination?currentPage=${page + 1}&pageSize=${pageSize}&sort=${sort}&quizId=${quizId}"
															class="page-link">${page+1}</a>
		                    </li>
		                </c:forEach>
		               
	                </c:if>
	              <!--   //  totalpage > 5 -->
	          
	                 <c:if test="${totalPages > 5 && currentPage <= 2 }">
		                <c:forEach begin="0" end="4" var="page">
		                    <li
															class="${currentPage == page + 1 ? 'page-item active' : 'page-item' }">
		                        <a
															href="${pageContext.request.contextPath}/faculty/question/pagination?currentPage=${page + 1}&pageSize=${pageSize}&sort=${sort}&quizId=${quizId}"
															class="page-link">${page+1}</a>
		                    </li>
		                </c:forEach>
	                </c:if>
	              
	                   <c:if
													test="${totalPages > 5 && currentPage >= 3 && currentPage != totalPages}">
	                  	                
			              	<c:forEach
														begin="${currentPage <= totalPages - 2 ? currentPage - 2 : currentPage - 3}"
														end="${currentPage - 1}" var="page1">
			                    <li class="page-item">
			                        <a
															href="${pageContext.request.contextPath}/faculty/question/pagination?currentPage=${page1}&pageSize=${pageSize}&sort=${sort}&quizId=${quizId}"
															class="page-link">${page1}</a>
			                    </li>
			                </c:forEach>
		                   
		                 <li class="page-item active">
		                        <a
														href="${pageContext.request.contextPath}/faculty/question/pagination?currentPage=${currentPage}&pageSize=${pageSize}&sort=${sort}"
														class="page-link">${currentPage}</a>
		                    </li>
		               	  <c:forEach begin="${currentPage}"
														end="${currentPage <= totalPages - 2 ? currentPage + 1 : currentPage}"
														var="page2">
		                    <li
															class="${currentPage == page2 + 1 ? 'page-item active' : 'page-item' }">
		                        <a
															href="${pageContext.request.contextPath}/faculty/question/pagination?currentPage=${page2 + 1}&pageSize=${pageSize}&sort=${sort}&quizId=${quizId}"
															class="page-link">${page2 + 1}</a>
		                    </li>
		                </c:forEach> 
	                </c:if>
	                
	                   <!--   //  the last page -->
	          
	             
	            		    <c:if
													test="${currentPage == totalPages && totalPages > 5}">
			                <c:forEach begin="${totalPages - 5 }"
														end="${totalPages - 1}" var="page">
			                    <li
															class="${currentPage == page + 1 ? 'page-item active' : 'page-item' }">
			                        <a
															href="${pageContext.request.contextPath}/faculty/question/pagination?currentPage=${page + 1}&pageSize=${pageSize}&sort=${sort}&quizId=${quizId}"
															class="page-link">${page+1}</a>
			                    </li>
			                </c:forEach>
	               		</c:if>
	                 
	                  <!--  // end number of page -->
	              
	                     <li
													class="${currentPage < totalPages ? 'page-item' : 'page-item disabled'}">
	                        <a
													href="${pageContext.request.contextPath}/faculty/question/pagination?currentPage=${currentPage + 1}&pageSize=${pageSize}&sort=${sort}&quizId=${quizId}"
													class="page-link">Next</a>
	                    </li>
	                      <li
													class="${currentPage < totalPages ? 'page-item' : 'page-item disabled'}">
	                        <a
													href="${pageContext.request.contextPath}/faculty/question/pagination?currentPage=${totalPages }&pageSize=${pageSize}&sort=${sort}&quizId=${quizId}"
													class="page-link">Last</a>
	                    </li>
	            </ul>
	        </div>
	    </c:if>
	    </div>
		</div>        
	</div>


<!-- Add Modal HTML -->
<div id="addEmployeeModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			
			<s:form method="post" modelAttribute="question"
										action="${pageContext.request.contextPath }/faculty/question/create">
				
				<div class="modal-header">	
									
					<h4 class="modal-title">Add Question and Answer</h4>
					<button type="button" class="close" data-dismiss="modal"
												aria-hidden="true">&times;</button>
							
				</div>
				<div class="modal-body">					
					<div class="form-group">
					<span style="color: red;">${msg==""?"": msg }</span> <br />
						<label>Question Title</label>
						<s:input path="title" type="text" class="form-control"
													required="required" />
				
					</div>
					<div class="form-group">
						<label>Explain Detail</label>
						<s:textarea path="explainDetail" type="text" class="form-control"
													required="required" />
					
					</div>				
					<input name="quizId" type="hidden" value="${quizId }" />
					<hr>
		  	<div id="answers">
		  	ANSWERS: <input style="float:right;" type="button" class="btn-default addAnswer" value="+">
							<div>
		  		<br>
		  		<input name="answerTitle">	
		  		
 		   		True: <input type="checkbox" name="answerStatus" value="1"> &nbsp;	
 		   		False: <input type="checkbox" name="answerStatus" value="0"> &nbsp;	&nbsp;	&nbsp;	
 		   		<input style="color: red; border:none; background-color: white;" type="button" value="X" class="removeAnswer">
 		   		</div>
		  	
		  	<div>
		  	<br>
		  		<input name="answerTitle">	
		  		
 		   		True: <input type="checkbox" name="answerStatus" value="1"> &nbsp;	
 		   		False: <input type="checkbox" name="answerStatus" value="0"> &nbsp;	&nbsp;	&nbsp;	
 		   		<input style="color: red; border:none; background-color: white;" type="button" value="X" class="removeAnswer">
 		   		</div>
		  
		  		<div>
		  			<br>
		  		<input name="answerTitle">	
		  		
 		   		True: <input type="checkbox" name="answerStatus" value="1"> &nbsp;	
 		   		False: <input type="checkbox" name="answerStatus" value="0"> &nbsp;	&nbsp;	&nbsp;	
 		   	<input style="color: red; border:none; background-color: white;" type="button" value="X" class="removeAnswer">
 		   		</div>
		  
		  </div>
					<s:input path="status" type="hidden" value="true" />
									
				</div>
				<div class="modal-footer">
					<input type="button" class="btn btn-default" data-dismiss="modal"
												value="Cancel">
					<s:input type="submit" class="btn btn-success" value="save" path="" />
				</div>
			</s:form>
		</div>
	</div>
</div>
<!-- Edit Modal HTML -->
<div id="editEmployeeModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
		<s:form method="post" modelAttribute="question"
										action="${pageContext.request.contextPath }/faculty/question/update"
										enctype="multipart/form-data">
				
				<div class="modal-header">	
									
					<h4 class="modal-title">Update Question</h4>
					<button type="button" class="close" data-dismiss="modal"
												aria-hidden="true">&times;</button>
											
				</div>
				<div class="modal-body">		
				<div class="form-group">
						<label>QuestionID</label>
						<s:input path="questionId" type="text" class="form-control"
													disabled="true" />
				
					</div>	
					<div class="form-group">
						<label>QuizID</label>
						<s:input path="quiz.quizId" type="text" class="form-control"
													disabled="true" />
				
					</div>		
					<div class="form-group">
						<label>Title</label>
						<s:input path="title" type="text" class="form-control"
													required="required" />
				
					</div>
				
					<div class="form-group">
						<label>explainDetail</label>
						<s:input path="explainDetail" type="text" class="form-control"
													required="required" />				
					</div>	
					<s:input type="hidden" path="status" />
									
				</div>
				<div class="modal-footer">
					<input type="button" class="btn btn-default" data-dismiss="modal"
												value="Cancel">
					<s:input type="submit" class="btn btn-success" value="save" path="" />
				</div>
			</s:form>
		</div>
	</div>
</div>

        </div>
        <!-- /.card-body -->
        <div class="card-footer">
          Footer
        </div>
        <!-- /.card-footer-->
      	</div>

		</div>
	</section>

	</jsp:attribute>
</mt:layout_admin>