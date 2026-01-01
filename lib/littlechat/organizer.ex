defmodule Littlechat.Organizer do
  @moduledoc """
  The Organizer context.
  """

  import Ecto.Query, warn: false
  alias Littlechat.Repo
  alias Littlechat.Room

  def get_room(slug) when is_binary(slug) do
    from(room in Room, where: room.slug == ^slug)
    |> Repo.one()
  end


  def change_room(%Room{} = room, attrs \\ %{}) do
    Room.changeset(room, attrs)
  end
end
