class UserMailer < ActionMailer::Base
  def contact_us(contact_us)
    mail :to => "pfm.sup.psodhfoih2904@gmail.com",
         :from => "#{contact_us.full_name} #{contact_us.email}",
         :content_type => 'text/html',
         :subject => "PFM support request",
         :body => "Name: #{contact_us.full_name}<br/>" +
                  "Email: #{contact_us.email}<br/><br/>" +
                  contact_us.text
  end
end
