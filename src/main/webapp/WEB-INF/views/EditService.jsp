<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Service - Local Finder</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1e3a8a 0%, #1e293b 100%);
            color: #e5e7eb;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
        }
        .form-container {
            background: #ffffff;
            border-radius: 1rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            padding: 2rem;
            width: 100%;
            max-width: 28rem;
            animation: fadeInUp 0.6s ease-out;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        h2 {
            color: #1f2937;
            font-weight: 700;
            text-align: center;
            margin-bottom: 1.5rem;
        }
        label {
            color: #374151;
            font-weight: 600;
            font-size: 0.875rem;
            margin-bottom: 0.25rem;
            display: block;
        }
        input, textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #d1d5db;
            border-radius: 0.5rem;
            background: #f9fafb;
            color: #374151;
            transition: all 0.3s ease;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.05);
        }
        input:focus, textarea:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3);
        }
        textarea {
            resize: vertical;
            min-height: 100px;
        }
        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
            text-align: center;
            display: inline-block;
        }
        .btn-primary {
            background: linear-gradient(90deg, #3b82f6, #1e40af);
            color: #fff;
        }
        .btn-primary:hover {
            background: linear-gradient(90deg, #1e40af, #3b82f6);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(59, 130, 246, 0.4);
        }
        .btn-secondary {
            background: #6b7280;
            color: #fff;
        }
        .btn-secondary:hover {
            background: #4b5563;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(107, 114, 128, 0.4);
        }
        .btn-back {
            background: #9ca3af;
            color: #fff;
        }
        .btn-back:hover {
            background: #6b7280;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(107, 114, 128, 0.4);
        }
        @media (max-width: 640px) {
            .form-container {
                padding: 1.5rem;
                max-width: 100%;
            }
            h2 {
                font-size: 1.5rem;
            }
            .btn-group {
                flex-direction: column;
                gap: 0.5rem;
            }
            .btn {
                width: 100%;
            }
        }
        body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #f3f4f6, #d1d5db); /* Lighter background */
    color: #374151;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 1rem;
}

.form-container {
    background: #ffffff;
    border-radius: 1rem;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
    padding: 2rem;
    width: 100%;
    max-width: 28rem;
    animation: fadeInUp 0.6s ease-out;
}

input, textarea {
    width: 100%;
    padding: 1rem; /* Increased padding */
    border: 1px solid #d1d5db;
    border-radius: 0.5rem;
    background: #f9fafb;
    color: #000000; /* Black text */
    transition: all 0.3s ease;
    box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.05);
}

input:focus, textarea:focus {
    outline: none;
    border-color: #3b82f6;
    box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3);
}

textarea {
    resize: vertical;
    min-height: 120px; /* Slightly increased height */
}
        
    </style>
</head>
<body>
    <div class="form-container">
        <h2 class="text-2xl md:text-3xl">
            <i class="fa-solid fa-tools mr-2 text-blue-600"></i> Edit Service
        </h2>
        <form action="/updateservice" method="post" class="space-y-6">
            <input type="hidden" name="serviceId" value="${service.serviceId}">
            <div>
                <label for="serviceName">Service Name</label>
                <input type="text" id="serviceName" name="serviceName" value="${service.serviceName}"
                    class="w-full p-[10px] " required>
            </div>
            <div>
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="4" class="w-full p-[10px]" required>${service.description}</textarea>
            </div>
            <div class="btn-group flex justify-between">
                <a href="/servicelistprovider" class="btn btn-secondary">Cancel</a>
                <button type="submit" class="btn btn-primary">Save Changes</button>
            </div>
            <div class="text-center">
                <button type="button" onclick="history.back()" class="btn btn-back">Go Back</button>
            </div>
        </form>
    </div>
</body>
</html>