<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<style>
/* 모달 스타일 */
.modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgb(0, 0, 0);
	background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
	background-color: #fefefe;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 80%;
	max-width: 500px;
	border-radius: 10px;
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

.modal-header, .modal-footer {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px 0;
}

.modal-header {
	border-bottom: 1px solid #eee;
}

.modal-footer {
	display: flex; justify-content : flex-end; /* 버튼을 오른쪽으로 배치 */
	align-items : center; padding : 10px 0;
	border-top: 1px solid #eee;
	justify-content: flex-end; /* 버튼을 오른쪽으로 배치 */
	align-items: center;
	padding: 10px 0;
}

.modal-footer button {
	width: 100px; /* 버튼의 동일한 너비 */
	height: 35px; /* 버튼의 동일한 높이 */
	font-size: 14px; /* 버튼 텍스트 크기 */
	margin-left: 10px; /* 버튼 간의 간격 */
	border: none; /* 버튼 테두리 제거 */
	border-radius: 5px; /* 둥근 모서리 */
	cursor: pointer; /* 포인터 커서 */
	transition: background-color 0.3s ease; /* 배경색 전환 애니메이션 */
}

.modal-footer .btn-secondary {
	background-color: #6c757d; /* 기본 배경색 */
	color: white;
}

.modal-footer .btn-secondary:hover {
	background-color: #5a6268; /* 호버 시 배경색 */
}

.modal-footer .btn-primary {
	background-color: #007bff; /* 기본 배경색 */
	color: white;
}

.modal-title {
	margin: 0;
	font-size: 1.25em;
}

.modal-body {
	padding: 10px 0;
}

.modal-body .form-group {
	margin-bottom: 1em;
}

.modal-body label {
	display: block;
	margin-bottom: .5em;
}

.modal-body select, .modal-body input[type="text"], .modal-body textarea
	{
	width: 100%;
	padding: .5em;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.modal-body .alert {
	display: flex;
	align-items: center;
	padding: .75em;
	background-color: #ffdddd;
	color: #d8000c;
	border: 1px solid #d8000c;
	border-radius: 5px;
}

.modal-body .alert img {
	margin-right: .5em;
}

.modal-body .alert img {
	width: 20px; /* 이미지 너비를 줄임 */
	height: 20px; /* 이미지 높이를 줄임 */
	margin-right: 10px; /* 오른쪽 여백 */
}
</style>
</head>
<body>
	<!-- Modal -->
	<div id="refundModal" class="modal">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">환불</h5>
				<span class="close">&times;</span>
			</div>
			<form action="${path}/refund/cancel.do" method="post">
				<div class="modal-body">
					<div class="form-group">
						<label for="reason">취소 사유:</label> <select id="reason"
							name="reason" required>
							<option value="">사유를 선택하세요</option>
							<option value="변심">변심</option>
							<option value="가격 불만">가격 불만</option>
							<option value="서비스 불만">서비스 불만</option>
							<option value="기타">기타</option>
						</select>
					</div>
					<input type="hidden" id="productId" name="productId" value="" />
					<div class="alert">
						<img src="${path}/resources/images/refund_caution.png"
							alt="Warning"> <span>환불을 진행하시겠습니까? 환불하기 버튼을 누르시면 취소가
							완료됩니다.</span>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary close">뒤로가기</button>
					<button type="submit" class="btn btn-primary">환불하기</button>
				</div>
			</form>
		</div>
	</div>


	<script>
		// 모달창 띄우기
		document.querySelectorAll('.refund-button').forEach(function(button) {
			button.addEventListener('click', function() {
				var paymentId = this.getAttribute('data-id');
				document.getElementById('productId').value = paymentId;
				document.getElementById('refundModal').style.display = 'block';
			});
		});

		// 모달창 닫기
		document.querySelectorAll('.close').forEach(function(button) {
			button.addEventListener('click', function() {
				document.getElementById('refundModal').style.display = 'none';
			});
		});

		// 모달 외부 클릭 시 닫기
		window.addEventListener('click', function(event) {
			if (event.target == document.getElementById('refundModal')) {
				document.getElementById('refundModal').style.display = 'none';
			}
		});
	</script>
</body>
</html>
