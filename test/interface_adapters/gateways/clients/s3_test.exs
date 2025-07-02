defmodule VideoCompactor.InterfaceAdapters.Gateways.Clients.S3Test do
  use ExUnit.Case, async: false
  use Mimic

  alias VideoCompactor.InterfaceAdapters.Gateways.Clients.S3

  setup :set_mimic_global
  setup :verify_on_exit!

  describe "upload_file/2" do
    test "returns :ok on success" do
      File
      |> stub(:read!, fn _ -> "file-content" end)
      ExAws.S3
      |> stub(:put_object, fn _, _, _ -> :put_object end)
      ExAws
      |> stub(:request, fn :put_object -> {:ok, %{}} end)

      assert :ok = S3.upload_file("bucket/path", "local/path")
    end

    test "returns error on failure" do
      File
      |> stub(:read!, fn _ -> "file-content" end)
      ExAws.S3
      |> stub(:put_object, fn _, _, _ -> :put_object end)
      ExAws
      |> stub(:request, fn :put_object -> {:error, "fail"} end)

      assert {:error, "fail"} = S3.upload_file("bucket/path", "local/path")
    end
  end

  describe "download_file/2" do
    test "returns :ok on success" do
      ExAws.S3
      |> stub(:download_file, fn _, _, _ -> :download_file end)
      ExAws
      |> stub(:request, fn :download_file -> {:ok, %{}} end)

      assert :ok = S3.download_file("bucket/path", "local/path")
    end

    test "returns error on failure" do
      ExAws.S3
      |> stub(:download_file, fn _, _, _ -> :download_file end)
      ExAws
      |> stub(:request, fn :download_file -> {:error, "fail"} end)

      assert {:error, "fail"} = S3.download_file("bucket/path", "local/path")
    end
  end

  describe "delete_file/1" do
    test "always returns :ok" do
      assert :ok = S3.delete_file("bucket/path")
    end
  end
end
