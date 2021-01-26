defmodule Postscript.Subscriber do
  alias Postscript.{ Operation }

  @doc """
  Create a subscriber.
  """
  @spec create(Keyword.t()) :: Operation.t()
  def create(opts) do
    %Operation{}
    |> Map.put(:method, :post)
    |> Map.put(:params, opts)
    |> Map.put(:path, "/subscribers")
  end

  @doc """
  Find a subscriber.
  """
  @spec find(Keyword.t()) :: Operation.t()
  def find(opts) do
    %Operation{}
    |> Map.put(:method, :get)
    |> Map.put(:params, opts)
    |> Map.put(:path, "/subscribers")
  end

  @doc """
  Retrieve a subscriber.
  """
  @spec get(String.t()) :: Operation.t()
  def get(id) do
    %Operation{}
    |> Map.put(:method, :get)
    |> Map.put(:path, "/subscribers/#{id}")
  end

  @doc """
  Update a subscriber.
  """
  @spec update(String.t(), Keyword.t()) :: Operation.t()
  def update(id, opts) do
    %Operation{}
    |> Map.put(:method, :put)
    |> Map.put(:params, opts)
    |> Map.put(:path, "/subscribers/#{id}")
  end
end
