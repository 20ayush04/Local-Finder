<%@page import="java.util.UUID"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page session="true"%>

<%
    UUID userId = (UUID) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("/login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport preca" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - Local Finder</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
        /* Enhanced Mobile Menu Styling */
        #mobile-menu {
            transition: max-height 0.3s ease-in-out, opacity 0.3s ease-in-out;
            max-height: 0;
            opacity: 0;
            overflow: hidden;
            background-color: #1e3a8a; /* Darker blue */
            border-bottom: 2px solid #facc15; /* Yellow accent */
        }
        #mobile-menu:not(.hidden) {
            max-height: 300px;
            opacity: 1;
        }
        #mobile-menu a {
            display: block;
            padding: 12px 0;
            font-size: 1.1rem;
            font-weight: 500;
            color: #ffffff;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        #mobile-menu a:hover {
            background-color: #2563eb; /* Lighter blue on hover */
            color: #facc15; /* Yellow text on hover */
        }
        /* Table Responsiveness */
        @media (max-width: 640px) {
            .booking-table {
                display: block;
            }
            .booking-table thead {
                display: none; /* Hide table header on mobile */
            }
            .booking-table tbody, .booking-table tr, .booking-table td {
                display: block;
                width: 100%;
            }
            .booking-table tr {
                margin-bottom: 1rem;
                border: 1px solid #d1d5db;
                border-radius: 8px;
                padding: 1rem;
                background-color: #f9fafb;
            }
            .booking-table td {
                padding: 0.5rem 0;
                border: none;
                position: relative;
            }
            .booking-table td::before {
                content: attr(data-label);
                font-weight: 600;
                color: #374151;
                display: block;
                margin-bottom: 0.25rem;
            }
        }
    </style>
</head>
<body class="bg-gray-100 min-h-screen">

    <!-- Navbar -->
    <nav class="bg-blue-700 text-white shadow-lg sticky top-0 z-10">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center py-4">
                <h1 class="text-2xl sm:text-3xl font-bold tracking-tight flex items-center">
                    <i class="fa-solid fa-home mr-2"></i> Urban Service
                </h1>
                <div class="hidden md:flex space-x-4">
                    <a href="loginuserhome" class="bg-white text-blue-700 px-4 py-2 rounded-lg hover:bg-gray-100 transition duration-300">Home</a>
                </div>
                <!-- Mobile Menu Button -->
                <button id="menu-btn" class="md:hidden text-white focus:outline-none">
                    <i class="fa-solid fa-bars text-2xl"></i>
                </button>
            </div>
            <!-- Mobile Menu -->
            <div id="mobile-menu" class="md:hidden hidden flex-col space-y-2 py-4 text-center">
                <a href="loginuserhome" class="hover:text-yellow-300 transition duration-300">Home</a>
            </div>
        </div>
    </nav>

    <!-- Booking List -->
    <section class="max-w-6xl mx-auto mt-8 sm:mt-12 px-4 sm:px-6 lg:px-8 bg-white rounded-2xl shadow-xl py-8">
        <h2 class="text-2xl sm:text-3xl font-bold text-blue-700 mb-6 text-center sm:text-left">My Booking History</h2>
        
        <c:choose>
            <c:when test="${not empty bookingList}">
                <div class="overflow-x-auto">
                    <table class="booking-table w-full border-collapse border border-gray-300">
                        <thead>
                            <tr class="bg-blue-600 text-white">
                                <th class="border border-gray-300 px-4 py-2 text-sm sm:text-base">Provider Name</th>
                                <th class="border border-gray-300 px-4 py-2 text-sm sm:text-base">Contact No</th>
                                <th class="border border-gray-300 px-4 py-2 text-sm sm:text-base">Service</th>
                                <th class="border border-gray-300 px-4 py-2 text-sm sm:text-base">Date</th>
                                <th class="border border-gray-300 px-4 py-2 text-sm sm:text-base">Price</th>
                                <th class="border border-gray-300 px-4 py-2 text-sm sm:text-base">Status</th>
                                <th class="border border-gray-300 px-4 py-2 text-sm sm:text-base">Payment</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="booking" items="${bookingList}">
                                <tr class="text-center">
                                    <td class="border border-gray-300 px-4 py-2 text-sm sm:text-base" data-label="Provider Name">${booking.serviceProvider.name}</td>
                                    <td class="border border-gray-300 px-4 py-2 text-sm sm:text-base" data-label="Contact No">${booking.serviceProvider.phone}</td>
                                    <td class="border border-gray-300 px-4 py-2 text-sm sm:text-base" data-label="Service">${booking.service.serviceName}</td>
                                    <td class="border border-gray-300 px-4 py-2 text-sm sm:text-base" data-label="Date">${booking.bookingDate}</td>
                                     <td class="border border-gray-300 px-4 py-2 text-sm sm:text-base" data-label="Date">${booking.packageEntity.price}</td>
                                    <td class="border border-gray-300 px-4 py-2 text-sm sm:text-base" data-label="Status">
                                        <c:choose>
                                            <c:when test="${booking.status eq 'ACCEPT'}">
                                                <span class="inline-block px-3 py-1 rounded-lg text-white bg-green-500">${booking.status}</span>
                                            </c:when>
                                            <c:when test="${booking.status eq 'REJECT'}">
                                                <span class="inline-block px-3 py-1 rounded-lg text-white bg-red-500">${booking.status}</span>
                                            </c:when>
                                            <c:when test="${booking.status eq 'PENDING'}">
                                                <span class="inline-block px-3 py-1 rounded-lg text-white bg-yellow-500">${booking.status}</span>
                                            </c:when>
                                            
                                        </c:choose>
                                    </td>
                                     <td class="border border-gray-300 px-4 py-2 text-sm sm:text-base" data-label="Action">
                                        <c:if test="${booking.status eq 'ACCEPT'}">
                                            <a href="/payment/${booking.bookingId}/${booking.packageEntity.packageId}" class="inline-block bg-green-600 text-white px-3 py-1 rounded-lg hover:bg-green-700 transition duration-300">Checkout</a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <p class="text-gray-600 text-center text-sm sm:text-base">You have no bookings yet.</p>
            </c:otherwise>
        </c:choose>
    </section>

    <!-- JavaScript for Mobile Menu -->
    <script>
        const menuBtn = document.getElementById('menu-btn');
        const mobileMenu = document.getElementById('mobile-menu');
        menuBtn.addEventListener('click', () => {
            mobileMenu.classList.toggle('hidden');
        });
    </script>
</body>
</html>