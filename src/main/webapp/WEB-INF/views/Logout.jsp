<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Logout Confirmation</title>
    <script>
        function confirmLogout(isConfirmed) {
            if (isConfirmed) {
                window.location.href = "/logout"; // Spring Security Logout
            } else {
                window.history.back(); // Wapas previous page pe
            }
        }
    </script>
</head>
<body>
    <h2>Are you sure you want to logout?</h2>
    <button onclick="confirmLogout(true)">Yes</button>
    <button onclick="confirmLogout(false)">No</button>
</body>
</html>
