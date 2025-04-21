<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users - Admin Panel</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            color: #e2e8f0;
            min-height: 100vh;
        }
        /* Sidebar */
        .sidebar {
            transition: transform 0.3s ease-in-out;
            background-color: #1e293b;
        }
        .sidebar.hidden {
            transform: translateX(-100%);
        }
        .sidebar-link {
            transition: background 0.3s ease;
        }
        .sidebar-link:hover { background-color: #4b5563; }
        .sidebar-link.active {
            background: linear-gradient(90deg, #3b82f6, #1e40af);
            font-weight: 600;
            box-shadow: inset 0 0 10px rgba(255, 255, 255, 0.1);
        }
        /* Table Styling */
        .users-table {
            width: 100%;
            border-collapse: collapse;
        }
        /* Filter Input */
        .filter-input {
            width: 100%;
            max-width: 20rem;
            padding: 0.75rem;
            border: 1px solid #d1d5db;
            border-radius: 0.375rem;
            background-color: #f9fafb;
            color: #374151;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }
        .filter-input:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3);
        }
        /* Pagination Styling */
        .pagination-btn {
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            background-color: #6b7280;
            color: #fff;
            transition: background-color 0.3s ease;
        }
ByName
        .pagination-btn:hover:not(:disabled) {
            background-color: #4b5563;
        }
        .pagination-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .sidebar {
                position: fixed;
                top: 0;
                left: 0;
                width: 256px;
                height: 100%;
                z-index: 50;
            }
            .sidebar:not(.hidden) {
                transform: translateX(0);
            }
            #main-content {
                margin-left: 0;
            }
        }
        @media (max-width: 640px) {
            .users-table {
                display: block;
            }
            .users-table thead {
                display: none;
            }
            .users-table tbody, .users-table tr, .users-table td {
                display: block;
                width: 100%;
            }
            .users-table tr {
                margin-bottom: 1.5rem;
                padding: 1rem;
                background-color: #ffffff;
                border-radius: 0.75rem;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                transition: background-color 0.3s ease, transform 0.2s ease;
            }
            .users-table tr:active {
                background-color: #f1f5f9;
                transform: scale(0.98);
            }
            .users-table td {
                padding: 0.75rem 0;
                border: none;
                color: #374151;
                font-size: 0.9rem;
                word-wrap: break-word;
            }
            .users-table td::before {
                content: attr(data-label);
                font-weight: 600;
                color: #6b7280;
                display: block;
                margin-bottom: 0.5rem;
                font-size: 0.85rem;
            }
            .users-table td:last-child {
                display: flex;
                gap: 1rem;
                justify-content: flex-start;
                padding-bottom: 0;
            }
            .filter-input {
                max-width: 100%;
            }
        }
        /* General Styling */
        .btn {
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            transition: all 0.3s ease;
        }
        .btn:hover {
            transform: translateY(-2px);
        }
    </style>
