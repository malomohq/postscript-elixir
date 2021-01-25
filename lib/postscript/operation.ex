defmodule Postscript.Operation do
  @type t ::
          %__MODULE__{
            method: Postscript.http_method_t(),
            params: Keyword.t(),
            path: String.t()
          }

  defstruct [method: nil, params: [], path: nil]
end
