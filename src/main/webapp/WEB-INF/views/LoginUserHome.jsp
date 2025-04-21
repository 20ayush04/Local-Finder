<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%
UUID user = (UUID) session.getAttribute("userId");
if (user == null) {
    response.sendRedirect("/login");
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Local Finder Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        .line-clamp-2 {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        body {
            font-family: 'Poppins', sans-serif;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        .fade-in-up {
            animation: fadeInUp 0.8s ease-out forwards;
        }
        .hover-scale {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .hover-scale:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
            animation: pulse 1.5s infinite;
        }
        .how-it-works-card {
            transition: background-color 0.3s ease;
        }
        .how-it-works-card:hover {
            background-color: #eff6ff;
        }
        .main-section {
            background-image: url('https://source.unsplash.com/1600x900/?home,services');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            position: relative;
            z-index: 1;
        }
        .main-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.4);
            z-index: -1;
        }
        /* Enhanced Mobile Menu Styling */
        #mobile-menu {
            transition: max-height 0.3s ease-in-out, opacity 0.3s ease-in-out;
            max-height: 0;
            opacity: 0;
            overflow: hidden;
            background-color: #1e3a8a; /* Darker blue to match navbar */
            border-bottom: 2px solid #facc15; /* Yellow accent */
        }
        #mobile-menu:not(.hidden) {
            max-height: 300px; /* Adjust based on content height */
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
        #mobile-menu .bg-red-600 {
            margin: 0 auto;
            width: fit-content;
            padding: 8px 20px;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-gray-50 to-blue-100 min-h-screen">

    <!-- Navbar -->
    <nav class="bg-gray-900 text-white shadow-lg sticky top-0 z-10">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center py-4">
                <h1 class="main-tag text-2xl sm:text-3xl font-bold tracking-tight flex items-center">
                     Local Finder
                </h1>
                <div class="hidden md:flex space-x-6 text-lg">
                    <a href="#" class="hover:text-yellow-300 transition duration-300">Home</a>
                    <a href="#categories" class="hover:text-yellow-300 transition duration-300">Categories</a>
                </div>
                <div class="hidden md:flex items-center space-x-4">
                    <a href="/profile" class="flex items-center space-x-2 hover:text-yellow-300 transition duration-300">
                        <i class="fa-solid fa-user"></i>
                        <span>Profile</span>
                    </a>
                    <a href="/bookinghistoryuser" class="flex items-center space-x-2 hover:text-yellow-300 transition duration-300">
                        <i class="fa-solid fa-calendar-check"></i>
                        <span>My Bookings</span>
                    </a>
                    <a href="/logout" class="bg-red-600 px-4 py-2 rounded-full hover:bg-red-700 transition duration-300 shadow-md">Logout</a>
                </div>
                <!-- Mobile Menu Button -->
                <button id="menu-btn" class="md:hidden text-white focus:outline-none">
                    <i class="fa-solid fa-bars text-2xl"></i>
                </button>
            </div>
            <!-- Mobile Menu -->
            <div id="mobile-menu" class="md:hidden hidden flex-col space-y-2 py-4 text-center">
                <a href="#" class="hover:text-yellow-300 transition duration-300">Home</a>
                <a href="#categories" class="hover:text-yellow-300 transition duration-300">Categories</a>
                <a href="/profile" class="hover:text-yellow-300 transition duration-300">Profile</a>
                <a href="/bookinghistoryuser" class="hover:text-yellow-300 transition duration-300">My Bookings</a>
                <a href="/logout" class="bg-red-600 px-4 py-2 rounded-full hover:bg-red-700 transition duration-300 inline-block">Logout</a>
            </div>
        </div>
    </nav>

    <!-- Main Section -->
 <main class="main-section text-white h-screen relative overflow-hidden"
    style="background-image: url('https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80'); background-size: cover; background-position: center;">

    <!-- Overlay for dimming background -->
    <div class="absolute inset-0 bg-black opacity-10"></div>

    <!-- Content stays on top -->
    <div class="relative max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 h-full flex items-center">
        <section class="fade-in-up text-left">
            <h2 class="text-3xl sm:text-4xl md:text-5xl font-bold mb-4">Welcome Back!</h2>
            <p class="text-lg sm:text-xl leading-relaxed max-w-2xl">
                Your one-stop solution for home services. Connect with verified professionals for plumbing, electrical work, salon services, and more—all at your fingertips.
            </p>
            <a href="#categories"
                class="mt-6 inline-block bg-gray-900 text-white px-6 py-3 rounded-full 
                       hover:bg-gray-300 hover:text-black transition duration-300 
                       hover-scale text-base sm:text-lg">
                Explore Services
            </a>
        </section>
    </div>
