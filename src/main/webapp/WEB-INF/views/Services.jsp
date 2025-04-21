<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Service Categories - Home Solutions</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
    <header class="gradient-bg text-white py-8">
        <div class="max-w-6xl mx-auto px-4 flex items-center justify-between">
            <h1 class="text-3xl font-bold">Home Solutions</h1>
        </div>
    </header>

    <main class="max-w-6xl mx-auto mt-12 px-4">
        <section class="mb-16">
            <h2 class="text-3xl font-bold text-gray-800 mb-8">Our Categories</h2>

            <!-- Category List -->
            <div id="categoriesGrid" class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6">
                <c:set var="categories">
                    <c:forEach var="category" items="${requestScope.categories}">
                        <div class="category-card bg-white p-6 rounded-xl shadow-md hover-scale flex items-center justify-between">
                            <h3 class="text-lg font-semibold text-gray-800">${category.name}</h3>
                            <span class="text-sm text-gray-500">${category.services} Services</span>
                        </div>
                    </c:forEach>
                </c:set>
            </div>

            <!-- See More Button -->
            <div class="text-center mt-6">
                <button id="seeMoreCategories" class="bg-blue-600 text-white px-6 py-2 rounded-lg">
                    See More Categories
                </button>
            </div>
        </section>

        <!-- Filter & Search -->
        <section class="mb-12">
            <h2 class="text-3xl font-bold text-blue-700 mb-6">Explore Services</h2>
            <div class="flex gap-4">
                <select id="categoryFilter" class="p-3 border rounded-lg bg-white text-gray-700">
                    <option value="all">All Categories</option>
                    <option value="cleaning">Home Cleaning</option>
                    <option value="electrician">Electrician Services</option>
                    <option value="plumbing">Plumbing</option>
                    <option value="carpentry">Carpentry</option>
                    <option value="painting">Painting</option>
                </select>
                <input type="text" id="searchInput" placeholder="Search services..." class="p-3 border rounded-lg w-72">
            </div>
        </section>

        <!-- Services Grid -->
        <section id="servicesGrid" class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <c:forEach var="service" items="${requestScope.services}">
                <div class="service-card bg-white p-6 rounded-2xl shadow-lg hover-scale" data-category="${service.category}">
                    <img src="${service.img}" alt="${service.title}" class="w-full h-48 object-cover rounded-lg mb-4">
                    <h3 class="text-xl font-semibold text-gray-800">${service.title}</h3>
                </div>
            </c:forEach>
        </section>
    </main>

    <!-- JavaScript -->
    <script>
        document.getElementById("seeMoreCategories").addEventListener("click", function() {
            document.querySelectorAll(".hidden-items").forEach(el => {
                el.classList.remove("hidden-items");
                el.classList.add("slide-in");
            });
            this.style.display = "none";
        });

        document.getElementById("categoryFilter").addEventListener("change", function() {
            let selected = this.value;
            document.querySelectorAll(".service-card").forEach(card => {
                if (selected === "all" || card.dataset.category === selected) {
                    card.style.display = "block";
                } else {
                    card.style.display = "none";
                }
            });
        });
    </script>
</body>
</html>
