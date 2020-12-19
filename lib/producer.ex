defmodule Jira.Producer do
  use GenServer
  use Timex

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @queue        "Telegram"

  def init(:ok) do
    update()
    {:ok, 0, 6000}
  end

  def handle_cast(:update, status) do
    today = Timex.to_datetime( Timex.today )
    work_hours = Timex.Interval.new(from: Timex.shift(today, hours: 9), until: [hours: 10])
    if (Timex.now() in work_hours) and (Timex.weekday(today) < 6) do
      {:ok, response} = Jira.Fetcher.issues()

      if response.status == 200 do
        {:ok, connection} = AMQP.Connection.open(Jira.Config.amqp_server_string)
        {:ok, channel} = AMQP.Channel.open(connection)

          AMQP.Basic.publish(channel, "", @queue, Jason.encode!(%{text: "Você tem #{response.body["total"]} tickets em backlog!", chat_id: Jira.Config.telegram_chat()}))
      end

      count = response.body["total"]
      {:noreply, count, 1000 * 60 * 60}
    else
      {:noreply, status, 1000 * 60 * 60}
    end
  end

  def handle_info(:timeout, status) do
    update()
    {:noreply, status}
  end

  def update do
    GenServer.cast(__MODULE__, :update)
  end

end
