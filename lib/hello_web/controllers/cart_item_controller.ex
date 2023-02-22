defmodule HelloWeb.CartItemController do
  use HelloWeb, :controller

  alias Hello.{ShoppingCart, Catalog}

  def create(conn, %{"product_id" => product_id}) do
    product = Catalog.get_product!(product_id)

    case ShoppingCart.add_item_to_cart(conn.assigns.cart, product) do
      {:ok, cart_item} ->
        conn
        |> put_flash(:info, "Added #{product.title} to cart")
        |> redirect(to: Routes.cart_path(conn, :show))

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Could not add item to cart")
        |> redirect(to: Routes.cart_path(conn, :show))
    end
  end

  def delete(conn, %{"id" => id}) do
    {:ok, _cart_item} = ShoppingCart.remove_item_from_cart(conn.assigns.cart, id)

    conn
    |> put_flash(:info, "Removed item from cart")
    |> redirect(to: Routes.cart_path(conn, :show))
  end
end
