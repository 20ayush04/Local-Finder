<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Category</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen flex flex-col items-center justify-center">

    <!-- Edit Category Form -->
    <div class="w-full max-w-md p-8 bg-white shadow-md rounded-lg">
        <h2 class="text-2xl font-bold text-center text-gray-800 mb-6">Edit Category</h2>
        
        <form action="/updatecategory" method="post" enctype="multipart/form-data">
            <!-- Hidden field to store category ID -->
            <input type="hidden" name="categoryId" value="${category.categoryId}">

            <!-- Category Name -->
            <div class="mb-4">
                <label for="categoryName" class="block text-gray-700 font-bold mb-2">Category Name:</label>
                <input type="text" id="categoryName" name="categoryName" required 
                       value="${category.categoryName}"
                       class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>

            <!-- Category Description -->
            <div class="mb-4">
                <label for="categoryDescription" class="block text-gray-700 font-bold mb-2">Category Description:</label>
                <textarea id="categoryDescription" name="categoryDescription" rows="4" required 
                          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">${category.categoryDescription}</textarea>
            </div>

            <!-- Display Existing Category Image -->
            <div class="mb-4">
                <label class="block text-gray-700 font-bold mb-2">Current Image:</label>
                <c:if test="${not empty category.categoryPicUrl}">
                    <img src="${category.categoryPicUrl}" alt="Category Image" class="w-full h-40 object-cover rounded-md border border-gray-300">
                </c:if>
            </div>

            <!-- Category Image Upload -->
            <div class="mb-6">
                <label for="categoryImage" class="block text-gray-700 font-bold mb-2">Upload New Image (Optional):</label>
                <input type="file" id="categoryImage" name="categoryImage"
                       class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>

            <div class="flex justify-between">
                <button type="submit" 
                        class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500">
                    Update Category
                </button>

                <a href="categoryList.jsp" 
                   class="bg-gray-500 text-white px-4 py-2 rounded-md hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-gray-500">
                    Cancel
                </a>
            </div>
        </form>
    </div>

</body>
</html>
