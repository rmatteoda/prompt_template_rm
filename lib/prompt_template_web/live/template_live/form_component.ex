defmodule PromptTemplateWeb.TemplateLive.FormComponent do
  use PromptTemplateWeb, :live_component

  alias PromptTemplate.Prompt

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <div class="mb-6">
        <h2 class="text-xl font-semibold text-gray-900"><%= @title %></h2>
        <p class="mt-1 text-sm text-gray-500">Use this form to create or update your AI prompt template.</p>
      </div>

      <.simple_form
        for={@form}
        id="template-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
        class="space-y-6"
      >
        <div>
          <.input field={@form[:name]} type="text" label="Template Name" placeholder="Enter a descriptive name" required />
          <div class="mt-1 text-xs text-gray-500">Choose a clear name that describes the purpose of this prompt template.</div>
        </div>
        
        <div>
          <.input field={@form[:body]} type="textarea" label="Template Body" placeholder="Enter your template content with [[today]] and [[model]] placeholders" rows="8" required />
          <div class="mt-1 text-xs text-gray-500">
            Available placeholders:
            <span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium bg-indigo-100 text-indigo-800 mr-1">[[today]]</span>
            <span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium bg-indigo-100 text-indigo-800">[[model]]</span>
          </div>
        </div>
        
        <:actions>
          <.button phx-disable-with="Saving..." class="bg-indigo-600 hover:bg-indigo-700 w-full sm:w-auto">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3 3m0 0l-3-3m3 3V4" />
            </svg>
            Save Template
          </.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{template: template} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Prompt.change_template(template))
     end)}
  end

  @impl true
  def handle_event("validate", %{"template" => template_params}, socket) do
    changeset = Prompt.change_template(socket.assigns.template, template_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"template" => template_params}, socket) do
    save_template(socket, socket.assigns.action, template_params)
  end

  defp save_template(socket, :edit, template_params) do
    case Prompt.update_template(socket.assigns.template, template_params) do
      {:ok, template} ->
        notify_parent({:saved, template})

        {:noreply,
         socket
         |> put_flash(:info, "Template updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_template(socket, :new, template_params) do
    case Prompt.create_template(template_params) do
      {:ok, template} ->
        notify_parent({:saved, template})

        {:noreply,
         socket
         |> put_flash(:info, "Template created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
