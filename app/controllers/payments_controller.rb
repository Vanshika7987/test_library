class PaymentsController < ApplicationController
  skip_after_action :verify_authorized
  def new
  end

  def create
    # debugger
    # binding.pry
    customer = Stripe::Customer.create({
      :email => params[:stripeEmail],
      :source => params[:stripeToken],
      # :default_payment_method => params[:stripeTokenType]
    })
    # debugger
    # binding.pry
    charge = Stripe::PaymentIntent.create({
      :customer => customer.id,
      :amount => 500,
      :description => 'Description of your project',
      :currency => 'usd',
      # :payment_method => ["card"]
    })

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_payment_path
  end
end
