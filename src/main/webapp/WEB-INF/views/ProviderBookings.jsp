<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Service Provider Bookings - Urban Service</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #1f2937;
            color: #e5e7eb;
            min-height: 100vh;
        }
        /* Sidebar Styling */
        .sidebar {
            transition: transform 0.3s ease-in-out;
            background-color: #374151;
        }
        .sidebar.hidden {
            transform: translateX(-100%);
        }
        .sidebar-link:hover { background-color: #4a5568; }
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
        /* Table Styling */
        .bookings-table {
            width: 100%;
            border-collapse: collapse;
        }
        /* Table Responsiveness */
        @media (max-width: 640px) {
            .bookings-table {
                display: block;
            }
            .bookings-table thead {
                display: none;
            }
            .bookings-table tbody {
                display: block;
            }
            .bookings-table tr {
                display: block;
                margin-bottom: 1.5rem;
                padding: 1rem;
                background-color: #2d3748;
                border-radius: 0.75rem;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                transition: background-color 0.3s ease, transform 0.2s ease;
            }
            .bookings-table tr:active {
                background-color: #374151;
                transform: scale(0.98);
            }
            .bookings-table td {
                display: block;
                width: 100%;
                padding: 0.75rem 0;
                border: none;
                color: #e5e7eb;
                font-size: 0.9rem;
                word-wrap: break-word; /* Handle long text */
            }
            .bookings-table td::before {
                content: attr(data-label);
                font-weight: 600;
                color: #9ca3af;
                display: block;
                margin-bottom: 0.5rem;
                font-size: 0.85rem;
            }
            .bookings-table td form {
                display: flex;
                gap: 0.75rem;
                align-items: center;
                flex-wrap: wrap;
                margin-top: 0.5rem;
            }
            .bookings-table td:last-child {
                padding-bottom: 0;
            }
        }
        /* General Styling */
        .header {
            background: linear-gradient(90deg, #3b82f6, #1e40af);
            border-radius: 0.5rem;
            padding: 1rem;
        }
        .table-container {
            background-color: #2d3748;
            padding: 1rem;
            border-radius: 0.5rem;
        }
        .btn {
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background-color: #3b82f6;
            color: #fff;
        }
        .btn-primary:hover {
            background-color: #1e40af;
        }
        .btn-pagination {
            background-color: #6b7280;
            color: #fff;
        }
        .btn-pagination:hover {
            background-color: #4b5563;
        }
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 500;
        }
        select {
            background-color: #374151;
            color: #e5e7eb;
            border: 1px solid #4b5563;
            padding: 0.5rem;
            border-radius: 0.375rem;
            width: auto;
            max-width: 100%; /* Prevent overflow */
        }
    </style>
</head>
<body class="flex flex-col md:flex-row">
    <!-- Sidebar -->
    <aside id="sidebar" class="sidebar w-full md:w-64 p-4 sm:p-6 md:h-screen shadow-lg md:block">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-xl sm:text-2xl font-bold flex items-center">
                <i class="fa-solid fa-tools mr-2 text-blue-400"></i> Provider Dashboard
            </h2>
            <button id="close-btn" class="text-white md:hidden">
                <i class="fa-solid fa-times text-xl"></i>
            </button>
        </div>
        <ul class="space-y-3">
            <li><a href="/service-provider/dashboard" class="sidebar-link block py-2 px-4 rounded-md text-sm sm:text-base">Dashboard</a></li>
            <li><a href="/profile" class="sidebar-link block py-2 px-4 rounded-md text-sm sm:text-base">Profile</a></li>
            <li><a href="/servicelistprovider" class="sidebar-link block py-2 px-4 rounded-md text-sm sm:text-base">Service</a></li>
            <li><a href="/provider/bookings" class="sidebar-link block py-2 px-4 rounded-md text-sm sm:text-base active">Bookings</a></li>
            <li><a href="/reviews/provider" class="sidebar-link block py-2 px-4 rounded-md text-sm sm:text-base">Reviews</a></li>
            <li><a href="/logout" class="block py-2 px-4 bg-red-600 hover:bg-red-700 rounded text-center mt-6 text-sm sm:text-base">Logout</a></li>
        </ul>
    </aside>

    <!-- Main Content -->
    <div id="main-content" class="flex-1 p-4 sm:p-6 md:ml-4">
        <!-- Mobile Header with Hamburger Menu -->
        <div class="md:hidden flex justify-between items-center mb-6">
            <h1 class="text-2xl font-bold text-blue-400 flex items-center">
                <i class="fa-solid fa-tools mr-2"></i> Urban Service
            </h1>
            <button id="menu-btn" class="text-white focus:outline-none">
                <i class="fa-solid fa-bars text-2xl"></i>
            </button>
        </div>

        <header class="header mb-6">
            <h1 class="text-2xl sm:text-3xl font-semibold"><i class="fa-solid fa-calendar-check mr-2"></i> My Bookings</h1>
        </header>
        <div class="table-container">
            <table class="bookings-table w-full text-sm">
                <thead class="bg-blue-600 text-white">
                    <tr>
                        <th class="py-3 px-4 sm:px-5 text-left">#</th>
                        <th class="py-3 px-4 sm:px-5 text-left">Service Name</th>
                        <th class="py-3 px-4 sm:px-5 text-left">Customer</th>
                        <th class="py-3 px-4 sm:px-5 text-left">Booking Date</th>
                        <th class="py-3 px-4 sm:px-5 text-left">Status</th>
                        <th class="py-3 px-4 sm:px-5 text-left">Change Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="booking" items="${bookings}" varStatus="loop">
                        <tr class="hover:bg-gray-700 transition duration-200">
                            <td class="py-4 px-4 sm:px-5" data-label="#">${loop.index + 1}</td>
                            <td class="py-4 px-4 sm:px-5" data-label="Service Name">${booking.service.serviceName}</td>
                            <td class="py-4 px-4 sm:px-5" data-label="Customer">${booking.user.name}</td>
                            <td class="py-4 px-4 sm:px-5" data-label="Booking Date">${booking.bookingDate}</td>
                            <td class="py-4 px-4 sm:px-5" data-label="Status">
                                <span class="status-badge" data-status="${booking.status}">${booking.status}</span>
                            </td>
                            <td class="py-4 px-4 sm:px-5" data-label="Change Status">
                                <form action="/provider/updatebookingstatus" method="post">
                                    <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                    <select name="status" class="mr-2">
                                        <option value="ACCEPT">Accept</option>
                                        <option value="REJECT">Reject</option>
                                    </select>
                                    <button type="submit" class="btn btn-primary">Update</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <div class="flex justify-between mt-4 items-center">
            <button id="prevPage" class="btn btn-pagination">Previous</button>
            <span id="pageNumber" class="text-sm sm:text-lg font-semibold"></span>
            <button id="nextPage" class="btn btn-pagination">Next</button>
        </div>
    </div>

    <script>
        // Sidebar Toggle
        const menuBtn = document.getElementById('menu-btn');
        const closeBtn = document.getElementById('close-btn');
        const sidebar = document.getElementById('sidebar');

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

        // Pagination
        document.addEventListener("DOMContentLoaded", function () {
            const rowsPerPage = 5;
            const rows = Array.from(document.querySelector(".bookings-table tbody").querySelectorAll("tr"));
            const totalPages = Math.ceil(rows.length / rowsPerPage);
            let currentPage = 1;

            function displayRows() {
                rows.forEach((row, index) => {
                    row.style.display = (index >= (currentPage - 1) * rowsPerPage && index < currentPage * rowsPerPage) ? "" : "none";
                });
            }

            function updatePagination() {
                document.getElementById("pageNumber").textContent = `Page ${currentPage} of ${totalPages}`;
                document.getElementById("prevPage").disabled = currentPage === 1;
                document.getElementById("nextPage").disabled = currentPage === totalPages;
            }

            document.getElementById("prevPage").addEventListener("click", () => {
                if (currentPage > 1) {
                    currentPage--;
                    displayRows();
                    updatePagination();
                }
            });

            document.getElementById("nextPage").addEventListener("click", () => {
                if (currentPage < totalPages) {
                    currentPage++;
                    displayRows();
                    updatePagination();
                }
            });

            displayRows();
            updatePagination();
        });

        // Status Badge Colors
        document.querySelectorAll('.status-badge').forEach(el => {
            const status = el.getAttribute('data-status');
            if (status === "ACCEPT") el.classList.add('bg-green-500');
            else if (status === "PENDING") el.classList.add('bg-yellow-500');
            else if (status === "REJECT") el.classList.add('bg-red-500');
        });
    </script>
</body>
</html>