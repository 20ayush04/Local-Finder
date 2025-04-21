package com.grownited.repository;

import java.time.LocalTime;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.grownited.entity.BookingEntity;
import com.grownited.enumD.Bookstatus;

@Repository
public interface BookingRepository extends JpaRepository<BookingEntity, UUID> {

	List<BookingEntity> findByUser_UserId(UUID userId);
	 // Find bookings where the service provider's userId matches
    List<BookingEntity> findByServiceUserEntityUserId(UUID providerId);
    
    
    List<BookingEntity> findByService_UserEntity_UserId(UUID providerId);
    // Check if provider is already booked for the given date and time
    Long countByServiceProvider_UserIdAndBookingDateAndBookingTime(UUID serviceProviderId, Date bookingDate, LocalTime bookingTime);

    
    long countByServiceProvider_UserId(UUID serviceProviderId);

    // ✅ Pending bookings for a service provider
    long countByServiceProvider_UserIdAndStatus(UUID serviceProviderId, Bookstatus status);
	List<BookingEntity> findByBookingDateBetweenAndStatus(Date startDate, Date endDate, Bookstatus accept);
    
    
    
//    
//    
//    long count();
//
//    // Bookings by Date Range and Status for Earnings
//    @Query("SELECT b FROM BookingEntity b WHERE b.bookingDate >= :startDate AND b.bookingDate <= :endDate AND b.status = :status")
//    List<BookingEntity> findByBookingDateBetweenAndStatus(@Param("startDate") Date startDate, @Param("endDate") Date endDate, @Param("status") Bookstatus status);
//    
//    
//    
//    
//    
//    //for service Provider
//    long countByServiceProviderUserId(UUID serviceProviderId);
//
//    long countByServiceProviderUserIdAndStatus(UUID serviceProviderId, Bookstatus status);
//
//    @Query("SELECT b FROM BookingEntity b WHERE b.serviceProvider.userId = :serviceProviderId AND b.status = :status AND b.bookingDate >= :startDate AND b.bookingDate <= :endDate")
//    List<BookingEntity> findByServiceProviderUserIdAndStatusAndBookingDateBetween(
//            @Param("serviceProviderId") UUID serviceProviderId,
//            @Param("status") Bookstatus status,
//            @Param("startDate") Date startDate,
//            @Param("endDate") Date endDate
//    );
//
//    @Query(value = "SELECT b.booking_id, u.name, s.service_name, b.booking_date, b.status " +
//           "FROM Bookings b " +
//           "JOIN users u ON b.user_id = u.user_id " +
//           "JOIN services s ON b.service_id = s.service_id " +
//           "WHERE b.service_provider_id = :serviceProviderId " +
//           "ORDER BY b.booking_date DESC LIMIT 5")
//    List<Object[]> findTopRecentBookingsByServiceProviderId(@Param("serviceProviderId") UUID serviceProviderId);
}