</main>





    <!-- Stats Section -->
    <section class="max-w-6xl mx-auto mt-8   sm:mt-12 px-4 sm:px-6 lg:px-8 bg-white rounded-2xl shadow-xl grid grid-cols-1 sm:grid-cols-2 gap-6 text-center fade-in-up" style="animation-delay: 0.2s;">
        <div class="hover-scale p-4 ">
            <h3 class="text-3xl sm:text-4xl font-bold text-black">10,000+</h3>
            <p class="text-gray-600 text-base sm:text-lg mt-2">Happy Customers</p>
        </div>
        <div class="hover-scale p-4">
            <h3 class="text-3xl sm:text-4xl font-bold text-black">5,000+</h3>
            <p class="text-gray-600 text-base sm:text-lg mt-2">Service Providers</p>
        </div>
    </section>

    <!-- How It Works Section -->
    <section class="max-w-6xl mx-auto mt-8 sm:mt-12 px-4 sm:px-6 lg:px-8 bg-white rounded-2xl shadow-xl fade-in-up" style="animation-delay: 0.4s;">
        <h2 class="text-2xl sm:text-3xl font-bold text-gray-900  mb-6 text-center ">How It Works</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6">
            <div class="how-it-works-card p-4 sm:p-6 rounded-lg text-center">
                <img src="https://images.pexels.com/photos/3184291/pexels-photo-3184291.jpeg?auto=compress&cs=tinysrgb&w=400&h=300&dpr=1" class="w-full h-32 sm:h-40 object-cover rounded-lg mb-4" alt="Person searching for services">
                <h3 class="text-lg sm:text-xl font-semibold text-gray-800">1. Search</h3>
                <p class="text-gray-600 text-sm sm:text-base mt-2">Find the service you need from our wide range of categories.</p>
            </div>
            <div class="how-it-works-card p-4 sm:p-6 rounded-lg text-center">
                <img src="https://images.pexels.com/photos/3182834/pexels-photo-3182834.jpeg?auto=compress&cs=tinysrgb&w=400&h=300&dpr=1" class="w-full h-32 sm:h-40 object-cover rounded-lg mb-4" alt="Person booking an appointment">
                <h3 class="text-lg sm:text-xl font-semibold text-gray-800">2. Book</h3>
                <p class="text-gray-600 text-sm sm:text-base mt-2">Schedule with a trusted professional at your convenience.</p>
            </div>
            <div class="how-it-works-card p-4 sm:p-6 rounded-lg text-center">
                <img src="https://images.pexels.com/photos/3756681/pexels-photo-3756681.jpeg?auto=compress&cs=tinysrgb&w=400&h=300&dpr=1" class="w-full h-32 sm:h-40 object-cover rounded-lg mb-4" alt="Person relaxing">
                <h3 class="text-lg sm:text-xl font-semibold text-gray-800">3. Enjoy</h3>
                <p class="text-gray-600 text-sm sm:text-base mt-2">Relax while our experts deliver top-notch service.</p>
            </div>
        </div>
    </section>

    <!-- Categories Section -->
    <div class="max-w-6xl mx-auto py-8 sm:py-10 px-4 sm:px-6 lg:px-8" id="categories">
        <h1 class="text-2xl sm:text-3xl font-bold text-gray-800 mb-6 text-center">Service Categories</h1>
        <div class="mb-6 flex justify-center">
            <div class="relative w-full max-w-md">
                <input type="text" id="categorySearch" placeholder="Search categories..." class="w-full p-3 pl-10 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm sm:text-base" onkeyup="filterCategories()">
                <i class="fa-solid fa-magnifying-glass absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500"></i>
            </div>
        </div>
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6" id="categoryGrid">
            <c:forEach var="category" items="${categories}">
                <a href="/categorydetails?categoryId=${category.categoryId}" class="w-full category-card">
                    <div class="bg-white rounded-lg shadow-lg overflow-hidden hover:scale-105 transition transform duration-300">
                        <img src="${category.categoryPicUrl}" alt="${category.categoryName}" class="w-full h-40 sm:h-48 object-cover object-center">
                        <div class="p-4 sm:p-5">
                            <h3 class="text-lg sm:text-xl font-semibold text-gray-800">${category.categoryName}</h3>
                            <p class="text-gray-600 text-sm mt-2 line-clamp-2 overflow-hidden" id="desc-${category.categoryId}">${category.categoryDescription}</p>
                            <button type="button" class="text-blue-500 mt-2 text-sm sm:text-base" onclick="toggleDescription('${category.categoryId}')">See More</button>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>

    <!-- Testimonials Section -->
    <section class="max-w-6xl mx-auto mt-8 sm:mt-12 px-4 sm:px-6 lg:px-8 bg-white rounded-2xl shadow-xl fade-in-up" style="animation-delay: 1s;">
        <h2 class="text-2xl sm:text-3xl font-bold text-gray-900 mb-6 text-center ">What Our Users Say</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
            <div class="bg-gray-50 p-4 sm:p-6 rounded-lg hover-scale">
                <p class="text-gray-600 italic text-sm sm:text-base">"The electrician arrived on time and fixed everything perfectly. Highly recommend!"</p>
                <p class="text-gray-800 font-semibold mt-4 text-sm sm:text-base">- Priya Sharma</p>
            </div>
            <div class="bg-gray-50 p-4 sm:p-6 rounded-lg hover-scale">
                <p class="text-gray-600 italic text-sm sm:text-base">"Booking a cleaner was so easy, and my house has never looked better!"</p>
                <p class="text-gray-800 font-semibold mt-4 text-sm sm:text-base">- Rohan Patel</p>
            </div>
        </div>
    </section>

    <!-- Quick Booking Button (Floating) -->
    <a href="#" class="fixed bottom-6 right-6 bg-gray-900 text-white px-4 sm:px-6 py-2 sm:py-3 rounded-full shadow-lg hover:bg-gray-300  hover:text-black transition duration-300 hover-scale flex items-center space-x-2 z-20 text-sm sm:text-base">
        <i class="fa-solid fa-calendar-check"></i>
        <span>Quick Book</span>
    </a>

    <!-- Footer -->
    <footer class="bg-gray-900 text-white text-center py-6 mt-12">
        <p class="text-xs sm:text-sm">© 2025 Urban Service. All Rights Reserved.</p>
    </footer>

    <!-- JavaScript -->
    <script>
        // Toggle Mobile Menu
        const menuBtn = document.getElementById('menu-btn');
        const mobileMenu = document.getElementById('mobile-menu');
        menuBtn.addEventListener('click', () => {
            mobileMenu.classList.toggle('hidden');
        });

        // Toggle Description
        function toggleDescription(categoryId) {
            var desc = document.getElementById("desc-" + categoryId);
            var button = event.target;
            if (desc.classList.contains("line-clamp-2")) {
                desc.classList.remove("line-clamp-2", "overflow-hidden");
                button.innerText = "Hide";
            } else {
                desc.classList.add("line-clamp-2", "overflow-hidden");
                button.innerText = "See More";
            }
        }

        // Filter Categories
        function filterCategories() {
            var input = document.getElementById("categorySearch").value.toLowerCase();
            var cards = document.getElementsByClassName("category-card");
            for (var i = 0; i < cards.length; i++) {
                var card = cards[i];
                var name = card.querySelector("h3").innerText.toLowerCase();
                var desc = card.querySelector("p").innerText.toLowerCase();
                if (name.includes(input) || desc.includes(input)) {
                    card.style.display = "block";
                } else {
                    card.style.display = "none";
                }
            }
        }
    </script>
</body>
</html>