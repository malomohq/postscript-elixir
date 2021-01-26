defmodule Postscript do
  alias Postscript.{ Config, Operation, Request, Response }

  @type http_headers_t ::
          [{ String.t(), String.t() }]

  @type http_method_t ::
          :delete | :get | :head | :patch | :post | :put

  @type http_status_code_t ::
          pos_integer

  @type response_t ::
          { :ok, Response.t() } | { :error, Response.t() | any }

  @doc """
  Send a request to the Postscript API.
  """
  @spec request(Operation.t(), Keyword.t()) :: response_t
  def request(operation, config) do
    config = Config.new(config)

    request = Request.new(operation, config)

    Request.send(request, config)
  end
end
