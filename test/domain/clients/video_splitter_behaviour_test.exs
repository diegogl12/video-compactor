defmodule VideoCompactor.Domain.Clients.VideoSplitterBehaviourTest do
  use ExUnit.Case, async: true

  defmodule DummySplitter do
    @behaviour VideoCompactor.Domain.Clients.VideoSplitterBehaviour
    def split_video(_video_path, _output_path), do: :ok
  end

  test "split_video/2 returns :ok for dummy implementation" do
    assert :ok = DummySplitter.split_video("video.mp4", "frames/")
  end
end
