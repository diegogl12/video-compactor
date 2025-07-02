defmodule Domain.Clients.BucketBehaviourTest do
  use ExUnit.Case, async: true

  defmodule DummyBucket do
    @behaviour Domain.Clients.BucketBehaviour
    def upload_file(_bucket_path, _local_path), do: :ok
    def download_file(_bucket_path, _local_path), do: :ok
    def delete_file(_bucket_path), do: :ok
  end

  test "upload_file/2 returns :ok for dummy implementation" do
    assert :ok = DummyBucket.upload_file("bucket/file", "local/file")
  end

  test "download_file/2 returns :ok for dummy implementation" do
    assert :ok = DummyBucket.download_file("bucket/file", "local/file")
  end

  test "delete_file/1 returns :ok for dummy implementation" do
    assert :ok = DummyBucket.delete_file("bucket/file")
  end
end
