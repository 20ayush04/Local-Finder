<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>About Us - Local Finder</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
  <style>
    /* Custom Animations */
    @keyframes fadeInUp {
      from { opacity: 0; transform: translateY(30px); }
      to { opacity: 1; transform: translateY(0); }
    }
    @keyframes fadeInLeft {
      from { opacity: 0; transform: translateX(-30px); }
      to { opacity: 1; transform: translateX(0); }
    }
    .animate-fadeInUp {
      animation: fadeInUp 0.8s ease-out forwards;
    }
    .animate-fadeInLeft {
      animation: fadeInLeft 0.8s ease-out forwards;
    }
    .hover-lift {
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .hover-lift:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
    }
  </style>
</head>
<body class="bg-gray-50 font-sans">
  <!-- Navigation -->
  <nav class="bg-gray-800 p-4 sticky top-0 z-10 shadow-lg">
    <div class="container mx-auto flex justify-between items-center">
      <div class="flex items-center">
        <a href="/home" class="text-white text-2xl font-bold hover:text-indigo-400 transition-colors duration-300">Local Finder</a>
      </div>
      <!-- Mobile menu button -->
      <div class="md:hidden">
        <button id="mobile-menu-button" class="text-white focus:outline-none">
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
              d="M4 6h16M4 12h16M4 18h16"></path>
          </svg>
        </button>
      </div>
      <!-- Desktop Menu -->
      <ul class="hidden md:flex space-x-6 items-center">
        <li><a href="aboutus" class="text-white hover:text-indigo-400 transition-colors duration-300">About</a></li>
        <!-- <li><a href="#" class="text-white hover:text-indigo-400 transition-colors duration-300">Services</a></li> -->
        <li><a href="contactus" class="text-white hover:text-indigo-400 transition-colors duration-300">Contact</a></li>
        <%
          UUID userId = (UUID) session.getAttribute("userId");
        %>
        <li>
          <% if (userId != null) { %>
            <a href="profile" class="text-white hover:text-indigo-400 transition-colors duration-300">
              <img src="data:image/png;base64,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" 
              alt="Profile" class="w-8 h-8 rounded-full inline">
            </a>
          <% } else { %>
            <a href="login" class="text-white hover:text-indigo-400 transition-colors duration-300">Login</a>
          <% } %>
        </li>
      </ul>
    </div>
    <!-- Mobile Navigation Menu -->
    <div id="mobile-menu" class="hidden md:hidden">
      <ul class="px-2 pt-2 pb-4 space-y-1 sm:px-3">
        <li>
          <a href="aboutus" class="block px-3 py-2 rounded-md text-base font-medium text-white hover:text-indigo-400">
            About
          </a>
        </li>
        <li>
          <a href="contactus" class="block px-3 py-2 rounded-md text-base font-medium text-white hover:text-indigo-400">
            Contact
          </a>
        </li>
        <li>
          <% if (userId != null) { %>
            <a href="profile" class="block px-3 py-2 rounded-md text-base font-medium text-white hover:text-indigo-400">
              Profile
            </a>
          <% } else { %>
            <a href="login" class="block px-3 py-2 rounded-md text-base font-medium text-white hover:text-indigo-400">
              Login
            </a>
          <% } %>
        </li>
      </ul>
    </div>
  </nav>

  <!-- Hero Section -->
  <section class="bg-gradient-to-r from-indigo-600 to-blue-500 text-white py-20">
    <div class="container mx-auto text-center animate-fadeInUp">
      <h1 class="text-5xl md:text-6xl font-extrabold mb-6">About Urban Service</h1>
      <p class="text-xl md:text-2xl max-w-3xl mx-auto">
        Empowering homes with seamless, on-demand services—connecting you to trusted professionals for all your needs.
      </p>
    </div>
  </section>

  <!-- About Us Content -->
  <section class="py-16 bg-white">
    <div class="container mx-auto px-4">
      <div class="grid grid-cols-1 md:grid-cols-3 gap-12 text-center">
        <div class="p-6 bg-gray-50 rounded-lg hover-lift animate-fadeInUp" style="animation-delay: 0.2s;">
          <h2 class="text-2xl font-semibold text-gray-800 mb-4">Our Vision</h2>
          <p class="text-gray-600">
            To revolutionize the home service industry by becoming the go-to platform for convenience, trust, and excellence, delivering unparalleled customer experiences worldwide.
          </p>
        </div>
        <div class="p-6 bg-gray-50 rounded-lg hover-lift animate-fadeInUp" style="animation-delay: 0.4s;">
          <h2 class="text-2xl font-semibold text-gray-800 mb-4">Our Mission</h2>
          <p class="text-gray-600">
            We strive to simplify your life by connecting you with skilled, verified professionals for services like plumbing, electrical work, beauty care, and more—all at your fingertips.
          </p>
        </div>
        <div class="p-6 bg-gray-50 rounded-lg hover-lift animate-fadeInUp" style="animation-delay: 0.6s;">
          <h2 class="text-2xl font-semibold text-gray-800 mb-4">Our Values</h2>
          <p class="text-gray-600">
            Built on trust, quality, and innovation, we prioritize your satisfaction with every service, ensuring reliability and professionalism every step of the way.
          </p>
        </div>
      </div>
    </div>
  </section>

  <!-- Team Section -->
  <section class="py-16 bg-gray-100">
    <div class="container mx-auto px-4 text-center">
      <h2 class="text-4xl font-bold text-gray-800 mb-12 animate-fadeInUp">Meet Our Team</h2>
      <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-8">
        <div class="p-6 bg-white rounded-lg shadow-md hover-lift animate-fadeInUp" style="animation-delay: 0.2s;">
          <img src="https://via.placeholder.com/150" alt="Team Member" class="w-32 h-32 rounded-full mx-auto mb-4">
          <h3 class="text-xl font-semibold text-gray-800">Jane Doe</h3>
          <p class="text-gray-600">Founder &amp; CEO</p>
        </div>
        <div class="p-6 bg-white rounded-lg shadow-md hover-lift animate-fadeInUp" style="animation-delay: 0.4s;">
          <img src="https://via.placeholder.com/150" alt="Team Member" class="w-32 h-32 rounded-full mx-auto mb-4">
          <h3 class="text-xl font-semibold text-gray-800">John Smith</h3>
          <p class="text-gray-600">Chief Operations Officer</p>
        </div>
        <div class="p-6 bg-white rounded-lg shadow-md hover-lift animate-fadeInUp" style="animation-delay: 0.6s;">
          <img src="https://via.placeholder.com/150" alt="Team Member" class="w-32 h-32 rounded-full mx-auto mb-4">
          <h3 class="text-xl font-semibold text-gray-800">Emily Brown</h3>
          <p class="text-gray-600">Head of Customer Success</p>
        </div>
      </div>
    </div>
  </section>

  <!-- Footer -->
  <footer class="bg-indigo-600 py-8 text-white">
    <div class="container mx-auto text-center">
      <p class="text-lg">© 2025 Urban Service. All rights reserved.</p>
      <div class="mt-4 flex justify-center space-x-6">
        <a href="#" class="hover:text-indigo-200 transition-colors duration-300">Privacy Policy</a>
        <a href="#" class="hover:text-indigo-200 transition-colors duration-300">Terms of Service</a>
        <a href="contactus" class="hover:text-indigo-200 transition-colors duration-300">Contact Us</a>
      </div>
    </div>
  </footer>

  <!-- Mobile Menu Toggle Script -->
  <script>
    document.getElementById('mobile-menu-button').addEventListener('click', function() {
      var mobileMenu = document.getElementById('mobile-menu');
      mobileMenu.classList.toggle('hidden');
    });
  </script>
</body>
</html>
