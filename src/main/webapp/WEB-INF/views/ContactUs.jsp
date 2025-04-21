<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Local Finder</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Custom animations */
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeInLeft {
            from { opacity: 0; transform: translateX(-20px); }
            to { opacity: 1; transform: translateX(0); }
        }
        .animate-fadeInUp {
            animation: fadeInUp 0.6s ease-out forwards;
        }
        .animate-fadeInLeft {
            animation: fadeInLeft 0.6s ease-out forwards;
        }
        input:focus, textarea:focus {
            transition: all 0.3s ease;
        }
        .btn-hover {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .btn-hover:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen flex items-center justify-center">
    <div class="container mx-auto px-4 py-16 max-w-6xl">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-12 items-center">
            <!-- Left Side Content -->
            <div class="text-center md:text-left space-y-6 animate-fadeInLeft">
                <h1 class="text-5xl font-extrabold text-gray-900 leading-tight">
                    Let's Connect!
                </h1>
                <p class="text-lg text-gray-600 max-w-md mx-auto md:mx-0">
                    Have a question or need assistance? Reach out to Urban Service today, and let’s make things happen.
                </p>
                <!-- Image Section -->
                <img 
                    src="<%= request.getContextPath() %>/images/contact-illustration.png" 
                    alt="Urban Service Illustration" 
                    class="mt-8 w-full md:w-4/5 mx-auto md:mx-0 rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300"
                    onerror="this.src='https://via.placeholder.com/400x300?text=Image+Not+Found'; this.onerror=null;"
                >
            </div>

            <!-- Right Side Form -->
            <div class="bg-white p-8 rounded-xl shadow-2xl animate-fadeInUp">
                <form action="/user/contactus" method="post" class="space-y-6">
                    <div>
                        <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Your Name</label>
                        <input 
                            type="text" 
                            name="name" 
                            id="name" 
                            placeholder="Enter your name" 
                            class="w-full p-4 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent bg-gray-50 transition-all duration-300" 
                            required
                        >
                    </div>
                    <div>
                        <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
                        <input 
                            type="email" 
                            name="email" 
                            id="email" 
                            placeholder="Enter your email" 
                            class="w-full p-4 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent bg-gray-50 transition-all duration-300" 
                            required
                        >
                    </div>
                    <div>
                        <label for="subject" class="block text-sm font-medium text-gray-700 mb-1">Subject</label>
                        <input 
                            type="text" 
                            name="subject" 
                            id="subject" 
                            placeholder="What’s on your mind?" 
                            class="w-full p-4 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent bg-gray-50 transition-all duration-300" 
                            required
                        >
                    </div>
                    <div>
                        <label for="message" class="block text-sm font-medium text-gray-700 mb-1">Message</label>
                        <textarea 
                            name="message" 
                            id="message" 
                            placeholder="Write your message here..." 
                            rows="5" 
                            class="w-full p-4 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent bg-gray-50 transition-all duration-300 resize-none" 
                            required
                        ></textarea>
                    </div>
                    <button 
                        type="submit" 
                        class="w-full bg-indigo-600 text-white p-4 rounded-lg font-semibold btn-hover focus:outline-none focus:ring-2 focus:ring-indigo-700 focus:ring-offset-2"
                    >
                        Send Message
                    </button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>