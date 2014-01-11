class ContactController < ApplicationController

  def contact_us_page
    headers['Access-Control-Allow-Origin'] = '*'
  
    # ContactFormMailer.delay.domains(name, email, message, subject, offer, domain)
    ContactUs.email_hello(params[:contact]) #.deliver_without_worker
  
    render :json => { :success => "Thanks for contacting us." }
  end

  def author_form

  end

end
