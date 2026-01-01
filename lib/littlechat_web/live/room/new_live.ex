defmodule LittlechatWeb.Room.NewLive do
  use LittlechatWeb, :live_view

  alias Littlechat.Repo
  alias Littlechat.Room

  @impl true
  def render(assigns) do
    ~L"""
    <h1>Create a New Room</h1>
    <div>
    <.form let={f} for={@changeset} action={~p"/rooms"}>
    <.input field={f[:name]} label="Room Name" />
    <.input field={f[:description]} label="Description" />
    <span>
    </span>
    </.form>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> put_changeset()}
  end

  @impl true
  def handle_event("validate", %{"room" => room_params}, socket) do
    {:noreply,
     socket
     |> put_changeset(room_params)}
  end

  def handle_event("save", _, %{assigns: %{changeset: changeset}} = socket) do
    case Repo.insert(changeset) do
      {:ok, room} ->
        {:noreply,
         socket
         |> push_redirect(to: Routes.room_show_path(socket, :show, room.slug))}

      {:error, changeset} ->
        {:noreply,
         socket
         |> assign(:changeset, changeset)
         |> put_flash(:error, "Could not save the room.")}
    end
  end

  defp put_changeset(socket, params \\ %{}) do
    socket
    |> assign(:changeset, Room.changeset(%Room{}, params))
  end
end
