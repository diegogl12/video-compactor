defmodule VideoCompactor.InterfaceAdapters.Gateways.Clients.FfmpexTest do
  use ExUnit.Case, async: false
  use Mimic

  alias VideoCompactor.InterfaceAdapters.Gateways.Clients.Ffmpex

  setup :set_mimic_global
  setup :verify_on_exit!

  test "split_video/2 returns :ok on success" do
    FFmpex
    |> stub(:execute, fn _ -> {:ok, :done} end)

    assert :ok = Ffmpex.split_video("video.mp4", "frames/%04d.png")
  end

  test "split_video/2 returns error on failure" do
    FFmpex
    |> stub(:execute, fn _ -> {:error, "fail"} end)

    assert {:error, "fail"} = Ffmpex.split_video("video.mp4", "frames/%04d.png")
  end
end
