class ChargesController < ApplicationController
  
  def new

    params = {
       :stripeToken =>"tok_103G0s2NYY6aF7NIACwaJofC",
       :stripeEmail =>"megan@test.com",
       :stripeShippingName =>"Megan Jones",
       :stripeShippingAddressLine1 =>"1020 Mulberry Dr.",
       :stripeShippingAddressZip =>"20202",
       :stripeShippingAddressCity =>"Washington",
       :stripeShippingAddressState =>"DC",
       :stripeShippingAddressCountry =>"United States"}

    @product = Product.find(1)

    # html = render_to_string("products/email", {product: @product})
    html = render_to_string(:partial => 'products/email', :layout => false, :formats=>[:html], :locals => {product: @product, params: params})

    Rails.logger.debug("[debug] : #{html}" );

    @product.send_purchase_email(html, params)
  end


  def create
    # raise params.to_yaml

    @product = Product.find(params[:product][:id])

    # Amount in cents
    # @amount = @product.amount
    # @product_name = params[:product][:name]
    # @product_description = params[:product][:description]

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @product.price_in_cents,
      :description => @product.name,
      :currency    => 'usd'
    )

    # Render HTML String for Mailgun email
    html = render_to_string(:partial => 'products/email', :layout => false, :formats=>[:html], :locals => {product: @product, params: params})
    
    # Send email to the andrews via
    @product.send_purchase_email(html, params)

    order_params = convert_stripe_to_order_params(@product.id, html, params)
    @order = Order.create!(order_params)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end


  def convert_stripe_to_order_params(product_id, html, params)
    order_params = {
      :product_id => product_id,
      :email  => params[:stripeEmail],
      :name   => params[:stripeShippingName],
      :street => params[:stripeShippingAddressLine1],
      :zip    => params[:stripeShippingAddressZip],
      :city   => params[:stripeShippingAddressCity],
      :state  => params[:stripeShippingAddressState],
      :country => params[:stripeShippingAddressCountry],
      :html_string => html
    }
  end
end
