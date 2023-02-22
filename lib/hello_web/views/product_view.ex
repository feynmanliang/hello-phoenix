defmodule HelloWeb.ProductView do
  use HelloWeb, :view

  def category_select(form, changeset) do
    existing_ids = changeset |> Ecto.Changeset.get_field(:category_ids, []) |> Enum.map(& &1.id)

    options =
      for category <- Hello.Catalog.list_categories(),
          do: [key: category.title, value: category.id, selected: category.id in existing_ids]

    multiple_select(form, :category_ids, options)
  end
end
