<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.grownited.entity.UserEntity" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    UUID entity = (UUID) session.getAttribute("userId");
    if (entity == null) {
        response.sendRedirect("/login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Service - Urban Service</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .fade-in {
            animation: fadeIn 0.6s ease-out forwards;
        }
        .hover-scale {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .hover-scale:hover {
            transform: scale(1.03);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
        input, textarea, select {
            transition: all 0.3s ease;
        }
        input:focus, textarea:focus, select:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3);
        }
    </style>
</head>
<body class="bg-gradient-to-br from-gray-50 to-blue-100 min-h-screen flex items-center justify-center p-4">

    <div class="max-w-3xl w-full mx-auto shadow-[0_2px_10px_-2px_rgba(59,130,246,0.5)] p-8 bg-white rounded-2xl fade-in">
        <!-- Header -->
        <div class="flex items-center justify-between mb-6">
            <h2 class="text-2xl font-bold text-blue-600">Add New Service</h2>
            <a href="/profile" class="text-blue-600 hover:text-blue-800 transition duration-300">
                <i class="fa-solid fa-arrow-left"></i> Back
            </a>
        </div>

        <!-- Form -->
        <form action="/addservice" method="post" enctype="multipart/form-data" class="grid grid-cols-2 gap-6">
            <!-- Service Name -->
            <div>
                <label class="block text-gray-700 font-semibold mb-2">Service Name</label>
                <input type="text" name="serviceName" required 
                       class="w-full px-4 py-3 bg-gray-50 text-gray-800 text-sm border border-gray-200 rounded-lg focus:bg-transparent focus:outline-none placeholder-gray-500" 
                       placeholder="e.g., Home Cleaning" />
            </div>

            <!-- Package Name -->
            <div>
                <label class="block text-gray-700 font-semibold mb-2">Package Name</label>
                <input type="text" name="packageName" required 
                       class="w-full px-4 py-3 bg-gray-50 text-gray-800 text-sm border border-gray-200 rounded-lg focus:bg-transparent focus:outline-none placeholder-gray-500" 
                       placeholder="e.g., Premium Cleaning Package" />
            </div>

            <!-- Category Dropdown -->
            <div>
                <label class="block text-gray-700 font-semibold mb-2">Category</label>
                <select name="categoryId" required 
                        class="w-full px-4 py-3 bg-gray-50 text-gray-800 text-sm border border-gray-200 rounded-lg focus:bg-transparent focus:outline-none">
                    <option value="" disabled selected>Select a category</option>
                    <c:forEach items="${categories}" var="category">
                        <option value="${category.categoryId}">${category.categoryName}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Price -->
            <div>
                <label class="block text-gray-700 font-semibold mb-2">Price</label>
                <input type="number" name="price" required step="0.01"
                       class="w-full px-4 py-3 bg-gray-50 text-gray-800 text-sm border border-gray-200 rounded-lg focus:bg-transparent focus:outline-none placeholder-gray-500" 
                       placeholder="Enter price (e.g., 199.99)" />
            </div>

            <!-- Service Photo Upload -->
            <div class="col-span-2">
                <label class="block text-gray-700 font-semibold mb-2">Upload Service Photo</label>
                <input type="file" name="servicePhoto" accept="image/*" required 
                       class="w-full px-4 py-3 bg-gray-50 text-gray-800 text-sm border border-gray-200 rounded-lg focus:bg-transparent focus:outline-none placeholder-gray-500" />
            </div>

            <!-- Description (Full Width) -->
            <div class="col-span-2">
                <label class="block text-gray-700 font-semibold mb-2">Description</label>
                <textarea name="description" required 
                          class="w-full px-4 py-3 bg-gray-50 text-gray-800 text-sm border border-gray-200 rounded-lg focus:bg-transparent focus:outline-none placeholder-gray-500" 
                          rows="4" placeholder="Describe your service..."></textarea>
            </div>

            <!-- Hidden Service Provider ID -->
            <input type="hidden" name="providerId" value="<%= entity %>">

            <!-- Submit Button (Full Width) -->
            <div class="col-span-2">
                <button type="submit" 
                        class="w-full py-3 px-4 text-sm tracking-wide text-white bg-blue-600 hover:bg-blue-700 rounded-lg transition duration-300 hover-scale">
                    <i class="fa-solid fa-plus mr-2"></i> Add Service
                </button>
            </div>
        </form>
    </div>

</body>
</html>
