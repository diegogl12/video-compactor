defmodule VideoCompactor.Domain.Clients.VideoManagerBehaviourTest do
  use ExUnit.Case, async: true

  alias VideoCompactor.Domain.Entities.Video

  defmodule DummyManager do
    @behaviour VideoCompactor.Domain.Clients.VideoManagerBehaviour
    def update_status(%Video{} = _video, _status), do: :ok
  end

  test "update_status/2 returns :ok for dummy implementation" do
    video = %Video{id: "video-123"}
    assert :ok = DummyManager.update_status(video, "COMPACTED")
  end
end
