<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.List" %>
<%@ page import="com.grownited.entity.CategoryEntity" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category Management Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #0f172a;
            color: #e2e8f0;
            min-height: 100vh;
            margin: 0;
        }
        .container {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        /* Sidebar */
        .sidebar {
            background: #1e293b;
            width: 256px;
            height: 100vh;
            position: fixed;
            top: 0;
            left: -256px;
            transition: left 0.3s ease-in-out;
            z-index: 50;
        }
        .sidebar.open {
            left: 0;
        }
        .sidebar-link {
            transition: all 0.2s ease-in-out;
            padding: 10px;
            border-radius: 8px;
            display: block;
        }
        .sidebar-link:hover {
            background: #3b82f6;
            color: white;
        }
        /* Main Content */
        .main-content {
            flex: 1;
            padding: 1rem;
            transition: margin-left 0.3s ease-in-out;
        }
        .table-container {
            overflow-x: auto;
            background: #1e293b;
            border-radius: 12px;
            padding: 16px;
            box-shadow: 0 4px 10px rgba(255, 255, 255, 0.1);
        }
        .table-header {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }
        .filter-input {
            padding: 8px 12px;
            border: 1px solid #4b5563;
            border-radius: 6px;
            background: #374151;
            color: #e2e8f0;
            width: 100%;
            max-width: 250px;
        }
        .filter-input:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2);
        }
        .action-link {
            padding: 4px 8px;
            border-radius: 4px;
            transition: all 0.2s ease;
        }
        .action-link:hover {
            background-color: #4b5563;
        }
        .btn-primary {
            background: #3b82f6;
            color: white;
            padding: 10px 16px;
            border-radius: 8px;
            transition: all 0.3s ease-in-out;
            display: inline-block;
            width: 100%;
            text-align: center;
        }
        .btn-primary:hover {
            background: #1e40af;
        }
        .pagination {
            display: flex;
            gap: 0.5rem;
            align-items: center;
            flex-wrap: wrap;
            justify-content: center;
        }
        .pagination-btn {
            padding: 6px 12px;
            border: 1px solid #4b5563;
            border-radius: 6px;
            background: #374151;
            color: #e2e8f0;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .pagination-btn:hover:not(:disabled) {
            background: #3b82f6;
            border-color: #3b82f6;
        }
        .pagination-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        /* Table */
        .category-table {
            width: 100%;
            border-collapse: collapse;
        }
        .category-table th, .category-table td {
            padding: 12px 16px;
            border-bottom: 1px solid #4b5563;
        }
        .category-table thead th {
            background: #374151;
            font-weight: 600;
            text-align: left;
        }
        .category-table tbody tr:hover {
            background: #2d3748;
        }
        /* Responsive Adjustments */
        @media (min-width: 768px) {
            .container {
                flex-direction: row;
            }
            .sidebar {
                position: relative;
                left: 0;
                width: 256px;
                flex-shrink: 0;
            }
            .main-content {
                padding: 1.5rem;
                margin-left: 256px;
            }
            .btn-primary {
                width: auto;
            }
            .filter-input {
                width: 250px;
            }
        }
        @media (max-width: 640px) {
            .category-table {
                display: block;
            }
            .category-table thead {
                display: none;
            }
            .category-table tbody, .category-table tr, .category-table td {
                display: block;
                width: 100%;
            }
            .category-table tr {
                margin-bottom: 1rem;
                padding: 1rem;
                background: #2d3748;
                border-radius: 8px;
            }
            .category-table td {
                padding: 0.5rem 0;
                border: none;
                position: relative;
            }
            .category-table td::before {
                content: attr(data-label);
                font-weight: 600;
                color: #9ca3af;
                display: block;
                margin-bottom: 0.25rem;
            }
            .category-table td[data-label="Image"] img {
                max-width: 100px;
            }
            .category-table td[data-label="Actions"] {
                display: flex;
                gap: 1rem;
                justify-content: flex-start;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <aside id="sidebar" class="sidebar text-white p-4">
            <div class="flex items-center justify-between mb-6">
                <div class="flex items-center space-x-2">
                    <i class="fa-solid fa-user-shield text-2xl text-blue-400"></i>
                    <h2 class="text-xl font-bold">Admin Panel</h2>
                </div>
                <button id="closeSidebar" class="md:hidden text-white">
                    <i class="fa-solid fa-times text-xl"></i>
                </button>
            </div>
            <nav class="space-y-2">
                <a href="/admindashboard" class="sidebar-link text-sm">Dashboard</a>
                <a href="/userlist" class="sidebar-link text-sm">Users</a>
                <a href="/servicelist" class="sidebar-link text-sm">Services</a>
        
                <a href="/listcategory" class="sidebar-link text-sm bg-blue-600 text-white">Categories</a>
           
                <a href="/logout" class="block py-2 px-3 bg-red-600 hover:bg-red-700 rounded-lg text-center text-sm">Logout</a>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content ml-[6px]">
            <div class="max-w-6xl mx-auto">
                <div class="flex items-center justify-between mb-6">
                    <h1 class="text-2xl md:text-3xl font-semibold">Category Management</h1>
                    <button id="toggleSidebar" class="md:hidden text-white">
                        <i class="fa-solid fa-bars text-2xl"></i>
                    </button>
                </div>

                <!-- Table -->
                <div class="table-container">
                    <div class="table-header">
                        <input type="text" id="searchInput" class="filter-input" placeholder="Search categories...">
                        <div class="pagination">
                            <button id="prevBtn" class="pagination-btn">Previous</button>
                            <span id="pageInfo" class="text-sm text-gray-400"></span>
                            <button id="nextBtn" class="pagination-btn">Next</button>
                        </div>
                    </div>
                    <table class="category-table text-sm text-gray-300">
                        <thead>
                            <tr>
                                <th>Category Name</th>
                                <th>Description</th>
                                <th>Image</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody id="categoryTableBody">
                            <c:choose>
                                <c:when test="${empty categoryList}">
                                    <tr>
                                        <td colspan="4" class="text-center text-gray-500 py-4">No categories available.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="category" items="${categoryList}">
                                        <tr class="transition">
                                            <td data-label="Category Name">${category.categoryName}</td>
                                            <td data-label="Description">${category.categoryDescription}</td>
                                            <td data-label="Image">
                                                <c:choose>
                                                    <c:when test="${not empty category.categoryPicUrl}">
                                                        <img src="${category.categoryPicUrl}" alt="${category.categoryName}" class="w-16 h-16 object-cover rounded">
                                                    </c:when>
                                                    <c:otherwise>
                                                        No Image
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td data-label="Actions" class="text-center flex justify-center gap-4">
                                                <a href="editcategory/${category.categoryId}" class="text-blue-400 action-link">✏️</a>
                                                <a href="deletecategory/${category.categoryId}" class="text-red-400 action-link" onclick="return confirm('Are you sure you want to delete this category?');">❌</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <footer class="mt-6 text-right">
                    <a href="${pageContext.request.contextPath}/opencategory" class="btn-primary">Add New Category</a>
                </footer>
            </div>
        </main>
    </div>

    <!-- JavaScript -->
    <script>
        const sidebar = document.getElementById('sidebar');
        const toggleSidebarBtn = document.getElementById('toggleSidebar');
        const closeSidebarBtn = document.getElementById('closeSidebar');
        const searchInput = document.getElementById('searchInput');
        const prevBtn = document.getElementById('prevBtn');
        const nextBtn = document.getElementById('nextBtn');
        const pageInfo = document.getElementById('pageInfo');
        const tableBody = document.getElementById('categoryTableBody');

        let currentPage = 1;
        const rowsPerPage = 5;
        let allRows = Array.from(tableBody.getElementsByTagName('tr'));
        let filteredRows = [...allRows];

        // Sidebar toggle
        toggleSidebarBtn.addEventListener('click', () => sidebar.classList.add('open'));
        closeSidebarBtn.addEventListener('click', () => sidebar.classList.remove('open'));

        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', (e) => {
            if (window.innerWidth < 768 && !sidebar.contains(e.target) && !toggleSidebarBtn.contains(e.target)) {
                sidebar.classList.remove('open');
            }
        });

        // Adjust layout on resize
        window.addEventListener('resize', () => {
            if (window.innerWidth >= 768) {
                sidebar.classList.remove('open');
            }
        });

        // Table functionality
        function updateTable() {
            const start = (currentPage - 1) * rowsPerPage;
            const end = start + rowsPerPage;
            const paginatedRows = filteredRows.slice(start, end);

            allRows.forEach(row => row.style.display = 'none');
            paginatedRows.forEach(row => row.style.display = '');

            const totalPages = Math.ceil(filteredRows.length / rowsPerPage);
            pageInfo.textContent = `Page ${currentPage} of ${totalPages}`;
            prevBtn.disabled = currentPage === 1;
            nextBtn.disabled = currentPage === totalPages || totalPages === 0;
        }

        // Filter functionality
        searchInput.addEventListener('input', (e) => {
            const searchTerm = e.target.value.toLowerCase();
            filteredRows = allRows.filter(row => {
                const textContent = Array.from(row.getElementsByTagName('td'))
                    .map(td => td.textContent.toLowerCase())
                    .join(' ');
                return textContent.includes(searchTerm);
            });
            currentPage = 1;
            updateTable();
        });

        // Pagination functionality
        prevBtn.addEventListener('click', () => {
            if (currentPage > 1) {
                currentPage--;
                updateTable();
            }
        });

        nextBtn.addEventListener('click', () => {
            const totalPages = Math.ceil(filteredRows.length / rowsPerPage);
            if (currentPage < totalPages) {
                currentPage++;
                updateTable();
            }
        });

        // Initial table render
        updateTable();
    </script>
</body>
</html>