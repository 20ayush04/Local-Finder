package com.grownited.controller;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.grownited.entity.CategoryEntity;
import com.grownited.entity.UserEntity;
import com.grownited.enumD.Bookstatus;
import com.grownited.repository.BookingRepository;
import com.grownited.repository.CategoryRepository;
import com.grownited.repository.UserRepository;
import com.grownited.service.AdminDashboardService;
import com.grownited.service.CategoryService;

import jakarta.servlet.http.HttpSession;


@Controller
public class PageController {

	@Autowired
	private CategoryService categoryService;
	@Autowired
	private BookingRepository bookingRepository;
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private CategoryRepository categoryRepository;
//	opening home page
	@GetMapping(value = {"/", "/home"})
	public String openHomePage(HttpSession httpSession,Model model) {
//		UUID userId=(UUID)httpSession.getAttribute("userId");
//		 System.out.println("Session User ID: " + userId);  // Debugging line
//		    
//		if(userId == null) {
			List<CategoryEntity> categoryList=categoryService.getAllCategory();
			model.addAttribute("categories", categoryList);
			return "Home";
			
//		}
//		return "redirect:/loginuserhome";
//		System.out.println("Home page is called");
		
	}

	
	@GetMapping("/aboutus")
	public String aboutUsPage() {
		return "About";
	}
	
	@GetMapping("/contactus")
	public String openContactUsPage() {
		return "ContactUs";
	}
	
	
	@GetMapping("/admin/dashboard")
	public String openAdminPanel() {
		return "AdminPanel";
	}
	
	
	@GetMapping("/loginuserhome")
	public String loginUserHome(Model model) {
		System.out.println("This login user home is called");
		List<CategoryEntity> categories = categoryRepository.findAll();
    	model.addAttribute("categories", categories);
		return "LoginUserHome";
	}
	
	
	@GetMapping("/service-provider/panel")
	public String serviceProviderPanel() {
		return "ServiceProviderPanel";
	}
	
	@GetMapping("/service-provider/dashboard")
	public String serviceProviderDashboard(Model model,HttpSession httpSession) {
		  Optional<UserEntity> op = userRepository.findById((UUID)httpSession.getAttribute("userId"));
		  Long totalBookings=bookingRepository.countByServiceProvider_UserId((UUID)httpSession.getAttribute("userId"));
		  Long completedBookings=bookingRepository.countByServiceProvider_UserIdAndStatus((UUID)httpSession.getAttribute("userId"),Bookstatus.ACCEPT);
		  Long pendingBookings=bookingRepository.countByServiceProvider_UserIdAndStatus((UUID)httpSession.getAttribute("userId"),Bookstatus.PENDING);
		  
		model.addAttribute("serviceProvider", op.get());
		model.addAttribute("totalBookings",totalBookings);
		model.addAttribute("completedBookings",completedBookings);
		model.addAttribute("pendingBookings", pendingBookings);
		return "ServiceProviderDashboard";
	}
	
//	 @Autowired
//	    private ServiceProviderDashboardService dashboardService;
//
//	    @GetMapping("/service-provider/dashboard")
//	    public String showServiceProviderDashboard(Model model, Principal principal) {
//	        // Assuming principal.getName() is the userId (UUID as String)
//	        UUID serviceProviderId = UUID.fromString(principal.getName());
//	        
//	        // Fetch service provider details
//	        UserEntity serviceProvider = dashboardService.getServiceProvider(serviceProviderId);
//	        
//	        // Set JSP attributes
//	        model.addAttribute("serviceProvider", serviceProvider);
//	        model.addAttribute("totalBookings", dashboardService.getTotalBookings(serviceProviderId));
//	        model.addAttribute("pendingBookings", dashboardService.getPendingBookings(serviceProviderId));
//	        model.addAttribute("completedBookings", dashboardService.getCompletedBookings(serviceProviderId));
//	        model.addAttribute("totalEarnings", String.format("%.2f", dashboardService.getTotalEarnings(serviceProviderId)));
//	        model.addAttribute("monthlyEarnings", String.format("%.2f", dashboardService.getMonthlyEarnings(serviceProviderId)));
//	        model.addAttribute("pendingPayments", String.format("%.2f", dashboardService.getPendingPayments(serviceProviderId)));
//	        model.addAttribute("recentBookings", dashboardService.getRecentBookings(serviceProviderId));
//
//	        return "ServiceProviderDashboard"; // Maps to serviceproviderdashboard.jsp
//	    }
	
//	@GetMapping("admindashboard")
//	public String adminDashborad() {
//		return "AdminDashboard";
//	}
//	
	
	 @Autowired
	    private AdminDashboardService adminDashboardService;

	    @GetMapping("/admindashboard")
	    public String showAdminDashboard(Model model) {
	        model.addAttribute("totalUsers", adminDashboardService.getTotalUsers());
	        model.addAttribute("totalBookings", adminDashboardService.getTotalBookings());
	        model.addAttribute("activeCustomers", adminDashboardService.getActiveCustomers());
	        model.addAttribute("totalEarnings", String.format("%.2f", adminDashboardService.getTotalEarnings()));
	        model.addAttribute("monthlySales", String.format("%.2f", adminDashboardService.getMonthlySales()));
	        model.addAttribute("quarterlySales", String.format("%.2f", adminDashboardService.getQuarterlySales()));
	        model.addAttribute("yearlySales", String.format("%.2f", adminDashboardService.getYearlySales()));

	        return "AdminDashboard"; // Maps to admindashboard.jsp
	    }
	@GetMapping("/errorpage")
	public String errorPage() {
		return "ErrorPage";
	}
	
	

}
