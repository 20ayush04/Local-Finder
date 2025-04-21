<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit User</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body
	class="bg-gray-900 text-white flex items-center justify-center min-h-screen">

	<div class="bg-gray-800 p-6 rounded-lg shadow-lg w-full max-w-md">
		<h2 class="text-2xl font-bold text-center mb-4">Edit User</h2>

		<!-- Edit User Form -->
		<form action="/updateuser" method="post">
			<input type="hidden" name="userId" value="${user.userId}">

			<div class="mb-3">
				<label class="block text-gray-300">Name</label> <input type="text"
					name="name" value="${user.name}"
					class="w-full p-2 rounded bg-gray-700 text-white focus:outline-none">
			</div>

			<div class="mb-3">
				<label class="block text-gray-300">Email</label> <input type="email"
					name="emailId" value="${user.emailId}"
					class="w-full p-2 rounded bg-gray-700 text-white focus:outline-none">
			</div>

		

			<div class="mb-3">
				<label class="block text-gray-300">Phone</label> <input type="text"
					name="phone" value="${user.phone}"
					class="w-full p-2 rounded bg-gray-700 text-white focus:outline-none">
			</div>

			<div class="mb-3">
				<label class="block text-gray-300">Role</label> <select name="role"
					class="w-full p-2 rounded bg-gray-700 text-white focus:outline-none">
					<option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
					<option value="USER" ${user.role == 'USER' ? 'selected' : ''}>User</option>
				</select>
			</div>

			<div class="mb-3">
				<label class="block text-gray-300">Status</label> <select name="status"
					class="w-full p-2 rounded bg-gray-700 text-white focus:outline-none">
					<option value="ACTIVE" ${user.status == 'ACTIVE' ? 'selected' : ''}>Active</option>
					<option value="INACTIVE" ${user.status == 'INACTIVE' ? 'selected' : ''}>Inactive</option>
					<option value="SUSPENDED" ${user.status == 'SUSPENDED' ? 'selected' : ''}>Suspended</option>
				</select>
			</div>

			<!-- Buttons -->
			<div class="flex justify-between mt-4">
				<button type="submit"
					class="bg-blue-600 px-4 py-2 rounded text-white hover:bg-blue-700">Update</button>
				<button type="button" onclick="history.back()"
					class="bg-gray-600 px-4 py-2 rounded text-white hover:bg-gray-700">Back</button>
			</div>

		</form>
	</div>

</body>
</html>
