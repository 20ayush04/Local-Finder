<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Category - Local Finder</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .fade-in-up {
            animation: fadeInUp 0.6s ease-out forwards;
        }
        .hover-scale {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .hover-scale:hover {
            transform: scale(1.03);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
        input, textarea {
            transition: all 0.3s ease;
        }
        input:focus, textarea:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3);
        }
    </style>
</head>
<body class="bg-gradient-to-br from-gray-50 to-blue-100 min-h-screen flex items-center justify-center p-4">

    <div class="max-w-md w-full mx-auto shadow-[0_2px_10px_-2px_rgba(59,130,246,0.5)] p-8 bg-white rounded-2xl fade-in-up">
        <!-- Header -->
        <div class="flex items-center justify-between mb-6">
            <h2 class="text-2xl font-bold text-blue-600 flex items-center">
                <i class="fa-solid fa-folder-plus mr-2"></i> Add New Category
            </h2>
            <a href="/listcategory" class="text-blue-600 hover:text-blue-800 transition duration-300">
                <i class="fa-solid fa-arrow-left"></i> Back
            </a>
        </div>

        <!-- Form -->
        <form action="addcategory" method="post" enctype="multipart/form-data" class="space-y-6">
            <!-- Category Name -->
            <div>
                <label for="categoryName" class="block text-gray-700 font-semibold mb-2">Category Name</label>
                <input type="text" id="categoryName" name="categoryName" required 
                       class="w-full px-4 py-3 bg-gray-50 text-gray-800 text-sm border border-gray-200 rounded-lg focus:bg-transparent focus:outline-none placeholder-gray-500" 
                       placeholder="e.g., Plumbing" />
            </div>

            <!-- Category Description -->
            <div>
                <label for="categoryDescription" class="block text-gray-700 font-semibold mb-2">Description</label>
                <textarea id="categoryDescription" name="categoryDescription" rows="4" required 
                          class="w-full px-4 py-3 bg-gray-50 text-gray-800 text-sm border border-gray-200 rounded-lg focus:bg-transparent focus:outline-none placeholder-gray-500" 
                          placeholder="Describe the category..."></textarea>
            </div>

            <!-- Upload Image -->
            <div>
                <label for="categoryImage" class="block text-gray-700 font-semibold mb-2">Upload Image</label>
                <input type="file" id="categoryImage" name="categoryImage" accept="image/*" required
                       class="w-full px-4 py-3 bg-gray-50 text-gray-800 text-sm border border-gray-200 rounded-lg focus:bg-transparent focus:outline-none placeholder-gray-500" />
            </div>

            <!-- Submit Button -->
            <button type="submit" 
                    class="w-full py-3 px-4 text-sm tracking-wide text-white bg-blue-600 hover:bg-blue-700 rounded-lg transition duration-300 hover-scale">
                <i class="fa-solid fa-plus mr-2"></i> Add Category
            </button>
        </form>
    </div>

</body>
</html>
