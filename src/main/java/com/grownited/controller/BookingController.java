package com.grownited.controller;

import java.time.LocalTime;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.grownited.dto.IdDto;
import com.grownited.entity.BookingEntity;
import com.grownited.entity.PackageEntity;
import com.grownited.entity.ServiceEntity;
import com.grownited.entity.UserEntity;
import com.grownited.enumD.Bookstatus;
import com.grownited.repository.BookingRepository;
import com.grownited.repository.CategoryRepository;
import com.grownited.repository.PackageRepository;
import com.grownited.repository.ServicesRepository;
import com.grownited.repository.UserRepository;
import com.grownited.service.MailService;

import jakarta.servlet.http.HttpSession;


@Controller
public class BookingController {

	@Autowired
	private CategoryRepository categoryRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private ServicesRepository servicesRepository;
	
	@Autowired
	private PackageRepository packageRepository;
	
	@Autowired
	private BookingRepository bookingRepository;
	
	@Autowired
	private MailService mailService;
	
	//booking jsp
	@GetMapping("bookingservice")
	public String bookingService(IdDto idDto,Model model,HttpSession httpSession) {
		
		UUID userId = (UUID) httpSession.getAttribute("userId");
		if (userId == null) {
		    System.out.println("UserId not found in session!");
		    return "redirect:/login";  // Redirect user to login if session expired or not set
		}

		Optional<ServiceEntity>op=	servicesRepository.findById(idDto.getServiceId());
		if(op.isEmpty()) {
			return "redirect:/categorydetails";
		}
		//here we need to fetch the details of the packgeEntity through the 
		Optional<PackageEntity>po=	packageRepository.findById(idDto.getPackageId());
		System.out.println("Session Scope user Id "+userId);
		System.out.println("Booking Service : Provider Id"+op.get().getUserEntity().getUserId());
		model.addAttribute("serviceWcu",op.get());
		model.addAttribute("packages", po.get());
		
		System.out.println("Category From booking service"+op.get().getCategory());
		System.out.println("User From booking service"+op.get().getUserEntity());
		
		//categoryId,providerId,serviceId,packageId
		return "BookingService";
	}
	
	
	
	@PostMapping("/save/bookservice")
//	@RequestMapping(method = RequestMethod.POST) // Explicitly specify
	public String userBookedService(@RequestParam UUID userId,
            @RequestParam UUID providerId,
            @RequestParam UUID serviceId,
            @RequestParam UUID packageId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date bookingDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) LocalTime bookingTime) {
		System.out.println("----");
        // Fetch UserEntity (Customer)
        UserEntity user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        // Fetch UserEntity (Service Provider)
        UserEntity serviceProvider = userRepository.findById(providerId)
                .orElseThrow(() -> new RuntimeException("Service Provider not found"));

        // Fetch ServiceEntity
        ServiceEntity service = servicesRepository.findById(serviceId)
                .orElseThrow(() -> new RuntimeException("Service not found"));

        // Fetch PackageEntity
        PackageEntity packageEntity = packageRepository.findById(packageId)
                .orElseThrow(() -> new RuntimeException("Package not found"));

        System.out.println("userId "+userId);
        System.out.println("Provider Id"+providerId);
        // Create BookingEntity Object
        BookingEntity booking=new BookingEntity();
        booking.setUser(user);
        booking.setServiceProvider(serviceProvider);
        booking.setService(service);
        booking.setPackageEntity(packageEntity);
        booking.setBookingDate(bookingDate);
        booking.setBookingTime(bookingTime);
        booking.setStatus(Bookstatus.PENDING); // Default status

        // Save Booking
        bookingRepository.save(booking);

        return "redirect:/loginuserhome";
	}
//	
//	
//	
	
//	@PostMapping("/bookservice")
//	public String userBookedService(@RequestParam UUID userId,
//	                                @RequestParam UUID providerId,
//	                                @RequestParam UUID serviceId,
//	                                @RequestParam UUID packageId,
//	                                @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date bookingDate,
//	                                @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) LocalTime bookingTime) {
//
//	    // Check if provider is already booked at the same date & time
//		if (bookingRepository.countByServiceProvider_UserIdAndBookingDateAndBookingTime(providerId, bookingDate, bookingTime) > 0) {
//		    throw new RuntimeException("Service provider is already booked at this date and time. Please select another time.");
//		}
//
//
//	    // Fetch required entities
//	    UserEntity user = userRepository.findById(userId)
//	            .orElseThrow(() -> new RuntimeException("User not found"));
//
//	    UserEntity serviceProvider = userRepository.findById(providerId)
//	            .orElseThrow(() -> new RuntimeException("Service Provider not found"));
//
//	    ServiceEntity service = servicesRepository.findById(serviceId)
//	            .orElseThrow(() -> new RuntimeException("Service not found"));
//
//	    PackageEntity packageEntity = packageRepository.findById(packageId)
//	            .orElseThrow(() -> new RuntimeException("Package not found"));
//
//	    // Create BookingEntity Object
//	    BookingEntity booking = new BookingEntity();
//	    booking.setUser(user);
//	    booking.setServiceProvider(serviceProvider);
//	    booking.setService(service);
//	    booking.setPackageEntity(packageEntity);
//	    booking.setBookingDate(bookingDate);
//	    booking.setBookingTime(bookingTime);
//	    booking.setStatus(Bookstatus.PENDING); // Default status
//
//	    // Save Booking
//	    bookingRepository.save(booking);
//
//	    return "redirect:/loginuserhome";
//	}

	// open the booking history jsp for the user
