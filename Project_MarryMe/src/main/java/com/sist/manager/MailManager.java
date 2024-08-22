package com.sist.manager;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.sist.vo.MemberVO;

public class MailManager {
	public void mailSender(String name, String pw_email, String result) {
		String host="smtp.naver.com";
		final String user="1992lyb@naver.com";
		final String password="projectmarryme";
		
		Properties props=new Properties();
		props.put("mail.smtp.host", host); //메일서버
		props.put("mail.smtp.port", 587); //포트
		props.put("mail.smtp.auth", true); //인증
		
		//naver 인증
		Session session=Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				// TODO Auto-generated method stub
				return new PasswordAuthentication(user, password);
			}
		});
		try {
			MimeMessage message=new MimeMessage(session);
			message.setFrom(new InternetAddress(user)); //보내는사람
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(pw_email)); //받는사람	
			message.setSubject("[PROJECT MARRY ME] 비밀번호 전송");
			
			 String html=
        		     "<div style=\"width:100%;text-align:center;\">"
        		     +"<p style=\"font-size:20px;font-weight:bold;padding:20px;background:#303A1F;color:#dcdcdc;\">[ PROJECT MARRY ME ]</p>"
        		     +"<div style=\"background:#EFF3EA;padding:30px;\">"
        		     +"<p style=\"margin-bottom:20px;font-weight:bold;\">🔐 "+name+"님의 비밀번호 🔐</p>"
        		     +"<p>"+result+"</p>"
        		     +"</div>"
        		     +"</div>";
			//message.setContent(result,"text/html;charset=UTF-8");
			message.setContent(html, "text/html;charset=UTF-8");
			
			Transport.send(message);
			//System.out.println("정상수행");
		}catch(Exception ex) {
			//System.out.println("비정상수행");
			ex.printStackTrace();
		}
	}
}
