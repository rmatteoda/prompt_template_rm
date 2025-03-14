defmodule PromptTemplate.Repo do
  use Ecto.Repo,
    otp_app: :prompt_template,
    adapter: Ecto.Adapters.Postgres
end
