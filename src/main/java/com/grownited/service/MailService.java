package com.grownited.service;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.grownited.dto.ContactUsDto;
import com.grownited.entity.UserEntity;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class MailService {

	@Autowired
	private JavaMailSender javaMailSender;

	public void sendDemoMail(UserEntity userEntity) {

			String subject = "Welcome to Urban Service";
			String body = "Welcome! " + userEntity.getName() + " 😊 We're glad to have you here. "
			        + "If you need any help, feel free to ask. Enjoy your experience! 🚀 \n "
			        + "<a href='http://192.168.1.13/'>Click Here</a> to visit the application.";

			String from = "tejasshah2k19@gmail.com";
			
			SimpleMailMessage mailMessage=new SimpleMailMessage();
			mailMessage.setSubject(subject);
			mailMessage.setText(body);
			mailMessage.setFrom(from);
			mailMessage.setTo(userEntity.getEmailId());
			
			javaMailSender.send(mailMessage);
		
	}
	
	public void sendOtpForForgotPassword(String email,int otp) {


        String subject = "🔒 Your Secure OTP for Local Finder";

        String body = "<html><body style='font-family: Arial, sans-serif; color: #333;'>"
                + "<h2 style='color: #2c3e50;'>Hello,</h2>"
                + "<p>Your One-Time Password (OTP) for secure verification is:</p>"
                + "<h1 style='background:#2c3e50; color:#fff; padding:10px 20px; display:inline-block; border-radius:5px;'>"
                + otp + "</h1>"
                + "<p>Please enter this OTP within the next <b>5 minutes</b>. Do not share it with anyone.</p>"
                + "<p>If you did not request this, ignore this email or contact support.</p>"
                + "<hr style='border:none; border-top:1px solid #ddd;'/>"
                + "<p style='font-size:12px; color:#666;'>For assistance, reach us at <a href='mailto:support@localfinder.com'>support@localfinder.com</a>.</p>"
                + "<p style='font-size:12px; color:#666;'>Best Regards,<br/><strong>Local Finder Team</strong></p>"
                + "</body></html>";

        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setFrom("tejasshah2k19@gmail.com");
            helper.setTo(email);
            helper.setSubject(subject);
            helper.setText(body, true); // Enables HTML format

            javaMailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
	
	
	public void sendEmail(String userMail,String providerMail,String subject ,String message) {

		
		String from = "tejasshah2k19@gmail.com";
		
		SimpleMailMessage mailMessage=new SimpleMailMessage();
		mailMessage.setSubject(subject);
		mailMessage.setText(message);
		mailMessage.setFrom(from);
		mailMessage.setTo(userMail);
		
		javaMailSender.send(mailMessage);
	
}
	
public void contactUsEmail(ContactUsDto contactUsDto) {

		
		String to = "tejasshah2k19@gmail.com";
		
		SimpleMailMessage mailMessage=new SimpleMailMessage();
		mailMessage.setSubject(contactUsDto.getSubject());
		mailMessage.setText("Hello " +contactUsDto.getName()+",\n"+ contactUsDto.getMessage());
		mailMessage.setFrom(contactUsDto.getEmail());
		mailMessage.setTo(to);
		
//		javaMailSender.send(mailMessage);
	
}
	

	
}
