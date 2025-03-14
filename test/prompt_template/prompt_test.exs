defmodule PromptTemplate.PromptTest do
  use PromptTemplate.DataCase

  alias PromptTemplate.Prompt

  describe "templates" do
    alias PromptTemplate.Prompt.Template

    import PromptTemplate.PromptFixtures

    @invalid_attrs %{name: nil, body: nil}

    test "list_templates/0 returns all templates" do
      template = template_fixture()
      assert Prompt.list_templates() == [template]
    end

    test "get_template!/1 returns the template with given id" do
      template = template_fixture()
      assert Prompt.get_template!(template.id) == template
    end

    test "create_template/1 with valid data creates a template" do
      valid_attrs = %{name: "some name", body: "some body"}

      assert {:ok, %Template{} = template} = Prompt.create_template(valid_attrs)
      assert template.name == "some name"
      assert template.body == "some body"
    end

    test "create_template/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Prompt.create_template(@invalid_attrs)
    end

    test "update_template/2 with valid data updates the template" do
      template = template_fixture()
      update_attrs = %{name: "some updated name", body: "some updated body"}

      assert {:ok, %Template{} = template} = Prompt.update_template(template, update_attrs)
      assert template.name == "some updated name"
      assert template.body == "some updated body"
    end

    test "update_template/2 with invalid data returns error changeset" do
      template = template_fixture()
      assert {:error, %Ecto.Changeset{}} = Prompt.update_template(template, @invalid_attrs)
      assert template == Prompt.get_template!(template.id)
    end

    test "delete_template/1 deletes the template" do
      template = template_fixture()
      assert {:ok, %Template{}} = Prompt.delete_template(template)
      assert_raise Ecto.NoResultsError, fn -> Prompt.get_template!(template.id) end
    end

    test "change_template/1 returns a template changeset" do
      template = template_fixture()
      assert %Ecto.Changeset{} = Prompt.change_template(template)
    end
  end
end
