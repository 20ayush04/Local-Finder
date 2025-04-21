package com.grownited.service;

import com.grownited.entity.BookingEntity;
import com.grownited.enumD.Bookstatus;
import com.grownited.enumD.Role;
import com.grownited.enumD.Status;
import com.grownited.repository.BookingRepository;
import com.grownited.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

@Service
public class AdminDashboardService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BookingRepository bookingRepository;

    public Long getTotalUsers() {
        return userRepository.count();
    }

    public Long getActiveCustomers() {
        return userRepository.countByRoleAndStatus(Role.USER, Status.ACTIVE);
    }

    public Long getTotalBookings() {
        return bookingRepository.count();
    }

    public Double getTotalEarnings() {
        LocalDate startLocalDate = LocalDate.of(2000, 1, 1); // Arbitrary early date
        LocalDate endLocalDate = LocalDate.now();
        Date startDate = Date.from(startLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
        Date endDate = Date.from(endLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
        return calculateEarnings(startDate, endDate);
    }

    public Double getMonthlySales() {
        LocalDate startLocalDate = LocalDate.now().withDayOfMonth(1);
        LocalDate endLocalDate = LocalDate.now();
        Date startDate = Date.from(startLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
        Date endDate = Date.from(endLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
        return calculateEarnings(startDate, endDate);
    }

    public Double getQuarterlySales() {
        LocalDate startLocalDate = LocalDate.now().minusMonths(3).withDayOfMonth(1);
        LocalDate endLocalDate = LocalDate.now();
        Date startDate = Date.from(startLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
        Date endDate = Date.from(endLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
        return calculateEarnings(startDate, endDate);
    }

    public Double getYearlySales() {
        LocalDate startLocalDate = LocalDate.now().withDayOfYear(1);
        LocalDate endLocalDate = LocalDate.now();
        Date startDate = Date.from(startLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
        Date endDate = Date.from(endLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
        return calculateEarnings(startDate, endDate);
    }

    private Double calculateEarnings(Date startDate, Date endDate) {
        List<BookingEntity> bookings = bookingRepository.findByBookingDateBetweenAndStatus(startDate, endDate, Bookstatus.ACCEPT);
        return bookings.stream()
                .mapToDouble(b -> b.getPackageEntity().getPrice() + b.getPackageEntity().getTax() - b.getPackageEntity().getCommission())
                .sum();
    }
}