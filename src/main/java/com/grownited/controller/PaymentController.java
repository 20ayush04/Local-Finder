package com.grownited.controller;

import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.grownited.entity.PackageEntity;
import com.grownited.repository.PackageRepository;
import com.grownited.service.PaymentService;

@Controller
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private PackageRepository packageRepository;

    // Display the payment form with the selected package price
    @GetMapping("/payment/{bookingId}/{packageId}")
    public String showPaymentForm(@PathVariable("bookingId") UUID bookingId,
                                  @PathVariable("packageId") UUID packageId,
                                  Model model) {

        Optional<PackageEntity> optionalPackage = packageRepository.findById(packageId);

        if (!optionalPackage.isPresent() || optionalPackage.get().getPrice() == 0.0f) {
            model.addAttribute("error", "Invalid package ID or package price not found");
            return "error";  // Return an error page if package is invalid
        }

        PackageEntity packageEntity = optionalPackage.get();
        model.addAttribute("bookingId", bookingId);
        model.addAttribute("packageId", packageId);
        model.addAttribute("packagePrice", packageEntity.getPrice());

        return "payment";  // Show the payment form page
    }

    // Process the payment and validate the card details
    @PostMapping("/processPayment")
    public String processPayment(@RequestParam("bookingId") UUID bookingId,
                                 @RequestParam("packageId") UUID packageId,
                                 @RequestParam("amount") Double amount,
                                 @RequestParam("cardNumber") String cardNumber,
                                 @RequestParam("expiryDate") String expiryDate,
                                 @RequestParam("cvv") String cvv,
                                 @RequestParam("email") String email,
                                 Model model) {

        // Validate the card details
        if (!isValidCardNumber(cardNumber)) {
            model.addAttribute("cardNumberError", "Invalid card number. Must be 16 digits.");
            return returnToForm(bookingId, packageId, amount, model);
        }

        if (!isValidExpiryDate(expiryDate)) {
            model.addAttribute("expiryDateError", "Invalid expiry date. Use MM/YY format.");
            return returnToForm(bookingId, packageId, amount, model);
        }

        if (!isValidCvv(cvv)) {
            model.addAttribute("cvvError", "Invalid CVV. Must be 3 or 4 digits.");
            return returnToForm(bookingId, packageId, amount, model);
        }

        if (!isValidEmail(email)) {
            model.addAttribute("emailError", "Invalid email address.");
            return returnToForm(bookingId, packageId, amount, model);
        }

        // Call the payment service to process the payment
        boolean paymentSuccess = paymentService.run(
            amount,
            cardNumber,
            expiryDate,
            email
        );

        // Handle the payment outcome
        if (paymentSuccess) {
            return "redirect:/payment/success?bookingId=" + bookingId;
        } else {
            model.addAttribute("error", "Payment failed. Please check your details and try again.");
            return returnToForm(bookingId, packageId, amount, model);
        }
    }

    // Helper method to return the payment form with the necessary attributes in case of errors
    private String returnToForm(UUID bookingId, UUID packageId, Double amount, Model model) {
        model.addAttribute("bookingId", bookingId);
        model.addAttribute("packageId", packageId);
        model.addAttribute("packagePrice", amount);
        return "payment";  // Return the payment form again
    }

    // Input validation methods
    private boolean isValidCardNumber(String cardNumber) {
        return cardNumber != null && cardNumber.matches("\\d{16}");  // 16 digits
    }

    private boolean isValidExpiryDate(String expiryDate) {
        return expiryDate != null && expiryDate.matches("\\d{2}/\\d{2}");  // MM/YY format
    }

    private boolean isValidCvv(String cvv) {
        return cvv != null && cvv.matches("\\d{3,4}");  // 3 or 4 digits
    }

    private boolean isValidEmail(String email) {
        return email != null && email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$");  // Valid email format
    }

    // Payment Success Page
    @GetMapping("/payment/success")
    public String paymentSuccess(@RequestParam("bookingId") UUID bookingId, Model model) {
        model.addAttribute("message", "Payment successful! Your booking ID is " + bookingId);
        return "PaymentSuccess";  // Redirect to PaymentSuccess.jsp
    }

    // Payment Failure Page
    @GetMapping("/payment/fail")
    public String paymentFail(Model model) {
        model.addAttribute("message", "Payment failed. Please try again.");
        return "PaymentFail";  // Redirect to PaymentFail.jsp
    }
}