</head>
<body class="flex flex-col md:flex-row min-h-screen">
    <!-- Sidebar -->
    <aside id="sidebar" class="sidebar w-full md:w-64 p-4 sm:p-6 h-auto md:h-screen shadow-2xl md:block">
        <div class="flex justify-between items-center mb-6">
            <div class="flex items-center space-x-2">
                <i class="fa-solid fa-user-shield text-2xl text-blue-400"></i>
                <h2 class="text-xl font-bold">Admin Panel</h2>
            </div>
            <button id="close-btn" class="text-white md:hidden focus:outline-none">
                <i class="fa-solid fa-times text-xl"></i>
            </button>
        </div>
        <nav class="space-y-2">
            <a href="/admindashboard" class="sidebar-link block py-2 px-3 rounded-lg text-sm">Dashboard</a>
            <a href="/userlist" class="sidebar-link active block py-2 px-3 rounded-lg text-sm">Users</a>
            <a href="/servicelist" class="sidebar-link block py-2 px-3 rounded-lg text-sm">Services</a>
            
            <a href="/listcategory" class="sidebar-link block py-2 px-3 rounded-lg text-sm">Categories</a>
           
            <a href="/logout" class="block py-2 px-3 bg-red-600 hover:bg-red-700 rounded-lg text-center text-sm">Logout</a>
        </nav>
    </aside>

    <!-- Main Content -->
    <main id="main-content" class="flex-1 p-4 sm:p-6 md:ml-6">
        <!-- Mobile Header with Hamburger Menu -->
        <div class="md:hidden flex justify-between items-center mb-6">
            <h1 class="text-2xl font-bold text-blue-400 flex items-center">
                <i class="fa-solid fa-users mr-2"></i> Urban Service
            </h1>
            <button id="menu-btn" class="text-white focus:outline-none">
                <i class="fa-solid fa-bars text-2xl"></i>
            </button>
        </div>

        <div class="max-w-5xl mx-auto">
            <h1 class="text-2xl md:text-3xl font-bold text-white flex items-center mb-4">
                <i class="fa-solid fa-users mr-2 text-blue-400"></i> Users Management
            </h1>
            <div class="flex justify-between items-center mb-4">
                <div class="text-gray-400 text-sm">
                    Last Updated: <%= new java.text.SimpleDateFormat("MMM dd, yyyy HH:mm").format(new java.util.Date()) %>
                </div>
                <input type="text" id="filterInput" class="filter-input" placeholder="Search users...">
            </div>
            <div class="bg-white p-4 sm:p-6 rounded-lg shadow-md">
                <table class="users-table w-full text-left text-gray-700 text-sm">
                    <thead class="bg-blue-600 text-white">
                        <tr>
                            <th class="py-2 px-3 sm:px-4">#</th>
                            <th class="py-2 px-3 sm:px-4">Name</th>
                            <th class="py-2 px-3 sm:px-4">Email</th>
                            <th class="py-2 px-3 sm:px-4">Phone</th>
                            <th class="py-2 px-3 sm:px-4">Role</th>
                            <th class="py-2 px-3 sm:px-4">Status</th>
                            <th class="py-2 px-3 sm:px-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${users}" var="user" varStatus="status">
                            <tr class="border-b border-gray-200 hover:bg-gray-100">
                                <td class="py-2 px-3 sm:px-4" data-label="#">${status.index + 1}</td>
                                <td class="py-2 px-3 sm:px-4" data-label="Name">${user.name}</td>
                                <td class="py-2 px-3 sm:px-4" data-label="Email">${user.emailId}</td>
                                <td class="py-2 px-3 sm:px-4" data-label="Phone">${user.phone}</td>
                                <td class="py-2 px-3 sm:px-4" data-label="Role">${user.role}</td>
                                <td class="py-2 px-3 sm:px-4" data-label="Status">${user.status}</td>
                                <td class="py-2 px-3 sm:px-4" data-label="Actions">
                                    <a href="/edituser?id=${user.userId}" class="text-green-500 hover:text-green-600">Edit</a>
                                    <a href="/deleteuser?id=${user.userId}" class="text-red-500 hover:text-red-600 ml-2">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <!-- Pagination Controls -->
                <div class="flex justify-between items-center mt-4">
                    <button id="prevPage" class="pagination-btn">Previous</button>
                    <span id="pageInfo" class="text-sm font-semibold"></span>
                    <button id="nextPage" class="pagination-btn">Next</button>
                </div>
            </div>
        </div>
    </main>

    <!-- JavaScript -->
    <script>
        const menuBtn = document.getElementById('menu-btn');
        const closeBtn = document.getElementById('close-btn');
        const sidebar = document.getElementById('sidebar');
        const filterInput = document.getElementById('filterInput');
        const rows = Array.from(document.querySelectorAll('.users-table tbody tr'));
        const prevPageBtn = document.getElementById('prevPage');
        const nextPageBtn = document.getElementById('nextPage');
        const pageInfo = document.getElementById('pageInfo');

        const rowsPerPage = 10;
        let currentPage = 1;
        let filteredRows = rows;

        // Sidebar Toggle
        function updateSidebarVisibility() {
            if (window.innerWidth < 768) {
                sidebar.classList.add('hidden');
            } else {
                sidebar.classList.remove('hidden');
            }
        }

        updateSidebarVisibility();

        menuBtn.addEventListener('click', () => {
            sidebar.classList.remove('hidden');
        });

        closeBtn.addEventListener('click', () => {
            sidebar.classList.add('hidden');
        });

        window.addEventListener('resize', updateSidebarVisibility);

        // Filter Functionality
        filterInput.addEventListener('input', () => {
            const filterValue = filterInput.value.toLowerCase();
            filteredRows = rows.filter(row => row.textContent.toLowerCase().includes(filterValue));
            currentPage = 1; // Reset to first page on filter
            displayRows();
            updatePagination();
        });

        // Pagination Functionality
        function displayRows() {
            const start = (currentPage - 1) * rowsPerPage;
            const end = start + rowsPerPage;

            rows.forEach(row => row.style.display = 'none'); // Hide all rows
            filteredRows.slice(start, end).forEach(row => row.style.display = ''); // Show filtered rows for current page
        }

        function updatePagination() {
            const totalPages = Math.ceil(filteredRows.length / rowsPerPage) || 1; // At least 1 page
            pageInfo.textContent = `Page ${currentPage} of ${totalPages}`;
            prevPageBtn.disabled = currentPage === 1;
            nextPageBtn.disabled = currentPage === totalPages;
        }

        prevPageBtn.addEventListener('click', () => {
            if (currentPage > 1) {
                currentPage--;
                displayRows();
                updatePagination();
            }
        });

        nextPageBtn.addEventListener('click', () => {
            const totalPages = Math.ceil(filteredRows.length / rowsPerPage);
            if (currentPage < totalPages) {
                currentPage++;
                displayRows();
                updatePagination();
            }
        });

        // Initial Display
        displayRows();
        updatePagination();
    </script>
</body>
</html>