defmodule Tolkien.DonationController do
	use Tolkien.Web, :controller

	alias Commerce.Billing.Gateways.Stripe
	alias Commerce.Billing
	alias Commerce.Billing.Response

	def donation(conn, _params) do
		render conn, "donation.html"
	end

	def donate(conn, params) do
		%{"stripeToken" => token} = params
		# example org stripe id   myorg@mailinator.com/testpass00
		org_stripe_id = "acct_16mDLzBh7FULNkbj"
		bill_resp = Billing.authorize(:stripe, 2000, token, 
			capture: true,
			application_fee: 200,
			destination: org_stripe_id,
			description: "Help childs without heroes")
		case bill_resp do
			{:ok, %Response{authorization: authorization}} ->
				IO.puts("Payment authorized #{authorization}")

			{:error, %Response{code: :declined, reason: reason}} ->
				IO.puts("Payment declined #{reason}")

			{:error, %Response{code: error}} ->
				IO.puts("Payment error #{error}")
		end
		text conn, inspect(bill_resp) 
	end

end