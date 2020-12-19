defmodule Jira.Fetcher do
  use Tesla

  plug Tesla.Middleware.BaseUrl, Jira.Config.jira_base_url()
  plug Tesla.Middleware.Headers, [{"Content-Type","application/json"}]
  plug Tesla.Middleware.BasicAuth, username: Jira.Config.jira_user(), password: Jira.Config.jira_password()
  plug Tesla.Middleware.JSON

  def issues() do
    query = Jira.Config.query()
    get("search?jql=" <> query)
  end
end
