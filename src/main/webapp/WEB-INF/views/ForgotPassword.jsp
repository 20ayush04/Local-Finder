<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - Local Finder</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .fade-in {
            animation: fadeIn 0.6s ease-out forwards;
        }
        .hover-scale {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .hover-scale:hover {
            transform: scale(1.03);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
        input {
            transition: all 0.3s ease;
        }
        input:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3);
        }
    </style>
</head>
<body class="bg-gradient-to-br from-gray-50 to-blue-100 min-h-screen flex items-center justify-center p-4">

    <div class="max-w-md w-full mx-auto shadow-[0_2px_10px_-2px_rgba(59,130,246,0.5)] p-8 bg-white rounded-2xl relative fade-in">
        <!-- Logo -->
        <div class="bg-white w-24 h-24 border-[8px] border-blue-500 p-4 absolute left-0 right-0 mx-auto -top-12 rounded-full overflow-hidden hover-scale">
            <a href="/">
                <img src="https://readymadeui.com/readymadeui-short.svg" alt="Urban Service Logo" class="w-full h-full object-contain" />
            </a>
        </div>

        <!-- Form -->
        <form class="mt-12" action="sendotp" method="post">
            <h3 class="text-2xl font-bold text-blue-600 mb-6 text-center">Forgot Password</h3>
            <div class="space-y-5">
                <div>
                    <input name="emailId" type="email" 
                           class="w-full px-4 py-3 bg-gray-50 text-gray-800 text-sm border border-gray-200 rounded-lg focus:bg-transparent focus:outline-none placeholder-gray-500" 
                           placeholder="Enter your email" required />
                </div>
            </div>

            <button type="submit" 
                    class="w-full py-3 px-4 mt-6 text-sm tracking-wide text-white bg-blue-600 hover:bg-blue-700 rounded-lg transition duration-300 hover-scale">
                Send OTP
            </button>

            <p class="text-sm mt-6 text-center text-gray-600">
                Back to 
                <a href="/login" class="text-blue-600 font-semibold hover:underline ml-1">Login</a>
            </p>
        </form>
    </div>

</body>
</html>