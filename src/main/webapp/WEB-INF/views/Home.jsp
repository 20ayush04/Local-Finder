
<%@page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Local Finder - Home</title>
<link
	href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
	rel="stylesheet">
<style>
/* Custom Animations */
@
keyframes fadeInUp {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
@
keyframes bounce { 0%, 100% {
	transform: translateY(0);
}

50


%
{
transform


:


translateY
(


-10px


)
;


}
}
@
keyframes slideInLeft {from { opacity:0;
	transform: translateX(-30px);
}

to {
	opacity: 1;
	transform: translateX(0);
}

}
@
keyframes pulse { 0% {
	transform: scale(1);
}

50


%
{
transform


:


scale
(


1
.05


)
;


}
100


%
{
transform


:


scale
(


1


)
;


}
}
@
keyframes fromTopLeft {from { opacity:0;
	transform: translate(-100px, -100px);
}

to {
	opacity: 1;
	transform: translate(0, 0);
}

}
@
keyframes fromBottomRight {from { opacity:0;
	transform: translate(100px, 100px);
}

to {
	opacity: 1;
	transform: translate(0, 0);
}

}
@
keyframes fromTopRight {from { opacity:0;
	transform: translate(100px, -100px);
}

to {
	opacity: 1;
	transform: translate(0, 0);
}

}
.animate-fade-in-up {
	animation: fadeInUp 1s ease-out;
}

.animate-bounce {
	animation: bounce 2s infinite;
}

.animate-slide-in-left {
	animation: slideInLeft 1s ease-out;
}

.animate-pulse {
	animation: pulse 2s infinite;
}

.animate-from-top-left {
	animation: fromTopLeft 1s ease-out;
}

.animate-from-bottom-right {
	animation: fromBottomRight 1s ease-out;
}

.animate-from-top-right {
	animation: fromTopRight 1s ease-out;
}

/* Make html and body full height */
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

/* Responsive adjustments */
@media ( max-width : 768px) {
	.nav-links {
		display: none; /* Hide nav links on mobile */
	}
	.hero-text {
		font-size: 2.5rem !important; /* Smaller hero text on mobile */
	}
	.service-card img {
		height: 150px !important; /* Adjust image height on mobile */
	}
}

@media ( max-width : 640px) {
	.hero-text {
		font-size: 2rem !important;
	}
	.cta-button {
		padding: 0.75rem 1.5rem !important;
		font-size: 1rem !important;
	}
}

.line-clamp-2 {
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
}
</style>
</head>
<body
	class=" text-gray-900 min-h-screen">
	<!-- Navbar -->
<nav class=" bg-gray-900 text-white p-4 sticky top-0 z-20 shadow-xl">
    <div class="container mx-auto flex justify-between items-center flex-wrap">
        <!-- Logo -->
        <a href="/home" class="text-3xl font-bold tracking-tight bg-clip-text  transition-all duration-300 hover:scale-105">
            LocalFinder
        </a>

        <!-- Hamburger Menu for Mobile -->
        <button class="md:hidden text-white focus:outline-none" id="nav-toggle" aria-label="Toggle navigation">
            <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16m-7 6h7"></path>
            </svg>
        </button>

        <!-- Navigation Links -->
        <div class="nav-links hidden md:flex items-center space-x-8 text-lg transition-all duration-300" id="nav-menu">
         <!--    <a href="#services" class="relative px-3 py-1 rounded-md hover:text-white hover:bg-indigo-500/20 transition-all duration-300 ease-in-out group">
                Services
                <span class="absolute bottom-0 left-0 w-full h-0.5 bg-white transform scale-x-0 group-hover:scale-x-100 transition-transform duration-300 ease-in-out"></span>
            </a>  -->
            <a href="aboutus" class="relative px-3 py-1 rounded-md hover:text-white hover:bg-indigo-500/20 transition-all duration-300 ease-in-out group">
                About
                <span class="absolute bottom-0 left-0 w-full h-0.5 bg-white transform scale-x-0 group-hover:scale-x-100 transition-transform duration-300 ease-in-out"></span>
            </a>
            <a href="contactus" class="relative px-3 py-1 rounded-md hover:text-white hover:bg-indigo-500/20 transition-all duration-300 ease-in-out group">
                Contact
                <span class="absolute bottom-0 left-0 w-full h-0.5 bg-white transform scale-x-0 group-hover:scale-x-100 transition-transform duration-300 ease-in-out"></span>
            </a>
            <a href="login" class="px-4 py-2 bg-white text-indigo-600 rounded-lg font-semibold shadow-md hover:bg-indigo-100 hover:text-indigo-700 transition-all duration-300 ease-in-out transform hover:-translate-y-1">
                Login
            </a>
        </div>
    </div>

    <!-- Mobile Menu (Hidden by default) -->
    <div class="md:hidden hidden flex-col space-y-4 mt-4 bg-indigo-700/90 p-4 rounded-lg shadow-lg" id="mobile-menu">
        <a href="#services" class="px-3 py-2 hover:bg-indigo-600 rounded-md transition-all duration-300">Services</a>
        <a href="aboutus" class="px-3 py-2 hover:bg-indigo-600 rounded-md transition-all duration-300">About</a>
        <a href="contactus" class="px-3 py-2 hover:bg-indigo-600 rounded-md transition-all duration-300">Contact</a>
        <a href="login" class="px-3 py-2 bg-white text-indigo-600 rounded-md font-semibold hover:bg-indigo-100 transition-all duration-300">Login</a>
    </div>
</nav>
	<!-- Hero Section -->
	<section id="home"
		class="min-h-screen bg-gradient-to-b from-teal-500 to-indigo-700 text-white py-28 relative flex items-center"
		style="background-image: url('https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80'); background-size: cover; background-position: center;">
		<div class="absolute inset-0 bg-black opacity-50"></div>
		<div class="container mx-auto text-center relative z-10 px-4">
			<h2
				class="hero-text text-5xl md:text-6xl font-extrabold mb-6 animate-fade-in-up ">Welcome
				to UrbanService</h2>
			<p
				class="text-xl md:text-2xl mb-8 animate-fade-in-up animation-delay-200">Your
				one-stop solution for all urban needs</p>
			<a href="/login"
				class=" bg-gray-300 text-black px-8 py-4 rounded-full font-bold text-lg hover:bg-gray-900 hover:text-white transition transform hover:scale-105 animate-pulse inline-block">Get
				Started</a>
		</div>
	</section>

	<!-- Features Section (Why Us) -->
	<section id="why-us"
		class="py-20 bg-gradient-to-r from-indigo-100 to-teal-100">
		<div class="container mx-auto text-center px-4">
			<h3
				class="text-4xl font-bold mb-12 text-indigo-600 animate-fade-in-up">Why
				Choose Us?</h3>
			<div class="grid grid-cols-1 md:grid-cols-3 gap-10">
				<div class="p-6 animate-slide-in-left">
					<h4 class="text-2xl font-semibold mb-3 text-teal-600">Reliable
						Services</h4>
					<p class="text-gray-700">We provide fast and reliable urban
						services tailored to your needs.</p>
				</div>
				<div class="p-6 animate-fade-in-up animation-delay-200">
					<h4 class="text-2xl font-semibold mb-3 text-teal-600">Expert
						Team</h4>
					<p class="text-gray-700">Our team is experienced and ready to
						assist you with any task in the city.</p>
				</div>
				<div class="p-6 animate-slide-in-left animation-delay-400">
					<h4 class="text-2xl font-semibold mb-3 text-teal-600">Affordable
						Rates</h4>
					<p class="text-gray-700">We offer competitive pricing for all
						urban services, so you can save more.</p>
				</div>
			</div>
		</div>
	</section>
	<!-- List of categories -->
	<div class="max-w-6xl mx-auto py-10 px-4">
		<h1 class="text-3xl font-bold text-gray-800 mb-8 text-center">Service
			Categories</h1>

		<!-- Categories Grid -->
		<div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6">
			<c:forEach var="category" items="${requestScope.categories}">
				<div
					class="bg-white rounded-lg shadow-lg overflow-hidden hover:scale-105 transition transform duration-300">
					<!-- Category Image -->
					<img src="${category.categoryPicUrl}"
						alt="${category.categoryName}"
						class="w-full h-48 object-fit object-center" />

					<!-- Category Details -->
					<div class="p-5">
						<h3 class="text-xl font-semibold text-gray-800">${category.categoryName}</h3>

						<!-- Description (Initially 2 Lines) -->
						<p class="text-gray-600 text-sm mt-2 line-clamp-2 overflow-hidden"
							id="desc-${category.categoryId}">
							${category.categoryDescription}</p>

						<!-- See More / See Less Button -->
						<button onclick="toggleDescription(${category.categoryId})"
							class="text-blue-500 text-sm mt-1 focus:outline-none"
							id="btn-${category.categoryId}">See More</button>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>



	<!-- Call to Action Section -->
	<section id="cta"
		class="bg-gray-900 text-white py-20">
		<div class="container mx-auto text-center px-4">
			<h3 class="text-4xl font-bold mb-6 animate-fade-in-up">Join Us
				Today</h3>
			<p class="text-xl mb-8 animate-fade-in-up animation-delay-200">Start
				benefiting from our premium urban services now!</p>
			<a href="/signup"
				class="bg-gray-200 text-black px-8 py-4 rounded-full font-bold text-lg  transition transform hover:scale-105 animate-pulse inline-block">Create
				an Account</a>
		</div>
	</section>
<!-- Footer -->
<footer class="bg-gray-900 text-white py-12">
    <div class="container mx-auto px-6 md:px-12 lg:px-20">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-12">
            
            <!-- Branding Section -->
            <div class="space-y-4 text-center md:text-left">
                <a href="/" class="flex items-center justify-center md:justify-start">
                    <h2 class="text-3xl font-bold text-teal-400 tracking-tight">UrbanService</h2>
                </a>
                <p class="text-gray-300 text-sm leading-relaxed">
                    Empowering communities by connecting you with top-tier local professionals for seamless service experiences.
                </p>
            </div>
            
            <!-- Quick Links Section -->
            <nav class="space-y-4 text-center md:text-left">
                <h3 class="text-xl font-semibold text-teal-300">Quick Links</h3>
                <ul class="space-y-3 text-sm">
                    <li>
                        <a href="/" class="text-gray-300 hover:text-teal-400 transition-colors duration-300 ease-in-out focus:outline-none focus:ring-2 focus:ring-teal-500 focus:ring-opacity-50">Home</a>
                    </li>
                    <li>
                        <a href="/services" class="text-gray-300 hover:text-teal-400 transition-colors duration-300 ease-in-out focus:outline-none focus:ring-2 focus:ring-teal-500 focus:ring-opacity-50">Services</a>
                    </li>
                    <li>
                        <a href="/about" class="text-gray-300 hover:text-teal-400 transition-colors duration-300 ease-in-out focus:outline-none focus:ring-2 focus:ring-teal-500 focus:ring-opacity-50">About Us</a>
                    </li>
                    <li>
                        <a href="/contact" class="text-gray-300 hover:text-teal-400 transition-colors duration-300 ease-in-out focus:outline-none focus:ring-2 focus:ring-teal-500 focus:ring-opacity-50">Contact</a>
                    </li>
                </ul>
            </nav>

            <!-- Social & Contact Section -->
            <div class="space-y-4 text-center md:text-right">
                <h3 class="text-xl font-semibold text-teal-300">Get in Touch</h3>
                <div class="flex justify-center md:justify-end space-x-6">
                    <a href="https://facebook.com" target="_blank" rel="noopener noreferrer" class="text-gray-300 hover:text-teal-400 transition-transform duration-300 ease-in-out transform hover:scale-110 focus:outline-none focus:ring-2 focus:ring-teal-500 focus:ring-opacity-50" aria-label="Facebook">
                        <i class="fab fa-facebook-f fa-lg"></i>
                    </a>
                    <a href="https://twitter.com" target="_blank" rel="noopener noreferrer" class="text-gray-300 hover:text-teal-400 transition-transform duration-300 ease-in-out transform hover:scale-110 focus:outline-none focus:ring-2 focus:ring-teal-500 focus:ring-opacity-50" aria-label="Twitter">
                        <i class="fab fa-twitter fa-lg"></i>
                    </a>
                    <a href="https://instagram.com" target="_blank" rel="noopener noreferrer" class="text-gray-300 hover:text-teal-400 transition-transform duration-300 ease-in-out transform hover:scale-110 focus:outline-none focus:ring-2 focus:ring-teal-500 focus:ring-opacity-50" aria-label="Instagram">
                        <i class="fab fa-instagram fa-lg"></i>
                    </a>
                    <a href="https://linkedin.com" target="_blank" rel="noopener noreferrer" class="text-gray-300 hover:text-teal-400 transition-transform duration-300 ease-in-out transform hover:scale-110 focus:outline-none focus:ring-2 focus:ring-teal-500 focus:ring-opacity-50" aria-label="LinkedIn">
                        <i class="fab fa-linkedin-in fa-lg"></i>
                    </a>
                </div>
                <div class="space-y-2 text-sm">
                    <p class="text-gray-300">
                        Email: <a href="mailto:support@urbanservice.com" class="hover:text-teal-400 transition-colors duration-300 ease-in-out focus:outline-none focus:ring-2 focus:ring-teal-500 focus:ring-opacity-50">support@urbanservice.com</a>
                    </p>
                    <p class="text-gray-300">Phone: <a href="tel:+15551234567" class="hover:text-teal-400 transition-colors duration-300 ease-in-out focus:outline-none focus:ring-2 focus:ring-teal-500 focus:ring-opacity-50">+1 (555) 123-4567</a></p>
                </div>
            </div>

        </div>

        <hr class="border-gray-600 my-10">

        <div class="text-center text-gray-400 text-sm">
            © <span id="currentYear"></span> UrbanService. All rights reserved.
        </div>
    </div>
</footer>

<!-- FontAwesome for Icons (Replace YOUR_KIT_CODE with your actual FontAwesome Kit Code) -->
<script src="https://kit.fontawesome.com/YOUR_KIT_CODE.js" crossorigin="anonymous" async></script>

<!-- JavaScript for Dynamic Year -->
<script>
    document.addEventListener('DOMContentLoaded', () => {
        document.getElementById('currentYear').textContent = new Date().getFullYear();
    });
</script>
	<script>
function toggleDescription(categoryId) {
    let desc = document.getElementById("desc-" + categoryId);
    let btn = document.getElementById("btn-" + categoryId);
    if (desc.classList.contains("line-clamp-2")) {
        desc.classList.remove("line-clamp-2");
        btn.innerText = "See Less";
    } else {
        desc.classList.add("line-clamp-4");
        btn.innerText = "See More";
    }
}

<!-- JavaScript for Hamburger Menu Toggle -->

    const navToggle = document.getElementById('nav-toggle');
    const mobileMenu = document.getElementById('mobile-menu');

    navToggle.addEventListener('click', () => {
        mobileMenu.classList.toggle('hidden');
    });


</script>

</body>

</html>