//	@GetMapping("/bookinghistoryuser")
//	public String bookingHistoryForUser(HttpSession httpSession,Model model) {
//		System.out.println("Bookig Hostory method is called");
//		UUID userId=(UUID)httpSession.getAttribute("userId");
//		List<BookingEntity>bookingList= bookingRepository.findByUser_UserId(userId);
//		System.out.println("Booking list"+bookingList.get(0).getBookingId());
//		model.addAttribute("bookingList", bookingList);
//		return "BookingHistoryForUser";
//	}
	
	@GetMapping("/bookinghistoryuser")
	public String bookingHistoryForUser(HttpSession httpSession, Model model) {
	    System.out.println("Booking History method is called");
	    
	    UUID userId = (UUID) httpSession.getAttribute("userId");
	    
	    if (userId == null) {
	        System.out.println("Error: userId is null");
	        return "redirect:/login";  // Redirect to login page if session expired
	    }

	    List<BookingEntity> bookingList = bookingRepository.findByUser_UserId(userId);
	    
	    if (bookingList.isEmpty()) {
	        System.out.println("No bookings found");
	    } else {
	        System.out.println("Booking list: " + bookingList.get(0).getBookingId());
	    }
	    
	    model.addAttribute("bookingList", bookingList);
	    return "BookingHistoryForUser";
	}

	
	//this for the service Provider
	@GetMapping("/provider/bookings")
    public String getBookingsForProvider(HttpSession httpSession,Model model) {
		UUID providerId=(UUID) httpSession.getAttribute("userId");
		System.out.println("provider Id is : "+providerId);
		List<BookingEntity>bookingList=	bookingRepository.findByService_UserEntity_UserId(providerId);
//		System.out.println("Booking list is "+bookingList.get(0).getServiceProvider().getName());
//		System.out.println("Booking list is user "+bookingList.get(0).getUser().getUserAddressEntity().getAddressLine());
//		System.out.println("service name"+bookingList.get(0).getService().getServiceName());
		System.out.println("Total Bookings Found: " + bookingList.size());
		for (BookingEntity booking : bookingList) {
		    System.out.println("Booking ID: " + booking.getBookingId());
		    System.out.println("Service Name: " + booking.getService().getServiceName());
		    System.out.println("User Name: " + booking.getUser().getName());
		    System.out.println("Booking Date: " + booking.getBookingDate());
		    System.out.println("Status: " + booking.getStatus());
		}

		model.addAttribute("bookings",bookingList );
        return "ProviderBookings";
    }
	
	
//	@PostMapping("/provider/updatebookingstatus")
//	public String updateBookingStatus(BookingEntity bookingEntity) {
//		Optional<BookingEntity> op=bookingRepository.findById(bookingEntity.getBookingId());
//		if(op.isEmpty()) {
//			return "redirect:/provider/bookings";
//		}
//		op.get().setStatus(bookingEntity.getStatus());
//		bookingRepository.save(op.get());
//		return "redirect:/provider/bookings";
//	}
	
	
	@PostMapping("/provider/updatebookingstatus")
	public String updateBookingStatus(BookingEntity bookingEntity) {
	    Optional<BookingEntity> op = bookingRepository.findById(bookingEntity.getBookingId());
	    
	    if (op.isEmpty()) {
	        return "redirect:/provider/bookings";
	    }

	    BookingEntity booking = op.get();
	    booking.setStatus(bookingEntity.getStatus());
	    bookingRepository.save(booking);

	    // Fetch user and service provider emails
	    String userEmail = booking.getUser().getEmailId();
	    String providerEmail = booking.getServiceProvider().getEmailId();

	    // Send notification email to the user
	    String subject = "Booking Status Updated";
	    String message = "Dear " + booking.getUser().getName() + ",\n\n" +
	                     "Your booking status has been updated to: " + booking.getStatus() + ".\n" +
	                     "If you have any questions, please contact your service provider at " + providerEmail + ".\n\n" +
	                     "Thank you for using our service.\n\n" +
	                     "Best Regards,\n" +
	                     "Urban Service Team";

	    mailService.sendEmail(userEmail, providerEmail,subject, message);

	    return "redirect:/provider/bookings";
	}
	
	
	
	
	

}
