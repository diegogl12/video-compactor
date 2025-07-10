defmodule VideoCompactor.InterfaceAdapters.DTOs.VideoContentEventDTOTest do
  use ExUnit.Case, async: true

  alias VideoCompactor.InterfaceAdapters.DTOs.VideoContentEventDTO
  alias VideoCompactor.Domain.Entities.Video

  describe "from_map/1" do
    test "successfully converts map to DTO" do
      map = %{"Video_Id" => "video-123", "Path" => "some/path", "Extension" => "mp4"}
      {:ok, dto} = VideoContentEventDTO.from_map(map)
      assert dto.video_id == "video-123"
      assert dto.path == "some/path"
      assert dto.extension == "mp4"
    end
  end

  describe "from_json/1" do
    test "successfully converts JSON to DTO" do
      json = ~s({"Video_Id": "video-123", "Path": "some/path", "Extension": "mp4"})
      {:ok, dto} = VideoContentEventDTO.from_json(json)
      assert dto.video_id == "video-123"
      assert dto.path == "some/path"
      assert dto.extension == "mp4"
    end
  end

  describe "to_domain/1" do
    test "successfully converts DTO to domain entity" do
      dto = %VideoContentEventDTO{video_id: "video-123", path: "some/path", extension: "mp4"}

      {:ok, %Video{id: id, temp_file_path: path, extension: ext}} =
        VideoContentEventDTO.to_domain(dto)

      assert id == "video-123"
      assert path == "some/path"
      assert ext == "mp4"
    end
  end
end
