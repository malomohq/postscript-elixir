defmodule Postscript.Http do
  alias Postscript.{ Request }

  @type response_t ::
          %{
            body: String.t(),
            headers: Postscript.http_headers_t(),
            status_code: Postscript.http_status_code_t()
          }

  @callback send(
              request :: Request.t(),
              opts :: any
            ) :: { :ok, response_t } | { :error, response_t | any }
end
