<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	
	<title>후기</title>
	<link rel="stylesheet" href="${path}/resources/css/reviewList.css">
	<!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <!-- <link href="css/styles.css" rel="stylesheet" /> -->
	

	
	</head>
	<body>
		<%@ include file="../common/header.jsp" %>
		<div class="content_wrapper">
			<h1 class="pageTitle">Review List</h1>
			<form class="search_wrapper">
				<span class="search_left">
					<span>제&nbsp&nbsp목 : <span class="input-wrapper"><input type="text" name="serarch_title"></span></span><br>
					<span>지&nbsp&nbsp역 : <span class="input-wrapper"><input type="text" name="serarch_area"></span> </span><br>
				</span>
				<span class="search_right">
					<!-- <span>작성자 : <span class="input-wrapper"><input type="text" name="serarch_category"></span></span> -->
					<span>카테고리 : <span class="input-wrapper"><input type="text" name="serarch_category"></span></span><br>
				</span>
				<input class="search_submit" type="submit" value="검색">
			</form> <br>
		
			 <div class="dropdown">
			    <button class="dropbtn">
			      <span class="dropbtn_content">최신순</span>
			      <image class="dropbtn_click" style="float:right;"
			        onclick="dropdown()"  alt="dropdown" src="${path}/resources/images/dropdown_icon.png">
			    </button>
			    <div class="dropdown-content">
			      <div class="filter" onclick="showMenu(this.innerText)">최신순</div>
			      <div class="filter" onclick="showMenu(this.innerText)">조회순</div>
			    </div>
		  	</div>
			
			<hr class="top_hr">
			<div class="items">
			
			<section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                <c:forEach var="review" items="${reviewlist}">
                <%-- <c:forEach var="review2" items="${fundinglist}"> --%>
               <%--  <%for(int i=0; i<3; i++) { %> --%>
                    <div class="col mb-5">
                    	<%-- <%for(int j=0; i<4; j++){ %> --%>
                    	
                    	
                        <div class="card h-100">
                        
                            <!-- Product image-->
                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            <!-- Product details-->
                            <div class="card-body p-4">
                            <h4>${review.title}</h4>
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">${review.nickname}</h5>
                                    <!-- Product price-->
                                    ${review.create_date}
                                    조회수: ${review.views}
                                    좋아요수: ${review.like_count}
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center">
                                	<a class="btn btn-outline-dark mt-auto" href="${path}/review/reviewDetail.do?review_id=${review.review_id}">View options ${review.review_id}</a>
                              		
                              	</div>
                            </div>
                        </div>
                        <%-- <%} %> --%>
                    </div>
                    <%-- <%} %> --%>
                   <%--  </c:forEach> --%>
                    </c:forEach>
				</div>
			</div>
			</section>
			
			
			
			</div>
			
			
		</div>
		<%@ include file="../common/footer.jsp" %>
		
	</body>
</html>