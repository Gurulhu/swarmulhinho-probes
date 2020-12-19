defmodule Jira.Config do

  def query, do: config_or_env(:query)
  def jira_base_url, do: config_or_env(:jira_base_url)
  def jira_user, do: config_or_env(:jira_user)
  def jira_password, do: config_or_env(:jira_password)
  def amqp_server_string, do: config_or_env(:amqp_server_string)
  def telegram_chat, do: config_or_env(:telegram_chat)


  #Got the idea from https://github.com/zhyu/nadia/blob/master/lib/nadia/config.ex
  defp config_or_env(key) do
    case Application.fetch_env(:jira, key) do
      {:ok, {:system, var}} ->
        System.get_env(var)

      {:ok, {:system, var, default}} ->
        case System.get_env(var) do
          nil -> default
          val -> val
        end

      {:ok, value} ->
        value

      :error ->
        nil
    end
  end

end
