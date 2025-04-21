<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Local Finder</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            color: #e2e8f0;
            min-height: 100vh;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .fade-in-up { animation: fadeInUp 0.6s ease-out forwards; }
        .hover-scale {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .hover-scale:hover {
            transform: scale(1.05);
            box-shadow: 0 15px 25px rgba(0, 0, 0, 0.2);
        }
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
        .dashboard-card {
            background: #ffffff;
            border-radius: 1rem;
            overflow: hidden;
            position: relative;
        }
        .dashboard-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #3b82f6, #60a5fa);
        }
        .chart-container {
            background: #ffffff;
            border-radius: 1rem;
            padding: 1rem;
            position: relative;
            min-height: 300px;
            height: 400px;
        }
        @media (max-width: 768px) {
            .sidebar {
                position: fixed;
                top: 0;
                left: 0;
                width: 256px;
                height: 100%;
                z-index: 50;
            }
            .sidebar.hidden {
                transform: translateX(-100%);
            }
            #main-content {
                margin-left: 0;
            }
            .dashboard-card, .chart-container {
                padding: 1rem;
            }
            .grid {
                grid-template-columns: 1fr;
            }
        }
        @media (max-width: 640px) {
            h1 { font-size: 1.5rem; }
            .dashboard-card p { font-size: 1.25rem; }
            .text-sm { font-size: 0.875rem; }
        }
    </style>
