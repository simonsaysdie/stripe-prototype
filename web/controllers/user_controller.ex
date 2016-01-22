defmodule Tolkien.UserController do
	use Tolkien.Web, :controller

	@token_to_id "https://connect.stripe.com/oauth/token"

	def stripe(conn, params) do
   		%{"code"=> code} = params

   		headers = [{"Content-Type", "application/x-www-form-urlencoded"}]
   		body = params_to_string(%{"client_secret" => "sk_test_BxsY2JiapXjqgvqxFy9EvVUE", "code" => code, "grant_type" => "authorization_code"})

   		token_to_id = HTTPoison.post(@token_to_id, body, headers)
   		case token_to_id do
   			{:ok, %{body: res_body}} ->
   				data = Jazz.decode!(res_body)
   				%{"stripe_user_id" => stripe_user_id} = data
   				text conn, stripe_user_id
   			{:error, response} ->
   				text conn, inspect(response)
   		end
		
	end

	defp params_to_string(params) do
        params |> Enum.filter(fn {_k, v} -> v != nil end)
               |> URI.encode_query
    end
end