defmodule PostscriptTest do
  use ExUnit.Case, async: true

  alias Postscript.{Http, Operation, Response}

  @ok_resp %{body: "{\"ok\":true}", headers: [], status_code: 200}

  @not_ok_resp %{body: "{\"ok\":false}", headers: [], status_code: 400}

  test "sends the proper HTTP method" do
    Http.Mock.start_link()

    response = {:ok, @ok_resp}

    Http.Mock.put_response(response)

    operation = %Operation{method: :get, params: [hello: "world"], path: "/fake"}

    Postscript.request(operation, http_client: Http.Mock)

    assert :get == Http.Mock.get_request_method()
  end

  test "uses the proper URL for GET requests" do
    Http.Mock.start_link()

    response = {:ok, @ok_resp}

    Http.Mock.put_response(response)

    operation = %Operation{method: :get, params: [hello: "world"], path: "/fake"}

    Postscript.request(operation, http_client: Http.Mock)

    assert "https://api.postscript.io/v1/fake?hello=world" == Http.Mock.get_request_url()
  end

  test "uses the proper URL for DELETE requests" do
    Http.Mock.start_link()

    response = {:ok, @ok_resp}

    Http.Mock.put_response(response)

    operation = %Operation{method: :delete, params: [hello: "world"], path: "/fake"}

    Postscript.request(operation, http_client: Http.Mock)

    assert "https://api.postscript.io/v1/fake?hello=world" == Http.Mock.get_request_url()
  end

  test "uses the proper URL for non-GET requests" do
    Http.Mock.start_link()

    response = {:ok, @ok_resp}

    Http.Mock.put_response(response)

    operation = %Operation{method: :post, params: [hello: "world"], path: "/fake"}

    Postscript.request(operation, http_client: Http.Mock)

    assert "https://api.postscript.io/v1/fake" == Http.Mock.get_request_url()
  end

  test "sends the proper HTTP headers" do
    Http.Mock.start_link()

    response = {:ok, @ok_resp}

    Http.Mock.put_response(response)

    operation = %Operation{}
    operation = Map.put(operation, :method, :get)
    operation = Map.put(operation, :params, hello: "world")
    operation = Map.put(operation, :path, "/fake")

    Postscript.request(operation,
      api_key: "thisisfake",
      http_client: Http.Mock,
      http_headers: [{"x-custom-header", "true"}],
      shop_token: "thisisfake"
    )

    assert {"content-type", "application/json"} in Http.Mock.get_request_headers()
    assert {"authorization", "Bearer thisisfake"} in Http.Mock.get_request_headers()
    assert {"x-custom-header", "true"} in Http.Mock.get_request_headers()
    assert {"x-postscript-shop-token", "thisisfake"} in Http.Mock.get_request_headers()
  end

  test "sends the proper body for GET requests" do
    Http.Mock.start_link()

    response = {:ok, @ok_resp}

    Http.Mock.put_response(response)

    operation = %Operation{method: :get, params: [hello: "world"], path: "/fake"}

    Postscript.request(operation, http_client: Http.Mock)

    assert "" == Http.Mock.get_request_body()
  end

  test "sends the proper body for DELETE requests" do
    Http.Mock.start_link()

    response = {:ok, @ok_resp}

    Http.Mock.put_response(response)

    operation = %Operation{method: :delete, params: [hello: "world"], path: "/fake"}

    Postscript.request(operation, http_client: Http.Mock)

    assert "" == Http.Mock.get_request_body()
  end

  test "sends the proper body for non-GET requests" do
    Http.Mock.start_link()

    response = {:ok, @ok_resp}

    Http.Mock.put_response(response)

    operation = %Operation{method: :post, params: [hello: "world"], path: "/fake"}

    Postscript.request(operation, http_client: Http.Mock)

    assert "{\"hello\":\"world\"}" == Http.Mock.get_request_body()
  end

  test "returns :ok when the request is successful" do
    Http.Mock.start_link()

    response = {:ok, @ok_resp}

    Http.Mock.put_response(response)

    operation = %Operation{method: :post, params: [hello: "world"], path: "/fake"}

    result = Postscript.request(operation, http_client: Http.Mock)

    assert {:ok, %Response{}} = result
  end

  test "returns :error when the request is not successful" do
    Http.Mock.start_link()

    response = {:ok, @not_ok_resp}

    Http.Mock.put_response(response)

    operation = %Operation{method: :post, params: [hello: "world"], path: "/fake"}

    result = Postscript.request(operation, http_client: Http.Mock)

    assert {:error, %Response{}} = result
  end

  test "passes the response through when unrecognized" do
    Http.Mock.start_link()

    response = {:error, :timeout}

    Http.Mock.put_response(response)

    operation = %Operation{method: :post, params: [hello: "world"], path: "/fake"}

    result = Postscript.request(operation, http_client: Http.Mock)

    assert ^response = result
  end

  test "retries failed requests" do
    Http.Mock.start_link()

    response_1 = {:error, :timeout}
    response_2 = {:ok, @ok_resp}

    Http.Mock.put_response(response_1)
    Http.Mock.put_response(response_2)

    operation = %Operation{method: :post, params: [hello: "world"], path: "/fake"}

    result = Postscript.request(operation, http_client: Http.Mock, retry: Postscript.Retry.Linear)

    assert {:ok, %Response{}} = result
  end

  test "retries up to max attempts" do
    Http.Mock.start_link()

    response = {:error, :timeout}

    Http.Mock.put_response(response)
    Http.Mock.put_response(response)
    Http.Mock.put_response(response)
    Http.Mock.put_response(response)

    operation = %Operation{method: :post, params: [hello: "world"], path: "/fake"}

    Postscript.request(operation, http_client: Http.Mock, retry: Postscript.Retry.Linear)

    assert Http.Mock.get_request_count() == 3
  end
end
