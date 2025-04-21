<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.List" %>
<%@ page import="com.grownited.entity.ServiceEntity" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Service Management - Provider Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #1f2937;
            color: #e5e7eb;
        }
        /* Sidebar Styling */
        .sidebar {
            transition: transform 0.3s ease-in-out;
        }
        .sidebar.hidden {
            transform: translateX(-100%);
        }
        .sidebar-link:hover { background-color: #4a5568; }
        @media (max-width: 768px) {
            .sidebar {
                position: fixed;
                top: 0;
                left: 0;
                width: 256px;
                height: 100%;
                z-index: 50;
                background-color: #374151;
            }
            .sidebar:not(.hidden) {
                transform: translateX(0);
            }
            #main-content {
                margin-left: 0;
            }
        }
        /* Table Responsiveness */
        @media (max-width: 640px) {
            .service-table {
                display: block;
            }
            .service-table thead {
                display: none;
            }
            .service-table tbody, .service-table tr, .service-table td {
                display: block;
                width: 100%;
            }
            .service-table tr {
                margin-bottom: 1rem;
                border: 1px solid #d1d5db;
                border-radius: 8px;
                padding: 1rem;
                background-color: #f9fafb;
                transition: background-color 0.3s ease;
            }
            .service-table tr:active {
                background-color: #e5e7eb; /* Lighter gray for tap effect */
            }
            .service-table td {
                padding: 0.5rem 0;
                border: none;
                position: relative;
                color: #374151;
            }
            .service-table td::before {
                content: attr(data-label);
                font-weight: 600;
                color: #374151;
                display: block;
                margin-bottom: 0.25rem;
            }
            .service-table td:last-child {
                display: flex;
                justify-content: space-around;
                gap: 1rem;
            }
            .action-btn {
                padding: 0.5rem 1rem;
                border-radius: 6px;
                font-weight: 500;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }
            .action-btn.edit {
                background-color: #3b82f6; /* Blue */
                color: #fff;
            }
            .action-btn.delete {
                background-color: #ef4444; /* Red */
                color: #fff;
            }
            .action-btn:active {
                transform: scale(0.95); /* Slight scale down on tap */
            }
        }
        /* Hover Effects for Desktop */
        @media (min-width: 641px) {
            .hover-scale:hover {
                transform: scale(1.05);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            }
        }
        /* Button Styling */
        .btn-primary {
            background-color: #3b82f6;
            color: #fff;
            padding: 8px 16px;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #1e40af;
        }
        /* Close Button Styling */
        .close-btn {
            background-color: #ef4444;
            color: #fff;
            padding: 0.5rem;
            border-radius: 50%;
            transition: background-color 0.3s ease;
        }
        .close-btn:hover {
            background-color: #dc2626;
        }
    </style>
