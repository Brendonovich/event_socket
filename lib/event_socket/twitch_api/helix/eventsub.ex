defmodule EventSocket.TwitchAPI.Helix.EventSub do
  alias EventSocket.{TwitchAPI.Helix, Secrets}

  @spec create_subscription(String.t(), map()) :: any
  def create_subscription(type, condition) do
    Helix.post("eventsub/subscriptions", %{
      "type" => type,
      "condition" => condition,
      "version" => 1,
      "transport" => %{
        "method" => "webhook",
        "callback" => Secrets.webhook_callback(),
        "secret" => "1234567890"
      }
    })
  end

  def delete_subscription(id) do
    Helix.delete("eventsub/subscriptions", %{"id" => id})
  end

  def get_subscriptions(cursor \\ nil) do
    Helix.get("eventsub/subscriptions#{if cursor != nil do
      "?after=#{cursor}"
    else
      ""
    end}")
  end
end