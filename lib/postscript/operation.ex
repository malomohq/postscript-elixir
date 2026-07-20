defmodule Postscript.Operation do
  @type t ::
          %__MODULE__{
            http_path: String.t() | nil,
            method: Postscript.http_method_t(),
            params: Keyword.t(),
            path: String.t()
          }

  defstruct http_path: nil, method: nil, params: [], path: nil
end
