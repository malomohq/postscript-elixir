defmodule Postscript.SubscriberTest do
  use ExUnit.Case, async: true

  alias Postscript.{ Operation, Subscriber }

  test "create/1" do
    expected = %Operation{}
    expected = Map.put(expected, :method, :post)
    expected = Map.put(expected, :params, [p1: "v"])
    expected = Map.put(expected, :path, "/subscribers")

    assert expected == Subscriber.create(p1: "v")
  end

  test "find/1" do
    expected = %Operation{}
    expected = Map.put(expected, :method, :get)
    expected = Map.put(expected, :params, [p1: "v"])
    expected = Map.put(expected, :path, "/subscribers")

    assert expected == Subscriber.find(p1: "v")
  end

  test "get/1" do
    expected = %Operation{}
    expected = Map.put(expected, :method, :get)
    expected = Map.put(expected, :path, "/subscribers/id")

    assert expected == Subscriber.get("id")
  end

  test "update/2" do
    expected = %Operation{}
    expected = Map.put(expected, :method, :put)
    expected = Map.put(expected, :params, [p1: "v"])
    expected = Map.put(expected, :path, "/subscribers/id")

    assert expected == Subscriber.update("id", p1: "v")
  end
end
