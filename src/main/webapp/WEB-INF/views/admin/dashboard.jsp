<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대시보드</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<link href="${path}/resources/css/adminMenu.css" rel="stylesheet">
<link href="${path}/resources/css/adminCouponList.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>
<style>
#myChart2 {
	width: 100% !important;
	height: 100% !important;
}

#myChart3, #myChart4 {
	width: 50% !important;
	height: 50% !important;
}

.dashboard-container {
	display: flex;
	flex-wrap: wrap;
	margin-top: 20px;
}

.left-container {
	flex: 1;
	max-width: 60%;
}

.right-container {
	display: flex;
	flex-direction: column;
	flex: 1;
	max-width: 40%;
}

.member-info-container {
	margin: 10px;
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	padding: 20px;
	text-align: center;
	width: 95%;
	box-sizing: border-box;
}

.member-info p {
	margin: 10px 0;
	font-size: 24px;
	color: #333333;
}

.tt_member {
	margin: 20px 0;
}

.member-info-container2 {
	display: flex;
	justify-content: space-around;
	align-items: center;
	margin: 20px 0;
}

.member-info2 {
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	padding: 20px;
	text-align: center;
	width: 45%; /* 너비를 조정하여 두 div가 나란히 위치하도록 */
}

.member-info2 p {
	margin: 10px 0;
	font-size: 24px;
	color: #333333;
}

/* 추가한 스타일 */
.funding-state {
	margin-top: 20px; /* 필요에 따라 조정 */
	padding: 20px;
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.funding-state p {
	font-size: 24px;
	color: #333333;
	margin-bottom: 10px;
}

#myChart5 {
	width: 100% !important;
	height: 400px !important; /* 필요에 따라 조정 */
	margin-top: 20px; /* 필요에 따라 조정 */
}

/* 금액 및 QnA 스타일 */
.left-container3, .right-container3 {
    display: flex;
    align-items: center;
    padding: 20px;
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    margin-top: 20px;
}

