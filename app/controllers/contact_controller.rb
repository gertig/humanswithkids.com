class ContactController < ApplicationController

  def contact_us_page
    headers['Access-Control-Allow-Origin'] = '*'
  
    # ContactFormMailer.delay.domains(name, email, message, subject, offer, domain)
    ContactUs.email_hello(params[:contact]) #.deliver_without_worker
  
    # render :json => { :success => "Thanks for contacting us." }
    flash[:success] = "Thanks for sending us a message!"
    redirect_to request.referer
  end

  def author_form

  end

end
