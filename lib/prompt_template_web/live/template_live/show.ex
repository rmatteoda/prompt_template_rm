defmodule PromptTemplateWeb.TemplateLive.Show do
  use PromptTemplateWeb, :live_view

  alias PromptTemplate.Prompt

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:model, "") |> assign(:processed_template, nil)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:template, Prompt.get_template!(id))}
  end

  @impl true
  def handle_event("run_template", %{"model" => model}, socket) do
    processed_template = process_template(socket.assigns.template.body, model)
    
    {:noreply, 
     socket
     |> assign(:model, model)
     |> assign(:processed_template, processed_template)}
  end

  defp process_template(template_text, model) do
    today = Date.utc_today() |> Date.to_string()
    
    template_text
    |> String.replace("[[today]]", today)
    |> String.replace("[[model]]", model)
  end

  defp page_title(:show), do: "Show Template"
  defp page_title(:edit), do: "Edit Template"
  defp page_title(:run), do: "Run Template"
end