</head>
<body class="min-h-screen flex flex-col md:flex-row">

    <!-- Sidebar -->
    <aside id="sidebar" class="sidebar w-full md:w-64 bg-gray-800 p-4 sm:p-6 h-auto md:h-screen shadow-lg md:block">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-xl sm:text-2xl font-bold flex items-center">
                <i class="fa-solid fa-tools mr-2 text-blue-400"></i> Provider Dashboard
            </h2>
            <button id="close-btn" class="close-btn md:hidden">
                <i class="fa-solid fa-times text-xl"></i>
            </button>
        </div>
        <ul class="space-y-3">
            <li><a href="/service-provider/dashboard" class="sidebar-link block py-2 px-4 rounded-md text-sm sm:text-base">Dashboard</a></li>
            <li><a href="/profile" class="sidebar-link block py-2 px-4 rounded-md text-sm sm:text-base">Profile</a></li>
            <li><a href="/servicelistprovider" class="sidebar-link block py-2 px-4 rounded-md text-sm sm:text-base active">Service</a></li>
            <li><a href="/provider/bookings" class="sidebar-link block py-2 px-4 rounded-md text-sm sm:text-base">Bookings</a></li>
            <li><a href="/reviews/provider" class="sidebar-link block py-2 px-4 rounded-md text-sm sm:text-base">Reviews</a></li>
            <li><a href="/logout" class="block py-2 px-4 bg-red-600 hover:bg-red-700 rounded text-center mt-6 text-sm sm:text-base">Logout</a></li>
        </ul>
    </aside>

    <!-- Main Content -->
    <div id="main-content" class="flex-1 p-4 sm:p-6 md:ml-6">
        <!-- Mobile Header with Hamburger Menu -->
        <div class="md:hidden flex justify-between items-center mb-6">
            <h1 class="text-2xl font-bold text-blue-400 flex items-center">
                <i class="fa-solid fa-tools mr-2"></i> Urban Service
            </h1>
            <button id="menu-btn" class="text-white focus:outline-none">
                <i class="fa-solid fa-bars text-2xl"></i>
            </button>
        </div>

        <div class="max-w-6xl mx-auto">
            <!-- Header -->
            <div class="flex flex-col sm:flex-row items-center justify-between mb-6 sm:mb-8">
                <h1 class="text-2xl sm:text-3xl font-bold text-blue-400 flex items-center">
                    <i class="fa-solid fa-tools mr-2"></i> Service Management
                </h1>
                <div class="text-gray-400 text-xs sm:text-sm mt-2 sm:mt-0">
                    Last Updated: <%= new java.text.SimpleDateFormat("MMM dd, yyyy HH:mm").format(new java.util.Date()) %>
                </div>
            </div>

            <!-- Table -->
            <div class="bg-gray-800 p-4 sm:p-6 rounded-lg shadow-lg mb-6">
                <div class="overflow-x-auto">
                    <table class="service-table w-full text-sm text-gray-300">
                        <thead class="bg-blue-600 text-white uppercase tracking-wider">
                            <tr>
                                <th class="px-4 sm:px-6 py-3 text-left">Service Name</th>
                                <th class="px-4 sm:px-6 py-3 text-left">Description</th>
                                <th class="px-4 sm:px-6 py-3 text-left">Category</th>
                                <th class="px-4 sm:px-6 py-3 text-left">Created</th>
                                <th class="px-4 sm:px-6 py-3 text-left">Updated</th>
                                <th class="px-4 sm:px-6 py-3 text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty services}">
                                    <tr>
                                        <td colspan="6" class="px-4 sm:px-6 py-4 text-center text-gray-400">No services available.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="service" items="${services}">
                                        <tr class="hover:bg-gray-700 transition duration-200">
                                            <td class="px-4 sm:px-6 py-4 border-b border-gray-600" data-label="Service Name">${service.serviceName}</td>
                                            <td class="px-4 sm:px-6 py-4 border-b border-gray-600" data-label="Description">${service.description}</td>
                                            <td class="px-4 sm:px-6 py-4 border-b border-gray-600" data-label="Category">${service.category.categoryName}</td>
                                            <td class="px-4 sm:px-6 py-4 border-b border-gray-600" data-label="Created">
                                                <fmt:formatDate value="${service.createdAt}" pattern="MMM dd, yyyy HH:mm" />
                                            </td>
                                            <td class="px-4 sm:px-6 py-4 border-b border-gray-600" data-label="Updated">
                                                <fmt:formatDate value="${service.updatedAt}" pattern="MMM dd, yyyy HH:mm" />
                                            </td>
                                            <td class="px-4 sm:px-6 py-4 border-b border-gray-600 text-center flex justify-center gap-4" data-label="Actions">
                                                <a href="${pageContext.request.contextPath}/editservice?id=${service.serviceId}" class="text-blue-400 hover:text-blue-300 hover-scale md:text-blue-400 action-btn edit">Edit</a>
                                                <a href="${pageContext.request.contextPath}/deleteservice?id=${service.serviceId}" class="text-red-400 hover:text-red-300 hover-scale md:text-red-400 action-btn delete" onclick="return confirm('Are you sure you want to delete this service?');">Delete</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Add New Service Button -->
            <div class="text-right">
                <a href="${pageContext.request.contextPath}/newservice" class="btn-primary hover-scale text-sm sm:text-base">Add New Service</a>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script>
        // Mobile Menu Toggle
        const menuBtn = document.getElementById('menu-btn');
        const closeBtn = document.getElementById('close-btn');
        const sidebar = document.getElementById('sidebar');

        // Initialize sidebar visibility based on screen size
        function updateSidebarVisibility() {
            if (window.innerWidth < 768) {
                sidebar.classList.add('hidden');
            } else {
                sidebar.classList.remove('hidden');
            }
        }

        // Set initial state on page load
        updateSidebarVisibility();

        // Toggle sidebar on menu button click (open)
        menuBtn.addEventListener('click', () => {
            sidebar.classList.remove('hidden');
        });

        // Close sidebar on close button click
        closeBtn.addEventListener('click', () => {
            sidebar.classList.add('hidden');
        });

        // Adjust sidebar visibility on resize
        window.addEventListener('resize', updateSidebarVisibility);
    </script>
</body>
</html>