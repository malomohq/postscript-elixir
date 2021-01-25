defmodule Postscript.Config do
  @type t ::
          %__MODULE__{
            api_key: String.t(),
            http_client: module,
            http_client_opts: any,
            http_headers: Postscript.http_headers_t(),
            http_host: String.t(),
            http_port: pos_integer,
            http_protocol: String.t(),
            json_codec: module,
            retry: boolean | module,
            retry_opts: Keyword.t(),
            shop_token: String.t()
          }

  defstruct [
    api_key: nil,
    http_client: Postscript.Http.Hackney,
    http_client_opts: [],
    http_headers: [],
    http_host: "api.postscript.io",
    http_port: nil,
    http_protocol: "https",
    json_codec: Jason,
    retry: false,
    retry_opts: [],
    shop_token: nil
  ]

  @spec new(Keyword.t()) :: t
  def new(overrides) do
    Map.merge(%__MODULE__{}, Enum.into(overrides, %{}))
  end
end
