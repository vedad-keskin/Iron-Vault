using System;
using System.Net;
using System.Net.Mail;


namespace MailingService
{
	public class EmailSender : IEmailSender
	{

        private readonly string _gmailMail = "ironvault.sender@gmail.com";
        private readonly string _gmailPass = "ormd ggqo jipg kzpn";

        

        public EmailSender()
		{
		}

        public Task SendEmailAsync(string email, string subject, string message)
        {
            var client = new SmtpClient("smtp.gmail.com", 587)
            {
                EnableSsl = true,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(_gmailMail, _gmailPass)
            };

            return client.SendMailAsync(
                new MailMessage(from: _gmailMail,
                                to: email,
                                subject,
                                message
                                ));

        }
    }
}

