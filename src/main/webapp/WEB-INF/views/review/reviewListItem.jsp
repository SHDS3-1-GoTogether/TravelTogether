<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기</title>
<link rel="stylesheet" href="${path}/resources/css/fundingList.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<c:forEach var="review" items="${reviewlist}">
                        <div class="card">
                        	<div class="img-wrap">
                            <!-- Product image-->
                            <!-- <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." /> -->
	                            <c:forEach var="mainPic" items="${mainPic}">
	                            	
	                            	<c:if test="${mainPic.review_id==review.review_id}">
										<img class="item_img" alt="${mainPic.photo_name}" src="${mainPic.photo_name}" />
									</c:if>
	                            </c:forEach>
                            </div>
                            <!-- Product details-->
                            <div class="card-body">
                            <h4>${review.title}</h4>
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">${review.nickname}</h5>
                                    <!-- Product price-->
                                    <h4>${review.create_date}</h4>
                                    <img class="icon_view" alt="눈" src="${path}/resources/images/view.png"><span class="views">${review.views}</span> 
                                    <%-- <i id="heartBox" onclick="toggleLike()" class="fas fa-heart"></i>${review.like_count}<br> --%>
                                </div>
                            </div><br>
                            <!-- Product actions-->
                            <div class="card-footer">
                                <div class="text-center">
                                	<a class="confirm-button" href="${path}/review/reviewDetail.do?review_id=${review.review_id}">보러 가기</a>
                              	</div>
                            </div>
                        </div>
                    </c:forEach>
</body>
</html>