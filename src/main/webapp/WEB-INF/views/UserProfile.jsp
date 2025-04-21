<%@page import="com.grownited.entity.UserAddressEntity"%>
<%@page import="com.grownited.enumD.Role"%>
<%@page import="com.grownited.entity.UserEntity"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// Fetch user entity from request
UserEntity entity = (UserEntity) request.getAttribute("user");
if (entity == null) {
    response.sendRedirect("/login");
    return;
}
boolean isServiceProvider = entity.getRole() == Role.SERVICE_PROVIDER;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Advanced User Profile - Urban Service</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .fade-in {
            animation: fadeIn 0.5s ease-out forwards;
        }
        .hover-scale {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .hover-scale:hover {
            transform: scale(1.03);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
        input, select {
            transition: all 0.3s ease;
        }
        input:focus, select:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3);
        }
    </style>
</head>
<body class="bg-gradient-to-br from-gray-50 to-blue-100 min-h-screen flex items-center justify-center py-12">

    <div class="bg-white shadow-2xl rounded-2xl p-8 w-full max-w-2xl fade-in">

        <!-- Profile Header -->
        <div class="flex items-center space-x-6 border-b pb-6">
            <div class="relative">
                <img id="profilePic" src="<%=entity.getProfilePicUrl() %>" alt="Profile" 
                     class="rounded-full w-28 h-28 border-4 border-blue-500 object-cover cursor-pointer hover-scale"
                     onclick="openModal()">
                <div class="absolute bottom-0 right-0 bg-blue-500 text-white rounded-full p-2">
                    <i class="fa-solid fa-camera"></i>
                </div>
            </div>
            <div>
                <h2 class="text-3xl font-bold text-gray-800"><%=entity.getName()%></h2>
                <p class="text-gray-500 text-sm mt-1">
                    <%=isServiceProvider ? "Service Provider" : "Customer"%> | Member since 2025
                </p>
            </div>
        </div>

        <!-- Profile Form -->
        <form action="/updateuserprofile" method="post" class="mt-6 space-y-6">
            <input type="hidden" name="userId" value="<%=entity.getUserId()%>">

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Name</label>
                    <input type="text" name="name" value="<%=entity.getName()%>"
                           class="w-full px-4 py-3 bg-gray-50 border rounded-lg focus:outline-none">
                </div>
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Email</label>
                    <input type="email" name="emailId" readonly="readonly" value="<%=entity.getEmailId()%>"
                           class="w-full px-4 py-3 bg-gray-50 border rounded-lg focus:outline-none">
                </div>
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Phone</label>
                    <input type="text" name="phone" value="<%=entity.getPhone()%>"
                           class="w-full px-4 py-3 bg-gray-50 border rounded-lg focus:outline-none">
                </div>
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Address</label>
                    <input type="text" name="userAddressEntity.addressLine"
                           value="<%=(entity.getUserAddressEntity() != null) ? entity.getUserAddressEntity().getAddressLine() : ""%>"
                           class="w-full px-4 py-3 bg-gray-50 border rounded-lg focus:outline-none">
                </div>
                <% if (isServiceProvider) { %>
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Status</label>
                    <select name="status" class="w-full px-4 py-3 bg-gray-50 border rounded-lg focus:outline-none">
                        <option value="ACTIVE" <%=entity.getStatus().equals("ACTIVE") ? "selected" : ""%>>Active</option>
                        <option value="INACTIVE" <%=entity.getStatus().equals("INACTIVE") ? "selected" : ""%>>Inactive</option>
                        <option value="SUSPENDED" <%=entity.getStatus().equals("SUSPENDED") ? "selected" : ""%>>Suspended</option>
                    </select>
                </div>
                <% } %>
            </div>

            <div class="flex space-x-4 mt-8">
                <button type="submit" class="bg-blue-600 text-white px-6 py-3 rounded-full hover:bg-blue-700 transition duration-300 w-full hover-scale">
                    Save Changes
                </button>
                <button type="reset" class="bg-gray-500 text-white px-6 py-3 rounded-full hover:bg-gray-600 transition duration-300 w-full hover-scale">
                    Reset
                </button>
            </div>
        </form>

        <!-- Service Provider Section -->
        <% if (isServiceProvider) { %>
        <div class="mt-8 border-t pt-6">
            <a href="/newservice" class="bg-green-600 text-white px-6 py-3 rounded-full hover:bg-green-700 transition duration-300 w-full block text-center hover-scale">
                <i class="fa-solid fa-plus mr-2"></i> Add New Service
            </a>
        </div>
        <% } %>

        <!-- Logout Button -->
        <div class="mt-6">
            <a href="/logout" class="bg-red-600 text-white px-6 py-3 rounded-full hover:bg-red-700 transition duration-300 w-full block text-center hover-scale">
                <i class="fa-solid fa-sign-out-alt mr-2"></i> Logout
            </a>
        </div>
    </div>

    <!-- Modal for Profile Picture Upload -->
    <div id="profileModal" class="fixed inset-0 flex justify-center items-center bg-black bg-opacity-60 hidden">
        <div class="bg-white p-8 rounded-2xl w-96 fade-in">
            <h2 class="text-xl font-semibold text-gray-800 mb-6">Upload Profile Picture</h2>
            <input type="file" id="profileInput" accept="image/*"
                   class="block w-full border p-3 mb-6 rounded-lg bg-gray-50" onchange="previewImage(event)">
            <img id="previewImg" class="w-full h-40 object-cover rounded-lg mb-6 hidden" alt="Preview">
            <div class="flex space-x-4">
                <button onclick="uploadImage()" class="bg-blue-600 text-white px-4 py-2 rounded-full hover:bg-blue-700 transition duration-300 w-full">
                    Upload
                </button>
                <button onclick="closeModal()" class="bg-gray-500 text-white px-4 py-2 rounded-full hover:bg-gray-600 transition duration-300 w-full">
                    Cancel
                </button>
            </div>
        </div>
    </div>

    <script>
        function openModal() {
            document.getElementById('profileModal').classList.remove('hidden');
        }

        function closeModal() {
            document.getElementById('profileModal').classList.add('hidden');
            document.getElementById('previewImg').classList.add('hidden');
        }

        function previewImage(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const preview = document.getElementById('previewImg');
                    preview.src = e.target.result;
                    preview.classList.remove('hidden');
                };
                reader.readAsDataURL(file);
            }
        }

        function uploadImage() {
            // Placeholder for actual upload logic (e.g., send to server via AJAX)
            const fileInput = document.getElementById('profileInput');
            if (fileInput.files[0]) {
                const profilePic = document.getElementById('profilePic');
                profilePic.src = URL.createObjectURL(fileInput.files[0]);
                closeModal();
                // Add actual server-side upload code here if needed
            }
        }
    </script>
</body>
</html>