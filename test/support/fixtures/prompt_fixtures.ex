defmodule PromptTemplate.PromptFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PromptTemplate.Prompt` context.
  """

  @doc """
  Generate a template.
  """
  def template_fixture(attrs \\ %{}) do
    {:ok, template} =
      attrs
      |> Enum.into(%{
        body: "some body",
        name: "some name"
      })
      |> PromptTemplate.Prompt.create_template()

    template
  end
end
