<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Service</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
        /* Toast Styling */
        .toast {
            visibility: hidden;
            min-width: 250px;
            background-color: #10b981; /* Green for success */
            color: white;
            text-align: center;
            border-radius: 8px;
            padding: 16px;
            position: fixed;
            z-index: 100;
            bottom: 30px;
            right: 30px;
            font-size: 16px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            opacity: 0;
            transition: opacity 0.3s ease-in-out, visibility 0s 0.3s;
        }
        .toast.show {
            visibility: visible;
            opacity: 1;
            transition: opacity 0.3s ease-in-out;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-indigo-100 via-purple-50 to-pink-100 flex items-center justify-center min-h-screen py-6">
    <div class="bg-white shadow-2xl rounded-2xl overflow-hidden w-full max-w-4xl mx-4 md:mx-0 flex flex-col md:flex-row transform hover:scale-105 transition-transform duration-300">
        <!-- Left Side: Service Details -->
        <div class="w-full md:w-1/2 p-6 md:p-8 flex flex-col items-center justify-center bg-gradient-to-b from-indigo-50 to-white">
            <div class="relative w-full">
                <img src="${serviceWcu.servicePicUrl}" alt="Service Image" class="w-full h-48 md:h-56 object-cover rounded-xl shadow-lg">
                <div class="absolute inset-0 bg-gradient-to-t from-gray-900/50 to-transparent rounded-xl"></div>
            </div>
            <h2 class="text-2xl md:text-3xl font-bold mt-4 md:mt-6 text-gray-800 text-center">Category: ${serviceWcu.category.categoryName}</h2>
            <p class="text-gray-600 mt-2 md:mt-3 text-center text-sm">Service: ${serviceWcu.serviceName}</p>
            <p class="text-gray-700 font-semibold mt-3 md:mt-4 text-sm md:text-base">
                Provider: <span class="text-indigo-600">${serviceWcu.userEntity.name}</span>
            </p>
            <p class="text-green-600 font-bold text-base md:text-lg mt-2 md:mt-3">Price: ${packages.price} INR</p>
        </div>

        <!-- Right Side: Booking Form -->
        <div class="w-full md:w-1/2 p-6 md:p-8 bg-white">
            <h2 class="text-2xl md:text-3xl font-bold text-center text-indigo-700">Book Your Service</h2>
            <p class="text-center text-gray-500 mt-2 text-sm">Fill in the details to confirm your booking</p>
            <form action="save/bookservice" method="post" class="space-y-4 md:space-y-6 mt-4 md:mt-6">
                <input type="hidden" name="serviceId" value="${serviceWcu.serviceId}">
                <c:set var="userId" value="${sessionScope.userId}" />
                <input type="hidden" name="userId" value="${userId}">
                <input type="hidden" name="providerId" value="${serviceWcu.userEntity.userId}">
                <input type="hidden" name="packageId" value="${packages.packageId}">
                
                <h1 class="text-sm md:text-base text-gray-600">User Id from Session: ${sessionScope.userId}</h1>
                <h1 class="text-sm md:text-base text-gray-600">Provider Id: ${serviceWcu.userEntity.userId}</h1>

                <div>
                    <label class="block font-semibold text-gray-700 text-sm md:text-base">Booking Date</label>
                    <input type="date" name="bookingDate" required class="w-full p-2 md:p-3 mt-1 border-none rounded-lg bg-gray-100 shadow-inner focus:ring-2 focus:ring-indigo-500 focus:outline-none transition-all duration-200 text-sm md:text-base">
                </div>

                <div>
                    <label class="block font-semibold text-gray-700 text-sm md:text-base">Booking Time</label>
                    <input type="time" name="bookingTime" required class="w-full p-2 md:p-3 mt-1 border-none rounded-lg bg-gray-100 shadow-inner focus:ring-2 focus:ring-indigo-500 focus:outline-none transition-all duration-200 text-sm md:text-base">
                </div>

                <button type="submit" class="w-full bg-gradient-to-r from-indigo-500 to-purple-600 text-white py-2 md:py-3 rounded-lg shadow-md hover:from-indigo-600 hover:to-purple-700 transition-all duration-300 font-semibold text-sm md:text-base">Confirm Booking</button>
            </form>

            <!-- Display Error Message if Any -->
            <c:if test="${not empty error}">
                <p class="text-red-500 mt-3 md:mt-4 text-center font-medium text-sm md:text-base">${error}</p>
            </c:if>
        </div>
    </div>

    <!-- Toast Notification -->
    <div id="toast" class="toast">
        Booking Confirmed Successfully!
    </div>

    <!-- JavaScript for Toast -->
    <script>
        // Check if booking was successful (assuming server redirects back with a 'success' parameter)
        const urlParams = new URLSearchParams(window.location.search);
        const toast = document.getElementById('toast');

        if (urlParams.get('success') === 'booking_confirmed') {
            toast.classList.add('show');
            setTimeout(() => {
                toast.classList.remove('show');
                // Optionally, clear the URL parameter after showing the toast
                window.history.replaceState({}, document.title, window.location.pathname);
            }, 3000); // Hide after 3 seconds
        }
    </script>
</body>
</html>