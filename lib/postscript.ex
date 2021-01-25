defmodule Postscript do
  @type http_headers_t ::
          [{ String.t(), String.t() }]

  @type http_method_t ::
          :delete | :get | :head | :patch | :post | :put

  @type http_status_code_t ::
          pos_integer
end