.left-container3 p, .right-container3 p {
    font-size: 24px;
    color: #333333;
    margin: 0;
}
</style>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="container">
		<%@ include file="./adminMenu.jsp"%>
		<div class="content">

			<div class="member-info-container2">
				<div class="member-info2">
					<p>
						<i class="fas fa-user-plus"></i>
					</p>
					이용 회원 수 : ${existingNormalMember}
				</div>
				<div class="member-info2">
					<p>
						<i class="fas fa-user-minus"></i>
					</p>
					탈퇴 회원 수 : ${deletedNormalMember}
				</div>
			</div>

			<div class="dashboard-container">
				<div class="left-container">
					<div class="member-info-container">
						<div class="member-info">
							<p>최근 6개월간 가입/탈퇴 현황</p>
							<canvas id="myChart1"></canvas>
						</div>
					</div>
				</div>
				

				<div class="right-container">
					<div class="member-info-container">
						<div class="member-info">
							<p>회원 멤버십 분포</p>
							<canvas id="myChart2"></canvas>
						</div>
					</div>
					<div class="member-info-container">
						<div class="member-info">
							<p>회원 성비</p>
							<canvas id="myChart3"></canvas>
						</div>
					</div>
				</div>
			</div>
			
		<div class="funding-state">
			<p>펀딩 상태</p>
			<canvas id="myChart4"></canvas>
		</div>
				<div class="left-container3">
							<p><i class="fas fa-money-check-alt"></i> 총 이용 금액: <fmt:formatNumber type="number" maxFractionDigits="3" value="${money}" /></p>
				</div>
				<div class="right-container3">
					<p><i class="fas fa-question-circle"></i>  답변 미등록 QnA: ${qnaNum }</p>
				</div>
				</div>
				
				
				


	</div>
	<%@ include file="../common/footer.jsp"%>

	<script>
		var monthList = ${monthList}
		var numList = ${numList}
		var numList2 = ${numList2}
		//var firstMonth = MonthAgoMember[0]
		let myCt1 = document.getElementById('myChart1');
		let myChart1 = new Chart(myCt1, {
			type: 'bar',
			data: {
				labels: [monthList[0], monthList[1], monthList[2], monthList[3], monthList[4], monthList[5]],
				datasets: [
					{
						label: '가입자',
						data: [numList[0], numList[1], numList[2], numList[3], numList[4], numList[5]],
						borderColor: 'rgba(72, 207, 174, 1)',
						backgroundColor: 'rgba(72, 207, 174, 0.2)',
						fill: false
					},
					{
						label: '탈퇴자',
						data: [numList2[0], numList2[1], numList2[2], numList2[3], numList2[4], numList2[5]],
						borderColor: 'rgba(207 , 72 , 105 , 1)',
						backgroundColor: 'rgba(207 , 72 , 105 , 0.2)',
						fill: false
					}
				]
			},
			options: {
				scales: {
					y: {
						beginAtZero: true,
						ticks: {
							stepSize: 1,
							callback: function(value) {
								return Number.isInteger(value) ? value : '';
							}
						}
					}
				}
			}
		});
		
		let myCt2 = document.getElementById('myChart2');
		let myChart2 = new Chart(myCt2, {
			type: 'doughnut',
			data: {
				labels: ['뚜벅이', '자전거', '자동차'],
				datasets: [{
					label: 'Dataset',
					data: [${walkerMember}, ${bicycleMember}, ${carMember}],
					backgroundColor: [
						'rgba(202, 205, 215, 0.6)',
						'rgba(66, 73, 89, 0.6)',
						'rgba(16, 18, 25, 0.6)'
					],
				}]
			},
		});
		
		let myCt3 = document.getElementById('myChart3');
		let myChart3 = new Chart(myCt3, {
			type: 'doughnut',
			data: {
				labels: ['남성', '여성'],
				datasets: [{
					label: 'Dataset',
					data: [${maleMember}, ${existingNormalMember - maleMember}],
					backgroundColor: [
						'rgba(165, 201, 255, 0.6)',
						'rgba(255, 165, 201, 0.6)'
					],
				}]
			},
		});
		
		var fundState = ${fundState};
		var fundNum = ${fundNum};
		let myCt4 = document.getElementById('myChart4');
		let myChart4 = new Chart(myCt4, {
			type: 'bar',
			data: {
				labels: [fundState[0], fundState[1], fundState[2], fundState[3], fundState[4]],
				datasets: [
					{
						label: '펀딩현황',
						 data: [fundNum[0], fundNum[1], fundNum[2], fundNum[3], fundNum[4]],
			                borderColor: [
			                    'rgba(171,219,227, 1)', // 첫 번째 막대 선 색상
			                    'rgba(118,181,197, 1)', // 두 번째 막대 선 색상
			                    'rgba(30,129,176, 1)', // 세 번째 막대 선 색상
			                    'rgba(21,76,121, 1)', // 네 번째 막대 선 색상
			                    'rgba(33,19,13, 1)'  // 다섯 번째 막대 선 색상
			                ],
			                backgroundColor: [
			                    'rgba(171,219,227, 0.2)', // 첫 번째 막대 배경 색상
			                    'rgba(118,181,197, 0.2)', // 두 번째 막대 배경 색상
			                    'rgba(30,129,176, 0.2)', // 세 번째 막대 배경 색상
			                    'rgba(21,76,121, 0.2)', // 네 번째 막대 배경 색상
			                    'rgba(33,19,13, 0.2)'  // 다섯 번째 막대 배경 색상
			                ],
			                fill: false
			            },
				]
			},
			options: {
				scales: {
					y: {
						beginAtZero: true,
						ticks: {
							stepSize: 1,
							callback: function(value) {
								return Number.isInteger(value) ? value : '';
							}
						}
					}
				}
			}
		});
	</script>
</body>
</html>
