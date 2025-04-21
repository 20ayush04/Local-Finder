<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; padding: 50px; }
        .error-box { color: red; font-size: 20px; font-weight: bold; }
        a { color: blue; text-decoration: none; font-size: 18px; }
    </style>
</head>
<body>
    <h2>Something went wrong!</h2>
    <p class="error-box">${errorMessage}</p>
    <a href="/">Go back to home</a>
</body>
</html>
