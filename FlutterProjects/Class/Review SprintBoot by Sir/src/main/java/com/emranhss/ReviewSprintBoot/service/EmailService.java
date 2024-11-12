package com.emranhss.ReviewSprintBoot.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class EmailService {


    private  final JavaMailSender javaMailSender;

    public void sendSimpleEmail(String to, String subject, String text) throws MessagingException {
        MimeMessage mes= javaMailSender.createMimeMessage();
        MimeMessageHelper message =new MimeMessageHelper(mes, true);
        message.setTo(to);
        message.setSubject(subject);
        message.setText(text);


        javaMailSender.send(mes);
    }




}
