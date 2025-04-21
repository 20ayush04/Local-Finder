<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Service Provider Dashboard - Urban Service</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
            background-color: #1f2937; /* bg-gray-700 */
            font-weight: 600;
            color: #60a5fa; /* text-blue-400 */
        }
        .sidebar {
            transition: width 0.3s ease;
        }
        @media (max-width: 768px) {
            .sidebar {
                width: 0;
                overflow: hidden;
            }
            .sidebar.open {
                width: 16rem; /* w-64 */
            }
        }
    </style>
</head>
<body class="bg-gradient-to-br from-gray-900 to-gray-800 text-white min-h-screen flex">

    <!-- Sidebar -->
    <nav class="sidebar w-64 bg-gray-800 p-6 fixed h-full shadow-lg fade-in" id="sidebar">
        <div class="flex items-center justify-between mb-6">
            <div class="flex items-center space-x-2">
                <i class="fa-solid fa-tools text-xl"></i>
                <h2 class="text-xl font-bold">Provider Dashboard</h2>
            </div>
            <button class="md:hidden text-white focus:outline-none" onclick="toggleSidebar()">
                <i class="fa-solid fa-bars"></i>
            </button>
        </div>
        <ul class="space-y-3">
            <li><a href="/service-provider/dashboard" class="sidebar-link block py-2 px-4 hover:bg-gray-700 rounded hover-scale" onclick="updateURL(event, this)">Dashboard</a></li>
            <li><a href="/profile" class="sidebar-link block py-2 px-4 hover:bg-gray-700 rounded hover-scale" onclick="updateURL(event, this)">Profile</a></li>
            <li><a href="/servicelistprovider" class="sidebar-link block py-2 px-4 hover:bg-gray-700 rounded hover-scale" onclick="updateURL(event, this)">Service</a></li>
            <li><a href="/provider/bookings" class="sidebar-link block py-2 px-4 hover:bg-gray-700 rounded hover-scale" onclick="updateURL(event, this)">Bookings</a></li>
       
            <li><a href="/reviews/provider" class="sidebar-link block py-2 px-4 hover:bg-gray-700 rounded hover-scale" onclick="updateURL(event, this)">Reviews</a></li>
            <li><a href="/logout" class="block py-2 px-4 bg-red-600 hover:bg-red-700 rounded mt-6 text-center hover-scale transition duration-300">Logout</a></li>
        </ul>
    </nav>

    <!-- Main Content (Iframe) -->
    <div class="flex-1 ml-64 p-10">
        <iframe name="contentFrame" id="contentFrame" src="/service-provider/dashboard" class="w-full h-[90vh] border-none rounded-lg shadow-md bg-white fade-in"></iframe>
    </div>

    <script>
    document.addEventListener("DOMContentLoaded", function () {
        // Local storage se page URL uthao
        let savedPage = localStorage.getItem("providerActivePage");

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

    function updateActiveLink(url) {
        document.querySelectorAll(".sidebar-link").forEach(link => {
            link.classList.remove("active");
            if (link.getAttribute("href") === url) {
                link.classList.add("active");
            }
        });
    }

    // Toggle sidebar on mobile
    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('open');
    }
    </script>

</body>
</html>
