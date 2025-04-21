<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Service Provider Dashboard - Urban Service</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #1f2937;
            color: #e5e7eb;
        }
        .sidebar-link:hover { background-color: #4a5568; }
        .card { background-color: #374151; }
        .hover-scale {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .hover-scale:hover {
            transform: scale(1.03);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }
        /* Sidebar Styling for Mobile */
        #sidebar {
            transition: transform 0.3s ease-in-out;
        }
        #sidebar.hidden {
            transform: translateX(-100%);
        }
        @media (max-width: 768px) {
            #sidebar {
                position: fixed;
                top: 0;
                left: 0;
                width: 256px;
                height: 100%;
                z-index: 50;
            }
            #sidebar:not(.hidden) {
                transform: translateX(0);
            }
            #main-content {
                margin-left: 0;
            }
        }
        /* Chart Container */
        .chart-container {
            background-color: #374151;
            border-radius: 0.5rem;
            padding: 1rem;
            min-height: 300px;
            height: 400px;
        }
        /* Table Styling */
        .table-container {
            background-color: #374151;
            border-radius: 0.5rem;
            padding: 1rem;
            overflow-x: auto;
        }
    </style>
</head>
<body class="min-h-screen flex flex-col md:flex-row">

    <!-- Sidebar -->
    <aside id="sidebar" class="w-full md:w-64 bg-gray-800 p-4 sm:p-6 h-auto md:h-screen shadow-lg md:block">
        <h2 class="text-xl sm:text-2xl font-bold mb-6 flex items-center">
            <i class="fa-solid fa-tools mr-2"></i> Provider Dashboard
        </h2>
        <ul class="space-y-3">
            <li><a href="/service-provider/dashboard" class="sidebar-link block py-2 px-4 rounded-md text-sm sm:text-base">Dashboard</a></li>
            <li><a href="/profile" class="sidebar-link block py-2 px-4 rounded-md text-sm sm:text-base">Profile</a></li>
            <li><a href="/servicelistprovider" class="sidebar-link block py-2 px-4 rounded-md text-sm sm:text-base">Service</a></li>
            <li><a href="/provider/bookings" class="sidebar-link block py-2 px-4 rounded-md text-sm sm:text-base">Bookings</a></li>
            <li><a href="/reviews/provider" class="sidebar-link block py-2 px-4 rounded-md text-sm sm:text-base">Reviews</a></li>
            <li><a href="/logout" class="block py-2 px-4 bg-red-600 hover:bg-red-700 rounded text-center mt-6 text-sm sm:text-base">Logout</a></li>
        </ul>
    </aside>

    <!-- Main Content -->
    <div id="main-content" class="flex-1 p-4 sm:p-6 md:ml-6">
        <!-- Mobile Header with Hamburger Menu -->
        <div class="md:hidden flex justify-between items-center mb-6">
            <h1 class="text-2xl font-bold text-blue-400 flex items-center">
                <i class="fa-solid fa-tools mr-2"></i> Urban Service
            </h1>
            <button id="menu-btn" class="text-white focus:outline-none">
                <i class="fa-solid fa-bars text-2xl"></i>
            </button>
        </div>

        <div class="flex flex-col sm:flex-row items-center justify-between mb-6 sm:mb-8">
            <h1 class="text-2xl sm:text-3xl font-bold text-blue-400 flex items-center">
                <i class="fa-solid fa-tools mr-2"></i> Welcome, ${serviceProvider.name != null ? serviceProvider.name : "Provider"}
            </h1>
            <div class="text-gray-400 text-xs sm:text-sm mt-2 sm:mt-0">
                Last Updated: <%= new java.text.SimpleDateFormat("MMM dd, yyyy HH:mm").format(new java.util.Date()) %>
            </div>
        </div>
        
        <!-- Profile Section -->
        <div class="bg-gray-800 p-4 sm:p-6 rounded-lg shadow-lg card mb-6">
            <h2 class="text-lg sm:text-xl font-semibold text-blue-400 mb-4">Profile Info</h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <p class="text-sm sm:text-base"><span class="text-gray-400">Email:</span> ${serviceProvider.emailId != null ? serviceProvider.emailId : "N/A"}</p>
                <p class="text-sm sm:text-base"><span class="text-gray-400">Phone:</span> ${serviceProvider.phone != null ? serviceProvider.phone : "N/A"}</p>
                <p class="text-sm sm:text-base"><span class="text-gray-400">Status:</span> ${serviceProvider.status != null ? serviceProvider.status : "N/A"}</p>
            </div>
        </div>
        
        <!-- Bookings Summary -->
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4 sm:gap-6">
            <div class="bg-blue-600 p-4 sm:p-6 rounded-lg shadow-lg hover-scale">
                <h3 class="text-base sm:text-lg font-semibold">Total Bookings</h3>
                <p class="text-2xl sm:text-3xl font-bold mt-2">${totalBookings != null ? totalBookings : "0"}</p>
            </div>
            <div class="bg-yellow-600 p-4 sm:p-6 rounded-lg shadow-lg hover-scale">
                <h3 class="text-base sm:text-lg font-semibold">Pending</h3>
                <p class="text-2xl sm:text-3xl font-bold mt-2">${pendingBookings != null ? pendingBookings : "0"}</p>
            </div>
            <div class="bg-green-600 p-4 sm:p-6 rounded-lg shadow-lg hover-scale">
                <h3 class="text-base sm:text-lg font-semibold">Completed</h3>
                <p class="text-2xl sm:text-3xl font-bold mt-2">${completedBookings != null ? completedBookings : "0"}</p>
            </div>
        </div>

        <!-- New Components -->
        <!-- Earnings Summary -->
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4 sm:gap-6 mt-6">
            <div class="bg-purple-600 p-4 sm:p-6 rounded-lg shadow-lg hover-scale">
                <h3 class="text-base sm:text-lg font-semibold">Total Earnings</h3>
                <p class="text-2xl sm:text-3xl font-bold mt-2">$${totalEarnings != null ? totalEarnings : "0.00"}</p>
            </div>
            <div class="bg-indigo-600 p-4 sm:p-6 rounded-lg shadow-lg hover-scale">
                <h3 class="text-base sm:text-lg font-semibold">Monthly Earnings</h3>
                <p class="text-2xl sm:text-3xl font-bold mt-2">$${monthlyEarnings != null ? monthlyEarnings : "0.00"}</p>
            </div>
            <div class="bg-teal-600 p-4 sm:p-6 rounded-lg shadow-lg hover-scale">
                <h3 class="text-base sm:text-lg font-semibold">Pending Payments</h3>
                <p class="text-2xl sm:text-3xl font-bold mt-2">$${pendingPayments != null ? pendingPayments : "0.00"}</p>
            </div>
        </div>

        <!-- Charts -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mt-6">
            <!-- Monthly Bookings Chart -->
            <div class="chart-container hover-scale">
                <h2 class="text-lg sm:text-xl font-semibold text-blue-400 mb-4">Monthly Bookings (Last 12 Months)</h2>
                <canvas id="monthlyBookingsChart"></canvas>
            </div>
            <!-- Earnings Trend Chart -->
            <div class="chart-container hover-scale">
                <h2 class="text-lg sm:text-xl font-semibold text-blue-400 mb-4">Earnings Trend (Last 12 Months)</h2>
                <canvas id="earningsTrendChart"></canvas>
            </div>
        </div>

        <!-- Recent Bookings Table -->
        <div class="table-container mt-6">
            <h2 class="text-lg sm:text-xl font-semibold text-blue-400 mb-4">Recent Bookings</h2>
            <table class="min-w-full text-sm sm:text-base">
                <thead>
                    <tr class="text-left text-gray-400 border-b border-gray-600">
                        <th class="py-2 px-4">Booking ID</th>
                        <th class="py-2 px-4">Customer</th>
                        <th class="py-2 px-4">Service</th>
                        <th class="py-2 px-4">Date</th>
                        <th class="py-2 px-4">Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        java.util.List<Object[]> recentBookings = (java.util.List<Object[]>) request.getAttribute("recentBookings");
                        if (recentBookings != null && !recentBookings.isEmpty()) {
                            for (Object[] booking : recentBookings) {
                    %>
                    <tr class="border-b border-gray-700 hover:bg-gray-600">
                        <td class="py-2 px-4"><%= booking[0] != null ? booking[0] : "N/A" %></td>
                        <td class="py-2 px-4"><%= booking[1] != null ? booking[1] : "N/A" %></td>
                        <td class="py-2 px-4"><%= booking[2] != null ? booking[2] : "N/A" %></td>
                        <td class="py-2 px-4"><%= booking[3] != null ? booking[3] : "N/A" %></td>
                        <td class="py-2 px-4"><%= booking[4] != null ? booking[4] : "N/A" %></td>
                    </tr>
                    <% 
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="5" class="py-2 px-4 text-center">No recent bookings available</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- JavaScript -->
    <script>
        // Sidebar functionality
        const menuBtn = document.getElementById('menu-btn');
        const sidebar = document.getElementById('sidebar');

        function updateSidebarVisibility() {
            if (window.innerWidth < 768) {
                sidebar.classList.add('hidden');
            } else {
                sidebar.classList.remove('hidden');
            }
        }

        updateSidebarVisibility();
        menuBtn.addEventListener('click', () => sidebar.classList.toggle('hidden'));
        window.addEventListener('resize', updateSidebarVisibility);

        // Chart data parsing
        const parseChartData = (dataString, defaultData) => {
            if (!dataString || dataString === "null") return defaultData.split(',').map(Number);
            try {
                return dataString.split(',').map(num => parseFloat(num.trim()) || 0);
            } catch (e) {
                console.error('Error parsing chart data:', e);
                return defaultData.split(',').map(Number);
            }
        };

        // Monthly Bookings Chart
        const monthlyBookingsRaw = "<%= request.getAttribute("monthlyBookingsData") != null ? request.getAttribute("monthlyBookingsData") : "5, 8, 12, 15, 10, 7, 9, 11, 14, 13, 6, 8" %>";
        const monthlyBookingsValues = parseChartData(monthlyBookingsRaw, "5, 8, 12, 15, 10, 7, 9, 11, 14, 13, 6, 8");
        const monthlyBookingsData = {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            datasets: [{
                label: 'Bookings',
                data: monthlyBookingsValues,
                backgroundColor: 'rgba(59, 130, 246, 0.2)',
                borderColor: '#3b82f6',
                borderWidth: 2,
                tension: 0.4,
                fill: true
            }]
        };

        // Earnings Trend Chart
        const earningsTrendRaw = "<%= request.getAttribute("earningsTrendData") != null ? request.getAttribute("earningsTrendData") : "500, 800, 1200, 1500, 1000, 700, 900, 1100, 1400, 1300, 600, 800" %>";
        const earningsTrendValues = parseChartData(earningsTrendRaw, "500, 800, 1200, 1500, 1000, 700, 900, 1100, 1400, 1300, 600, 800");
        const earningsTrendData = {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            datasets: [{
                label: 'Earnings ($)',
                data: earningsTrendValues,
                backgroundColor: 'rgba(16, 185, 129, 0.2)',
                borderColor: '#10b981',
                borderWidth: 2,
                tension: 0.4,
                fill: true
            }]
        };

        // Chart configurations
        const chartOptions = {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    grid: { color: 'rgba(255, 255, 255, 0.1)' },
                    ticks: { callback: value => value + (value === earningsTrendData.datasets[0].label.includes('$') ? '$' : '') }
                },
                x: {
                    grid: { display: false }
                }
            },
            plugins: {
                legend: { position: 'top' },
                tooltip: { callbacks: { label: context => `${context.dataset.label}: ${context.parsed.y}${context.dataset.label.includes('$') ? '$' : ''}` } }
            }
        };

        // Initialize Charts
        new Chart(document.getElementById('monthlyBookingsChart'), {
            type: 'line',
            data: monthlyBookingsData,
            options: chartOptions
        });

        new Chart(document.getElementById('earningsTrendChart'), {
            type: 'line',
            data: earningsTrendData,
            options: chartOptions
        });
    </script>
</body>
</html>