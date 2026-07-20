defmodule Postscript.Event do
  @moduledoc """
  Operations for the Postscript Custom Events API (`POST /api/v2/events`).

  Event operations set `http_path` to `"/api/v2"` so they hit the Custom
  Events API even though the client default is `"/v1"`. Callers do not need
  to pass `http_path` to `Postscript.request/2`:

      operation =
        Postscript.Event.create(
          type: "malomo_shipment_created",
          email: "jason@gomalomo.com",
          properties: %{"order_id" => "..."},
          external_id: "seed:account-id:malomo_shipment_created"
        )

      Postscript.request(operation,
        api_key: partner_key,
        shop_token: shop_key
      )

  A successful create returns `202 Accepted` with an `event_ids` body, which
  `Postscript.request/2` treats as `{:ok, response}`.
  """

  alias Postscript.{Operation}

  @doc """
  Create a custom event.

  Accepted options include:

  * `:type` (required) — 1–255 chars; letters, numbers, `_`, `:` only;
    case-sensitive
  * `:phone`, `:email`, or `:subscriber_id` — one subscriber identifier in the
    body (unknown subscribers still return `202`; event is recorded, no
    automation runs)
  * `:properties` — renamed from v1 `data`; flat only (strings, numbers,
    booleans, arrays; no nested objects); max 100 keys; keys lowercased by
    Postscript; no keys starting with `_`; PII-like keys rejected
  * `:occurred_at` — optional `YYYY-MM-DD HH:MM:SS.ffffff`
  * `:external_id` — optional idempotency key (recommended on retries)

  Unrecognized top-level fields are rejected by Postscript with `400`. Put
  extra metadata under `:properties`.

  The returned operation targets `/api/v2/events` automatically.
  """
  @spec create(Keyword.t()) :: Operation.t()
  def create(opts) do
    %Operation{}
    |> Map.put(:http_path, "/api/v2")
    |> Map.put(:method, :post)
    |> Map.put(:params, opts)
    |> Map.put(:path, "/events")
  end
end
