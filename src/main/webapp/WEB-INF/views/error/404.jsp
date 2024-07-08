<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Page Not Found</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #ffffff;
            margin: 0;
            padding: 0;
        }
        .container {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
        }
        .image-container {
            margin-bottom: 20px;
        }
        .image-container img {
            max-width: 100%;
            height: auto;
        }
        h1 {
            font-size: 24px;
            color: #000000;
            margin: 10px 0;
        }
        p {
            color: #000000;
            margin: 10px 0;
        }
        .button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            color: white;
            background-color: #007bff;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="image-container">
            <img src="${path}/resources/images/sh_character_06.png" alt="Error Image">
        </div>
        <h1>해당 페이지를 찾을 수 없습니다.</h1>
        <p>Page can not be found.</p>
        <p>찾으시는 페이지의 주소가 잘못되었거나, 페이지의 주소가 변경 또는 삭제로 이용하실 수 없습니다.<br>
        입력하신 페이지의 주소가 정확한지 다시 한번 확인해 주세요.</p>
        <a href="${path}/" class="button">홈으로 이동</a>
    </div>
</body>
</html>