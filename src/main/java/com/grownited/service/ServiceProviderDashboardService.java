//package com.grownited.service;
//
//import com.grownited.entity.BookingEntity;
//import com.grownited.entity.UserEntity;
//import com.grownited.enumD.Bookstatus;
//import com.grownited.repository.BookingRepository;
//import com.grownited.repository.UserRepository;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import java.time.LocalDate;
//import java.time.ZoneId;
//import java.util.Date;
//import java.util.List;
//import java.util.UUID;
//
//@Service
//public class ServiceProviderDashboardService {
//
//    @Autowired
//    private UserRepository userRepository;
//
//    @Autowired
//    private BookingRepository bookingRepository;
//
//    public UserEntity getServiceProvider(UUID userId) {
//        return userRepository.findByUserId(userId);
//    }
//
//    public Long getTotalBookings(UUID serviceProviderId) {
//        return bookingRepository.countByServiceProviderUserId(serviceProviderId);
//    }
//
//    public Long getPendingBookings(UUID serviceProviderId) {
//        return bookingRepository.countByServiceProviderUserIdAndStatus(serviceProviderId, Bookstatus.PENDING);
//    }
//
//    public Long getCompletedBookings(UUID serviceProviderId) {
//        return bookingRepository.countByServiceProviderUserIdAndStatus(serviceProviderId, Bookstatus.ACCEPT);
//    }
//
//    public Double getTotalEarnings(UUID serviceProviderId) {
//        LocalDate startLocalDate = LocalDate.of(2000, 1, 1);
//        LocalDate endLocalDate = LocalDate.now();
//        Date startDate = Date.from(startLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
//        Date endDate = Date.from(endLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
//        return calculateEarnings(serviceProviderId, Bookstatus.ACCEPT, startDate, endDate);
//    }
//
//    public Double getMonthlyEarnings(UUID serviceProviderId) {
//        LocalDate startLocalDate = LocalDate.now().withDayOfMonth(1);
//        LocalDate endLocalDate = LocalDate.now();
//        Date startDate = Date.from(startLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
//        Date endDate = Date.from(endLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
//        return calculateEarnings(serviceProviderId, Bookstatus.ACCEPT, startDate, endDate);
//    }
//
//    public Double getPendingPayments(UUID serviceProviderId) {
//        LocalDate startLocalDate = LocalDate.of(2000, 1, 1);
//        LocalDate endLocalDate = LocalDate.now();
//        Date startDate = Date.from(startLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
//        Date endDate = Date.from(endLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
//        return calculateEarnings(serviceProviderId, Bookstatus.PENDING, startDate, endDate);
//    }
//
//    private Double calculateEarnings(UUID serviceProviderId, Bookstatus status, Date startDate, Date endDate) {
//        List<BookingEntity> bookings = bookingRepository.findByServiceProviderUserIdAndStatusAndBookingDateBetween(
//                serviceProviderId, status, startDate, endDate);
//        return bookings.stream()
//                .mapToDouble(b -> b.getPackageEntity().getPrice() + b.getPackageEntity().getTax() - b.getPackageEntity().getCommission())
//                .sum();
//    }
//
//    public List<Object[]> getRecentBookings(UUID serviceProviderId) {
//        return bookingRepository.findTopRecentBookingsByServiceProviderId(serviceProviderId);
//    }
//}