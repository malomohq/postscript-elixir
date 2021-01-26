defmodule Postscript.KeywordTest do
  use ExUnit.Case, async: true

  alias Postscript.{ Operation }

  test "get/1" do
    expected = %Operation{}
    expected = Map.put(expected, :method, :get)
    expected = Map.put(expected, :path, "/keywords/id")

    assert expected == Postscript.Keyword.get("id")
  end

  test "list/0" do
    expected = %Operation{}
    expected = Map.put(expected, :method, :get)
    expected = Map.put(expected, :path, "/keywords")

    assert expected == Postscript.Keyword.list()
  end
end
