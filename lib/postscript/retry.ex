defmodule Postscript.Retry do
  alias Postscript.{ Config, Request }

  @callback wait_for(
              request :: Request.t(),
              config :: Config.t()
            ) :: non_neg_integer
end
