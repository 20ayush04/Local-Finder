//package com.grownited.controller;
//
//import com.grownited.entity.UserEntity;
//import com.grownited.service.ServiceProviderDashboardService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//
//import java.security.Principal;
//import java.util.UUID;
//
//@Controller
//public class ServiceProviderDashboardController {
//
//    @Autowired
//    private ServiceProviderDashboardService dashboardService;
//
//    @GetMapping("/service-provider/dashboard1")
//    public String showServiceProviderDashboard(Model model, Principal principal) {
//        UUID serviceProviderId = UUID.fromString(principal.getName());
//        UserEntity serviceProvider = dashboardService.getServiceProvider(serviceProviderId);
//
//        model.addAttribute("serviceProvider", serviceProvider);
//        model.addAttribute("totalBookings", dashboardService.getTotalBookings(serviceProviderId));
//        model.addAttribute("pendingBookings", dashboardService.getPendingBookings(serviceProviderId));
//        model.addAttribute("completedBookings", dashboardService.getCompletedBookings(serviceProviderId));
//        model.addAttribute("totalEarnings", String.format("%.2f", dashboardService.getTotalEarnings(serviceProviderId)));
//        model.addAttribute("monthlyEarnings", String.format("%.2f", dashboardService.getMonthlyEarnings(serviceProviderId)));
//        model.addAttribute("pendingPayments", String.format("%.2f", dashboardService.getPendingPayments(serviceProviderId)));
//        model.addAttribute("recentBookings", dashboardService.getRecentBookings(serviceProviderId));
//
//        return "serviceproviderdashboard1";
//    }
//}