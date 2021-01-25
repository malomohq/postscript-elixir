defmodule Postscript.Request do
  @type t ::
          %__MODULE__{
            body: String.t(),
            headers: Postscript.http_headers_t(),
            method: Postscript.http_method_t(),
            private: map,
            url: String.t()
          }

  defstruct [
    body: nil,
    headers: [],
    method: nil,
    private: %{},
    url: nil
  ]
end
