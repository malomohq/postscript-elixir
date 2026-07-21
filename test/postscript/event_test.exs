defmodule Postscript.EventTest do
  use ExUnit.Case, async: true

  alias Postscript.{Event, Http, Operation, Response}

  test "create/1" do
    opts = [
      type: "malomo_shipment_created",
      email: "jason@gomalomo.com",
      properties: %{"order_id" => "123"},
      external_id: "seed:account-id:malomo_shipment_created"
    ]

    expected = %Operation{}
    expected = Map.put(expected, :http_path, "/api/v2")
    expected = Map.put(expected, :method, :post)
    expected = Map.put(expected, :params, opts)
    expected = Map.put(expected, :path, "/events")

    assert expected == Event.create(opts)
  end

  test "create/1 targets /api/v2/events without a request http_path override" do
    Http.Mock.start_link()

    Http.Mock.put_response(
      {:ok, %{body: "{\"event_ids\":[\"evt_123\"]}", headers: [], status_code: 202}}
    )

    opts = [
      type: "malomo_shipment_created",
      email: "jason@gomalomo.com",
      properties: %{"order_id" => "123"}
    ]

    result =
      opts
      |> Event.create()
      |> Postscript.request(http_client: Http.Mock)

    assert "https://api.postscript.io/api/v2/events" == Http.Mock.get_request_url()

    assert Jason.decode!(Http.Mock.get_request_body()) == %{
             "type" => "malomo_shipment_created",
             "email" => "jason@gomalomo.com",
             "properties" => %{"order_id" => "123"}
           }

    assert {:ok, %Response{body: %{"event_ids" => ["evt_123"]}, status_code: 202}} = result
  end
end
