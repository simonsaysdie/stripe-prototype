defmodule Tolkien.Router do
  use Tolkien.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Tolkien do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    # A user get redirected to this path after a Stripe auth flow
    get "/stripe", UserController, :stripe

    get "/donations", DonationController, :donation
    post "/donations", DonationController, :donate

  end

  # Other scopes may use custom stacks.
  # scope "/api", Tolkien do
  #   pipe_through :api
  # end
end
