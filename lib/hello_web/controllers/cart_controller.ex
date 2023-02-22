defmodule HelloWeb.CartController do
  use HelloWeb, :controller

  alias Hello.ShoppingCart

  def show(conn, _params) do
    render(conn, "show.html", changeset: ShoppingCart.change_cart(conn.assigns.cart))
  end

  def update(conn, %{"cart" => cart_params}) do
    IO.puts("cart_params: #{inspect(cart_params)}")

    case ShoppingCart.update_cart(conn.assigns.cart, cart_params) do
      {:ok, _cart} ->
        conn
        |> put_flash(:info, "Cart updated")
        |> redirect(to: Routes.cart_path(conn, :show))

      {:error, changeset} ->
        render(conn, "show.html", changeset: changeset)
    end
  end
end
