class ChargesController < ApplicationController
  
  def new
    @amount = 500
  end


  def create
    raise params.to_yaml

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
      :amount      => @product.amount,
      :description => @product.description,
      :currency    => 'usd'
    )

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
