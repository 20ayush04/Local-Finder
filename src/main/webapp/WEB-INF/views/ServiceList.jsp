<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.List" %>
<%@ page import="com.grownited.entity.ServiceEntity" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Service Management Dashboard</title>
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
            background: #1e293b;
        }
        .sidebar.hidden {
            transform: translateX(-100%);
        }
        .sidebar-link {
            transition: all 0.2s ease-in-out;
        }
        .sidebar-link:hover {
            background: linear-gradient(90deg, #3b82f6, #1e40af);
            color: #ffffff;
            font-weight: 600;
        }
        /* Enhanced Table Styling */
        .table-container {
            overflow-x: auto;
            background: #ffffff;
            border-radius: 12px;
            padding: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        }
        .table-header {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }
        .filter-input {
            padding: 8px 12px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            width: 250px;
            transition: all 0.2s ease;
        }
        .filter-input:focus {
            border-color: #3b82f6;
            outline: none;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }
        .services-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }
        .services-table thead th {
            background: #f8fafc;
            padding: 12px 16px;
            text-align: left;
            font-weight: 600;
            color: #1e293b;
            border-bottom: 2px solid #e2e8f0;
            position: sticky;
            top: 0;
            z-index: 10;
        }
        .services-table tbody tr {
            transition: all 0.2s ease;
        }
        .services-table tbody tr:hover {
            background-color: #f8fafc;
            transform: translateY(-1px);
        }
        .services-table td {
            padding: 12px 16px;
            border-bottom: 1px solid #f1f5f9;
            color: #374151;
        }
        .action-link {
            padding: 4px 8px;
            border-radius: 4px;
            transition: all 0.2s ease;
        }
        .action-link:hover {
            text-decoration: none;
            background-color: #e2e8f0;
        }
        .pagination {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }
        .pagination-btn {
            padding: 6px 12px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            background: white;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .pagination-btn:hover:not(:disabled) {
            background: #3b82f6;
            color: white;
            border-color: #3b82f6;
        }
        .pagination-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        .btn-primary {
            background: linear-gradient(90deg, #3b82f6, #1e40af);
            color: #fff;
            padding: 10px 16px;
            border-radius: 8px;
            transition: all 0.3s ease-in-out;
        }
        .btn-primary:hover {
            background: linear-gradient(90deg, #1e40af, #3b82f6);
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
            .services-table {
                display: block;
            }
            .services-table thead {
                display: none;
            }
            .services-table tbody, .services-table tr, .services-table td {
                display: block;
                width: 100%;
            }
            .services-table tr {
                margin-bottom: 1rem;
                padding: 1rem;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            }
            .services-table td {
                padding: 0.5rem 0;
                border: none;
            }
            .services-table td::before {
                content: attr(data-label);
                font-weight: 600;
                color: #6b7280;
                display: block;
                margin-bottom: 0.25rem;
            }
            .btn-primary {
                width: 100%;
                text-align: center;
            }
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
            <a href="/userlist" class="sidebar-link block py-2 px-3 rounded-lg text-sm">Users</a>
            <a href="/servicelist" class="sidebar-link block py-2 px-3 rounded-lg text-sm active">Services</a>
           
            <a href="/listcategory" class="sidebar-link block py-2 px-3 rounded-lg text-sm">Categories</a>
          
            <a href="/logout" class="block py-2 px-3 bg-red-600 hover:bg-red-700 rounded-lg text-center text-sm">Logout</a>
        </nav>
    </aside>

    <!-- Main Content -->
    <main id="main-content" class="flex-1 p-4 sm:p-6 md:ml-6">
        <!-- Mobile Header with Hamburger Menu -->
        <div class="md:hidden flex justify-between items-center mb-6">
            <h1 class="text-2xl font-bold text-blue-400 flex items-center">
                <i class="fa-solid fa-tools mr-2"></i> Local Finder
            <button id="menu-btn" class="text-white focus:outline-none">
                <i class="fa-solid fa-bars text-2xl"></i>
            </button>
        </div>

        <div class="w-full max-w-7xl mx-auto bg-white rounded-xl shadow-lg p-4 sm:p-6">
            <header class="mb-6">
                <h1 class="text-2xl md:text-3xl font-semibold text-gray-800">Service Management</h1>
                <p class="text-sm text-gray-500">Manage your services efficiently</p>
            </header>

            <!-- Table -->
            <div class="table-container">
                <div class="table-header">
                    <input type="text" id="searchInput" class="filter-input" placeholder="Search services...">
                    <div class="pagination">
                        <button id="prevBtn" class="pagination-btn bg-[#6598eb]">Previous</button>
                        <span id="pageInfo" class="text-sm text-gray-600"></span>
                        <button id="nextBtn" class="pagination-btn bg-[#6598eb]">Next</button>
                    </div>
                </div>
                <table class="services-table w-full text-sm text-gray-800">
                    <thead class="bg-gray-100">
                        <tr>
                            <th class="px-4 sm:px-6 py-3 text-left font-medium border-b">Service Name</th>
                            <th class="px-4 sm:px-6 py-3 text-left font-medium border-b">Description</th>
                            <th class="px-4 sm:px-6 py-3 text-left font-medium border-b">Category</th>
                            <th class="px-4 sm:px-6 py-3 text-left font-medium border-b">Provider</th>
                            <th class="px-4 sm:px-6 py-3 text-left font-medium border-b">Created</th>
                            <th class="px-4 sm:px-6 py-3 text-left font-medium border-b">Updated</th>
                            <th class="px-4 sm:px-6 py-3 text-center font-medium border-b">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="serviceTableBody">
                        <c:choose>
                            <c:when test="${empty services}">
                                <tr>
                                    <td colspan="7" class="px-4 sm:px-6 py-4 text-center text-gray-500">No services available.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="service" items="${services}">
                                    <tr class="hover:bg-gray-50 transition">
                                        <td class="px-4 sm:px-6 py-4 border-b" data-label="Service Name">${service.serviceName}</td>
                                        <td class="px-4 sm:px-6 py-4 border-b" data-label="Description">${service.description}</td>
                                        <td class="px-4 sm:px-6 py-4 border-b" data-label="Category">${service.category.categoryName}</td>
                                        <td class="px-4 sm:px-6 py-4 border-b" data-label="Provider">${service.userEntity.name}</td>
                                        <td class="px-4 sm:px-6 py-4 border-b" data-label="Created">
                                            <fmt:formatDate value="${service.createdAt}" pattern="MMM dd, yyyy HH:mm" />
                                        </td>
                                        <td class="px-4 sm:px-6 py-4 border-b" data-label="Updated">
                                            <fmt:formatDate value="${service.updatedAt}" pattern="MMM dd, yyyy HH:mm" />
                                        </td>
                                        <td class="px-4 sm:px-6 py-4 border-b text-center space-x-4" data-label="Actions">
                                            <a href="${pageContext.request.contextPath}/editservice?id=${service.serviceId}" class="text-blue-600 action-link">Edit</a>
                                            <a href="${pageContext.request.contextPath}/deleteservice?id=${service.serviceId}" class="text-red-600 action-link" onclick="return confirm('Are you sure you want to delete this service?');">Delete</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <footer class="mt-6 text-right">
                <a href="${pageContext.request.contextPath}/newservice" class="btn-primary">Add New Service</a>
            </footer>
        </div>
    </main>

    <!-- JavaScript -->
    <script>
        const menuBtn = document.getElementById('menu-btn');
        const closeBtn = document.getElementById('close-btn');
        const sidebar = document.getElementById('sidebar');
        const searchInput = document.getElementById('searchInput');
        const prevBtn = document.getElementById('prevBtn');
        const nextBtn = document.getElementById('nextBtn');
        const pageInfo = document.getElementById('pageInfo');
        const tableBody = document.getElementById('serviceTableBody');

        let currentPage = 1;
        const rowsPerPage = 5;
        let allRows = Array.from(tableBody.getElementsByTagName('tr'));
        let filteredRows = [...allRows];

        // Sidebar functionality
        function updateSidebarVisibility() {
            if (window.innerWidth < 768) {
                sidebar.classList.add('hidden');
            } else {
                sidebar.classList.remove('hidden');
            }
        }

        updateSidebarVisibility();
        menuBtn.addEventListener('click', () => sidebar.classList.remove('hidden'));
        closeBtn.addEventListener('click', () => sidebar.classList.add('hidden'));
        window.addEventListener('resize', updateSidebarVisibility);

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