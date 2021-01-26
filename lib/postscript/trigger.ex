defmodule Postscript.Trigger do
  alias Postscript.{ Operation }

  @doc """
  Allow a shop to use a trigger.
  """
  @spec add_shop(String.t()) :: Operation.t()
  def add_shop(id) do
    %Operation{}
    |> Map.put(:method, :post)
    |> Map.put(:path, "/triggers/#{id}/shops")
  end

  @doc """
  Create a trigger.
  """
  @spec create(Keyword.t()) :: Operation.t()
  def create(opts) do
    %Operation{}
    |> Map.put(:method, :post)
    |> Map.put(:params, opts)
    |> Map.put(:path, "/triggers")
  end

  @doc """
  Delete a trigger.
  """
  @spec delete(String.t()) :: Operation.t()
  def delete(id) do
    %Operation{}
    |> Map.put(:method, :delete)
    |> Map.put(:path, "/triggers/#{id}")
  end

  @doc """
  Fire a trigger for a subscriber.
  """
  @spec fire(String.t(), String.t(), Keyword.t()) :: Operation.t()
  def fire(trigger_id, subscriber_id, opts) do
    %Operation{}
    |> Map.put(:method, :post)
    |> Map.put(:params, opts)
    |> Map.put(:path, "/triggers/#{trigger_id}/subscribers/#{subscriber_id}")
  end

  @doc """
  Retrieve a trigger.
  """
  @spec get(String.t()) :: Operation.t()
  def get(id) do
    %Operation{}
    |> Map.put(:method, :get)
    |> Map.put(:path, "/triggers/#{id}")
  end

  @doc """
  Retrieve a list of triggers.
  """
  @spec list :: Operation.t()
  def list do
    %Operation{}
    |> Map.put(:method, :get)
    |> Map.put(:path, "/triggers")
  end

  @doc """
  Update a trigger by replacement.
  """
  @spec replace(String.t(), Keyword.t()) :: Operation.t()
  def replace(id, opts) do
    %Operation{}
    |> Map.put(:method, :put)
    |> Map.put(:params, opts)
    |> Map.put(:path, "/triggers/#{id}")
  end

  @doc """
  Update a trigger.
  """
  @spec update(String.t(), Keyword.t()) :: Operation.t()
  def update(id, opts) do
    %Operation{}
    |> Map.put(:method, :patch)
    |> Map.put(:params, opts)
    |> Map.put(:path, "/triggers/#{id}")
  end
end
