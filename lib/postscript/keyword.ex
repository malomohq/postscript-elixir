defmodule Postscript.Keyword do
  alias Postscript.{ Operation }

  @doc """
  Retrieve a keyword.
  """
  @spec get(String.t()) :: Operation.t()
  def get(id) do
    %Operation{}
    |> Map.put(:method, :get)
    |> Map.put(:path, "/keywords/#{id}")
  end

  @doc """
  Retrieve a list of keywords.
  """
  @spec list :: Operation.t()
  def list do
    %Operation{}
    |> Map.put(:method, :get)
    |> Map.put(:path, "/keywords")
  end
end
