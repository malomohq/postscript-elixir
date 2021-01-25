defmodule Postscript.Response do
  alias Postscript.{ Config, Http }

  @type t ::
          %__MODULE__{
            body: any,
            headers: Postscript.http_headers_t(),
            status_code: Postscript.http_status_code_t()
          }

  defstruct [:body, :headers, :status_code]

  @spec new(Http.response_t(), Config.t()) :: t
  def new(response, config) do
    body =
      response
      |> Map.get(:body)
      |> config.json_codec.decode!()

    %__MODULE__{}
    |> Map.put(:body, body)
    |> Map.put(:headers, Map.get(response, :headers))
    |> Map.put(:status_code, Map.get(response, :status_code))
  end
end
