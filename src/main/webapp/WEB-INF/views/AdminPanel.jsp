<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel - Local Finder</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .fade-in {
            animation: fadeIn 0.6s ease-out forwards;
        }
        .hover-scale {
            transition: transform 0.3s ease, background-color 0.3s ease;
        }
        .hover-scale:hover {
            transform: scale(1.05);
        }
        .sidebar-link.active {
            background-color: #1e40af; /* bg-blue-800 */
            font-weight: 600;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-gray-50 to-blue-100 min-h-screen flex">

    <!-- Sidebar -->
    <div class="w-64 bg-blue-900 text-white p-6 space-y-6 shadow-lg fixed h-full fade-in">
        <div class="flex items-center space-x-3">
            <i class="fa-solid fa-user-shield text-2xl"></i>
            <h2 class="text-2xl font-bold">Admin Panel</h2>
        </div>
        <nav class="space-y-2">
            <a href="/admindashboard" class="sidebar-link block py-2 px-4 hover:bg-blue-700 rounded hover-scale" onclick="updateURL(event, this)">Dashboard</a>
            <a href="/userlist" class="sidebar-link block py-2 px-4 hover:bg-blue-700 rounded hover-scale" onclick="updateURL(event, this)">Users</a>
            <a href="/servicelist" class="sidebar-link block py-2 px-4 hover:bg-blue-700 rounded hover-scale" onclick="updateURL(event, this)">Services</a>
            <a href="/bookings" class="sidebar-link block py-2 px-4 hover:bg-blue-700 rounded hover-scale" onclick="updateURL(event, this)">Bookings</a>
            <a href="/listcategory" class="sidebar-link block py-2 px-4 hover:bg-blue-700 rounded hover-scale" onclick="updateURL(event, this)">Categories</a>
            <a href="/reports" class="sidebar-link block py-2 px-4 hover:bg-blue-700 rounded hover-scale" onclick="updateURL(event, this)">Reports</a>
            <a href="/logout" class="block py-2 px-4 bg-red-600 hover:bg-red-700 rounded mt-6 text-center hover-scale transition duration-300">Logout</a>
        </nav>
    </div>

    <!-- Main Content (Iframe) -->
    <div class="flex-1 ml-64 p-10">
        <iframe name="contentFrame" id="contentFrame" src="/admindashboard" class="w-full h-[90vh] border-none rounded-lg shadow-md fade-in"></iframe>
    </div>

    <script>
    document.addEventListener("DOMContentLoaded", function () {
        // Local storage se page URL uthao
        let savedPage = localStorage.getItem("activePage");

        if (savedPage) {
            document.getElementById("contentFrame").src = savedPage;
            updateActiveLink(savedPage);
        }
    });

    function updateURL(event, element) {
        event.preventDefault(); // Default behavior rokna h
        const url = element.getAttribute("href");

        // iframe me URL load karna
        document.getElementById("contentFrame").src = url;

        // Local storage me URL save karna
        localStorage.setItem("activePage", url);

        // Browser ka URL update karna
        history.pushState({ path: url }, '', url);

        // Active class update karna
        updateActiveLink(url);
    }

    // Back/Forward button support ke liye event listener
    window.addEventListener("popstate", function (event) {
        let url = event.state ? event.state.path : "/admindashboard";
        document.getElementById("contentFrame").src = url;
        updateActiveLink(url);
    });


    function updateActiveLink(url) {
        document.querySelectorAll(".sidebar-link").forEach(link => {
            link.classList.remove("active");
            if (link.getAttribute("href") === url) {
                link.classList.add("active");
            }
        });
    }
    </script>

</body>
</html>