</head>
<body class="min-h-screen flex flex-col md:flex-row">
    <!-- Sidebar -->
    <aside id="sidebar" class="sidebar w-full md:w-64 p-4 sm:p-6 h-auto md:h-screen shadow-2xl md:block hidden">
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
            <a href="/admindashboard" class="sidebar-link active block py-2 px-3 rounded-lg hover-scale text-sm">Dashboard</a>
            <a href="/userlist" class="sidebar-link block py-2 px-3 rounded-lg hover-scale text-sm">Users</a>
            <a href="/servicelist" class="sidebar-link block py-2 px-3 rounded-lg hover-scale text-sm">Services</a>
            <a href="/listcategory" class="sidebar-link block py-2 px-3 rounded-lg hover-scale text-sm">Categories</a>
            <a href="/reports" class="sidebar-link block py-2 px-3 rounded-lg hover-scale text-sm">Reports</a>
            <a href="/logout" class="block py-2 px-3 bg-red-600 hover:bg-red-700 rounded-lg text-center hover-scale text-sm">Logout</a>
        </nav>
    </aside>

    <!-- Main Content -->
    <main id="main-content" class="flex-1 p-4 sm:p-6">
        <!-- Mobile Header with Hamburger Menu -->
        <div class="md:hidden flex justify-between items-center mb-6">
            <h1 class="text-2xl font-bold text-blue-400 flex items-center">
                <i class="fa-solid fa-tachometer-alt mr-2"></i> Urban Service
            </h1>
            <button id="menu-btn" class="text-white focus:outline-none">
                <i class="fa-solid fa-bars text-2xl"></i>
            </button>
        </div>

        <div class="max-w-7xl mx-auto">
            <!-- Header -->
            <div class="flex flex-col sm:flex-row items-start sm:items-center justify-between mb-6 fade-in-up">
                <h1 class="text-2xl md:text-3xl font-bold text-white flex items-center">
                    <i class="fa-solid fa-tachometer-alt mr-2 text-blue-400"></i> Admin Dashboard
                </h1>
                <div class="text-gray-400 text-sm mt-2 sm:mt-0">
                    Last Updated: <%= new java.text.SimpleDateFormat("MMM dd, yyyy HH:mm").format(new java.util.Date()) %>
                </div>
            </div>

            <!-- Stats Grid -->
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
                <div class="dashboard-card p-5 hover-scale fade-in-up">
                    <div class="flex justify-between items-center">
                        <div>
                            <h2 class="text-md font-semibold text-gray-700">Total Users</h2>
                            <p class="text-2xl font-bold text-blue-600 mt-1">
                                <%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : "0" %>
                            </p>
                        </div>
                        <i class="fa-solid fa-users text-2xl text-blue-500 opacity-60"></i>
                    </div>
                </div>
                <div class="dashboard-card p-5 hover-scale fade-in-up">
                    <div class="flex justify-between items-center">
                        <div>
                            <h2 class="text-md font-semibold text-gray-700">Total Bookings</h2>
                            <p class="text-2xl font-bold text-blue-600 mt-1">
                                <%= request.getAttribute("totalBookings") != null ? request.getAttribute("totalBookings") : "0" %>
                            </p>
                        </div>
                        <i class="fa-solid fa-calendar-check text-2xl text-blue-500 opacity-60"></i>
                    </div>
                </div>
                <div class="dashboard-card p-5 hover-scale fade-in-up">
                    <div class="flex justify-between items-center">
                        <div>
                            <h2 class="text-md font-semibold text-gray-700">Active Customers</h2>
                            <p class="text-2xl font-bold text-blue-600 mt-1">
                                <%= request.getAttribute("activeCustomers") != null ? request.getAttribute("activeCustomers") : "0" %>
                            </p>
                        </div>
                        <i class="fa-solid fa-user-check text-2xl text-blue-500 opacity-60"></i>
                    </div>
                </div>
                <div class="dashboard-card p-5 hover-scale fade-in-up">
                    <div class="flex justify-between items-center">
                        <div>
                            <h2 class="text-md font-semibold text-gray-700">Total Earnings</h2>
                            <p class="text-2xl font-bold text-blue-600 mt-1">
                                $<%= request.getAttribute("totalEarnings") != null ? request.getAttribute("totalEarnings") : "0.00" %>
                            </p>
                        </div>
                        <i class="fa-solid fa-dollar-sign text-2xl text-blue-500 opacity-60"></i>
                    </div>
                </div>
            </div>

            <!-- Sales Stats -->
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mb-6">
                <div class="dashboard-card p-5 hover-scale fade-in-up">
                    <div class="flex justify-between items-center">
                        <div>
                            <h2 class="text-md font-semibold text-gray-700">Monthly Sales</h2>
                            <p class="text-2xl font-bold text-blue-600 mt-1">
                                $<%= request.getAttribute("monthlySales") != null ? request.getAttribute("monthlySales") : "0.00" %>
                            </p>
                        </div>
                        <i class="fa-solid fa-chart-line text-2xl text-blue-500 opacity-60"></i>
                    </div>
                </div>
                <div class="dashboard-card p-5 hover-scale fade-in-up">
                    <div class="flex justify-between items-center">
                        <div>
                            <h2 class="text-md font-semibold text-gray-700">Quarterly Sales</h2>
                            <p class="text-2xl font-bold text-blue-600 mt-1">
                                $<%= request.getAttribute("quarterlySales") != null ? request.getAttribute("quarterlySales") : "0.00" %>
                            </p>
                        </div>
                        <i class="fa-solid fa-chart-bar text-2xl text-blue-500 opacity-60"></i>
                    </div>
                </div>
                <div class="dashboard-card p-5 hover-scale fade-in-up">
                    <div class="flex justify-between items-center">
                        <div>
                            <h2 class="text-md font-semibold text-gray-700">Yearly Sales</h2>
                            <p class="text-2xl font-bold text-blue-600 mt-1">
                                $<%= request.getAttribute("yearlySales") != null ? request.getAttribute("yearlySales") : "0.00" %>
                            </p>
                        </div>
                        <i class="fa-solid fa-chart-pie text-2xl text-blue-500 opacity-60"></i>
                    </div>
                </div>
            </div>

            <!-- Charts -->
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div class="chart-container hover-scale fade-in-up">
                    <h2 class="text-md font-semibold text-gray-700 mb-4">Daily Sales (Last 30 Days)</h2>
                    <canvas id="dailySalesChart"></canvas>
                </div>
                <div class="chart-container hover-scale fade-in-up">
                    <h2 class="text-md font-semibold text-gray-700 mb-4">Yearly Sales</h2>
                    <canvas id="yearlySalesChart"></canvas>
                </div>
            </div>
        </div>
    </main>

    <!-- JavaScript -->
    <script>
        // Sidebar functionality
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
        menuBtn.addEventListener('click', () => sidebar.classList.remove('hidden'));
        closeBtn.addEventListener('click', () => sidebar.classList.add('hidden'));
        window.addEventListener('resize', updateSidebarVisibility);

        // Chart data handling with validation
        const parseChartData = (dataString, defaultData, maxLength) => {
            if (!dataString || dataString === "null" || typeof dataString !== 'string') {
                console.warn('Invalid dataString, using default:', defaultData);
                return defaultData.split(',').map(Number).slice(0, maxLength);
            }
            try {
                const parsed = dataString.split(',')
                    .map(num => parseFloat(num.trim()) || 0)
                    .filter(num => !isNaN(num))
                    .slice(0, maxLength);
                console.log('Parsed data:', parsed);
                return parsed.length > 0 ? parsed : defaultData.split(',').map(Number).slice(0, maxLength);
            } catch (e) {
                console.error('Error parsing chart data:', e);
                return defaultData.split(',').map(Number).slice(0, maxLength);
            }
        };

        // Dynamic label generation
        const generateLabels = (dataArray, prefix = 'Day', startYear = 2019, maxLength) => {
            const length = Math.min(dataArray.length, maxLength);
            if (prefix === 'Day') {
                return Array.from({ length }, (_, i) => `${prefix} ${i + 1}`);
            } else {
                return Array.from({ length }, (_, i) => (startYear + i).toString());
            }
        };

        // Daily Sales Data
        const dailySalesRaw = "<%= request.getAttribute("dailySalesData") != null ? request.getAttribute("dailySalesData") : "120,190,300,500,200,300,450,600,700,800,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2100,2200,2300,2400,2500,2600,2700,2800" %>";
        const dailyDefault = "120,190,300,500,200,300,450,600,700,800,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2100,2200,2300,2400,2500,2600,2700,2800";
        const maxDailyLength = 30;
        const dailySalesValues = parseChartData(dailySalesRaw, dailyDefault, maxDailyLength);
        const dailySalesLabels = generateLabels(dailySalesValues, 'Day', 2019, maxDailyLength);
        const dailySalesData = {
            labels: dailySalesLabels,
            datasets: [{
                label: 'Daily Sales ($)',
                data: dailySalesValues,
                backgroundColor: 'rgba(59, 130, 246, 0.2)',
                borderColor: '#3b82f6',
                borderWidth: 2,
                tension: 0.4,
                fill: true
            }]
        };

        // Yearly Sales Data
        const yearlySalesRaw = "<%= request.getAttribute("yearlySalesData") != null ? request.getAttribute("yearlySalesData") : "5000,7000,9000,12000,15000,20000" %>";
        const yearlyDefault = "5000,7000,9000,12000,15000,20000";
        const maxYearlyLength = 10;
        const yearlySalesValues = parseChartData(yearlySalesRaw, yearlyDefault, maxYearlyLength);
        const yearlySalesLabels = generateLabels(yearlySalesValues, 'Year', 2019, maxYearlyLength);
        const yearlySalesData = {
            labels: yearlySalesLabels,
            datasets: [{
                label: 'Yearly Sales ($)',
                data: yearlySalesValues,
                backgroundColor: 'rgba(59, 130, 246, 0.2)',
                borderColor: '#3b82f6',
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
                    grid: { color: 'rgba(0, 0, 0, 0.1)' },
                    ticks: { callback: value => '$' + value }
                },
                x: {
                    grid: { display: false }
                }
            },
            plugins: {
                legend: { position: 'top' },
                tooltip: { callbacks: { label: context => `${context.dataset.label}: $${context.parsed.y}` } }
            }
        };

        // Initialize Charts
        const dailyChartCtx = document.getElementById('dailySalesChart').getContext('2d');
        const yearlyChartCtx = document.getElementById('yearlySalesChart').getContext('2d');

        new Chart(dailyChartCtx, {
            type: 'line',
            data: dailySalesData,
            options: chartOptions
        });

        new Chart(yearlyChartCtx, {
            type: 'line',
            data: yearlySalesData,
            options: chartOptions
        });
    </script>
</body>
</html>