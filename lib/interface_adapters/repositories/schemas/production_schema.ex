defmodule VideoCompactor.InterfaceAdapters.Repositories.Schemas.VideoSchema do
    @moduledoc false
    use Mongo.Collection

    collection :videos do
        attribute :id, Binary.t()
        attribute :file_path, :string
    end

    def new(video) do
        Map.put(new(), :id, video.id)
        |> Map.put(:file_path, video.file_path)
    end
end
