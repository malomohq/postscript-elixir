defmodule Postscript.TriggerTest do
  use ExUnit.Case, async: true

  alias Postscript.{ Operation, Trigger }

  test "add_shop/1" do
    expected = %Operation{}
    expected = Map.put(expected, :method, :post)
    expected = Map.put(expected, :path, "/triggers/id/shops")

    assert expected == Trigger.add_shop("id")
  end

  test "create/1" do
    expected = %Operation{}
    expected = Map.put(expected, :method, :post)
    expected = Map.put(expected, :params, [p1: "v"])
    expected = Map.put(expected, :path, "/triggers")

    assert expected == Trigger.create(p1: "v")
  end

  test "delete/1" do
    expected = %Operation{}
    expected = Map.put(expected, :method, :delete)
    expected = Map.put(expected, :path, "/triggers/id")

    assert expected == Trigger.delete("id")
  end

  test "fire/3" do
    expected = %Operation{}
    expected = Map.put(expected, :method, :post)
    expected = Map.put(expected, :params, [p1: "v"])
    expected = Map.put(expected, :path, "/triggers/trigger_id/subscribers/subscriber_id")

    assert expected == Trigger.fire("trigger_id", "subscriber_id", p1: "v")
  end

  test "get/1" do
    expected = %Operation{}
    expected = Map.put(expected, :method, :get)
    expected = Map.put(expected, :path, "/triggers/id")

    assert expected == Trigger.get("id")
  end

  test "list/0" do
    expected = %Operation{}
    expected = Map.put(expected, :method, :get)
    expected = Map.put(expected, :path, "/triggers")

    assert expected == Trigger.list()
  end

  test "replace/2" do
    expected = %Operation{}
    expected = Map.put(expected, :method, :put)
    expected = Map.put(expected, :params, [p1: "v"])
    expected = Map.put(expected, :path, "/triggers/id")

    assert expected == Trigger.replace("id", p1: "v")
  end

  test "update/2" do
    expected = %Operation{}
    expected = Map.put(expected, :method, :patch)
    expected = Map.put(expected, :params, [p1: "v"])
    expected = Map.put(expected, :path, "/triggers/id")

    assert expected == Trigger.update("id", p1: "v")
  end
end
