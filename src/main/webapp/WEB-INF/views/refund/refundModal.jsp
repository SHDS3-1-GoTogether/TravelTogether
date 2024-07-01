<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
        crossorigin="anonymous">
        
   <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
    <script
        src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
</head>
<body>
	<!-- Modal -->
	<div class="modal fade" id="refundModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">환불</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>

				<form action="${path}/refund/cancel.do" method="post">
					<div class="modal-body">
						<div class="form-group">
							<label for="reason">취소 사유:</label> 
							<select class="form-control" id="reason" name="reason" required>
								<option value="">사유를 선택하세요</option>
								<option value="변심">변심</option>
								<option value="가격 불만">가격 불만</option>
								<option value="서비스 불만">서비스 불만</option>
								<option value="기타">기타</option>
							</select>
						</div>
						<!-- 윤철 love -->
						<input type="hidden" id="productId" name="productId" value="tgen_20240627171425erSy0"/>
						<!-- 윤철 love -->
						<div class="alert alert-warning mt-3" role="alert">
							<img src="${path}/resources/images/refund_caution.png"
								alt="Warning" class="mr-2"
								style="width: 20px; height: 20px; margin-right: 10px;"> <span>환불을
								진행하시겠습니까?</span>
							<div style="margin-left: 32px;">환불하기 버튼을 누르시면 취소가 완료됩니다.</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">뒤로가기</button>
						<button type="submit" class="btn btn-primary">환불하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
