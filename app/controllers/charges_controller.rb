class ChargesController < ApplicationController
  
  def new
    @product = Product.find(1)

    # html = render_to_string("products/email", {product: @product})
    html = render_to_string(:partial => 'products/email', :layout => false, :formats=>[:html], :locals => {product: @product})


    @product.send_purchase_email({stripeShippingAddressLine1: "1000 Main St.", html: html})
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

    @product.send_purchase_email(params)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end


   # "stripeShippingName"=>"Jeff Manislaw",
   # "stripeShippingAddressLine1"=>"1000 Main St.",
   # "stripeShippingAddressZip"=>"28010",
   # "stripeShippingAddressCity"=>"Charlotte",
   # "stripeShippingAddressState"=>"NC",
   # "stripeShippingAddressCountry"=>"United States"
end
