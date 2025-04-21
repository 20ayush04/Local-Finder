<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Details</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .error { color: #dc2626; font-size: 0.875rem; }
        .card-number::-webkit-inner-spin-button,
        .card-number::-webkit-outer-spin-button,
        .cvv::-webkit-inner-spin-button,
        .cvv::-webkit-outer-spin-button { -webkit-appearance: none; margin: 0; }
    </style>
</head>
<body class="bg-gradient-to-tr from-green-100 via-white to-green-50 min-h-screen flex items-center justify-center p-4">
    <div class="w-full max-w-lg bg-white rounded-2xl shadow-2xl px-8 py-10 transition-all duration-300">
        <h2 class="text-3xl font-bold text-center text-gray-800 mb-6">Secure Payment</h2>

        <c:if test="${not empty error}">
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4 text-sm">
                ${error}
            </div>
        </c:if>

        <form action="/processPayment" method="post" class="space-y-5">
            <input type="hidden" name="bookingId" value="${bookingId}">
            <input type="hidden" name="packageId" value="${packageId}">
            <input type="hidden" name="amount" value="${packagePrice}">

            <div>
                <label for="amount" class="block text-sm font-medium text-gray-700">Amount</label>
                <input type="text" id="amount" value="${packagePrice}"
                       class="mt-1 block w-full px-4 py-2 bg-gray-100 border border-gray-300 rounded-lg text-gray-800 cursor-not-allowed"
                       readonly>
            </div>

            <div>
                <label for="cardNumber" class="block text-sm font-medium text-gray-700">Card Number</label>
                <input type="number" id="cardNumber" name="cardNumber"
                       class="card-number mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 transition duration-200"
                       placeholder="1234 5678 9012 3456" required pattern="\d{16}" title="Card number must be 16 digits">
                <c:if test="${not empty cardNumberError}">
                    <p class="error">${cardNumberError}</p>
                </c:if>
            </div>

            <div class="flex space-x-4">
                <div class="flex-1">
                    <label for="expiryDate" class="block text-sm font-medium text-gray-700">Expiry Date</label>
                    <input type="text" id="expiryDate" name="expiryDate"
                           class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 transition duration-200"
                           placeholder="MM/YY" required pattern="\d{2}/\d{2}" title="Enter date in MM/YY format">
                    <c:if test="${not empty expiryDateError}">
                        <p class="error">${expiryDateError}</p>
                    </c:if>
                </div>
                <div class="flex-1">
                    <label for="cvv" class="block text-sm font-medium text-gray-700">CVV</label>
                    <input type="number" id="cvv" name="cvv"
                           class="cvv mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 transition duration-200"
                           placeholder="123" required pattern="\d{3,4}" title="CVV must be 3 or 4 digits">
                    <c:if test="${not empty cvvError}">
                        <p class="error">${cvvError}</p>
                    </c:if>
                </div>
            </div>

            <div>
                <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                <input type="email" id="email" name="email"
                       class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 transition duration-200"
                       placeholder="you@example.com" required>
                <c:if test="${not empty emailError}">
                    <p class="error">${emailError}</p>
                </c:if>
            </div>

            <button type="submit"
                    class="w-full bg-green-600 text-white font-semibold py-2 rounded-lg hover:bg-green-700 shadow hover:shadow-md transition duration-300">
                Pay Now
            </button>
        </form>

        <p class="mt-5 text-center text-sm text-gray-600">
            <a href="/cancel" class="text-green-600 hover:underline">Cancel Payment</a>
        </p>
    </div>

    <script>
        document.getElementById('cardNumber').addEventListener('input', function(e) {
            if (this.value.length > 16) {
                this.value = this.value.slice(0, 16);
            }
        });

        document.getElementById('expiryDate').addEventListener('input', function(e) {
            let value = this.value.replace(/\D/g, '');
            if (value.length >= 3) {
                value = value.slice(0, 2) + '/' + value.slice(2, 4);
            }
            this.value = value;
        });

        document.getElementById('cvv').addEventListener('input', function(e) {
            if (this.value.length > 4) {
                this.value = this.value.slice(0, 4);
            }
        });
    </script>
</body>
</html>
