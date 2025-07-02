defmodule VideoCompactor.InterfaceAdapters.DTOs.WebVideoResponseDTOTest do
  use ExUnit.Case, async: true

  alias VideoCompactor.InterfaceAdapters.DTOs.WebVideoResponseDTO
  alias VideoCompactor.Domain.Entities.Video

  describe "from_map/1" do
    test "successfully converts map to DTO" do
      map = %{"id" => "video-123", "zip_path" => "zip/video-123.zip"}
      {:ok, dto} = WebVideoResponseDTO.from_map(map)
      assert dto.id == "video-123"
      assert dto.zip_path == "zip/video-123.zip"
    end
  end

  describe "from_domain/1" do
    test "successfully converts Video to DTO" do
      video = %Video{id: "video-123", zip_path: "zip/video-123.zip"}
      {:ok, dto} = WebVideoResponseDTO.from_domain(video)
      assert dto.id == "video-123"
      assert dto.zip_path == "zip/video-123.zip"
    end
  end
end
