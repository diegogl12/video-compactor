defmodule VideoCompactor.InterfaceAdapters.Repositories.Schemas.VideoSchema do
    @moduledoc false
    use Mongo.Collection

    collection :videos do
        attribute :id, Binary.t()
        attribute :zip_path, :string
    end

    def new(video) do
        Map.put(new(), :id, video.id)
        |> Map.put(:zip_path, video.zip_path)
    end
end
