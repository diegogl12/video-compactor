defmodule VideoCompactor.InterfaceAdapters.Repositories.VideoRepository do
  require Logger

  @behaviour VideoCompactor.Domain.Repositories.VideoRepositoryBehaviour

  alias VideoCompactor.Infra.Repo.Mongo
  alias VideoCompactor.Domain.Entities.Video
  alias VideoCompactor.InterfaceAdapters.Repositories.Schemas.VideoSchema

  @impl true
  def create(%Video{} = video) do
    VideoSchema.new(video)
    |> Mongo.insert()
    |> case do
      {:ok, _} ->
        {:ok, video}

      {:error, error} ->
        {:error, error}
    end
  end

  @impl true
  def update(%Video{} = new_video) do
    with old_video_schema <- Mongo.get_by(VideoSchema, %{id: new_video.id}),
         new_video_schema <- %{VideoSchema.new(new_video) | _id: old_video_schema._id},
         new_video_schema <- Map.merge(old_video_schema, new_video_schema),
         {:ok, result_video_schema} <- Mongo.update(new_video_schema) do
      {:ok, to_video(result_video_schema)}
    end
  end

  @impl true
  def get_by_id(id) do
    case Mongo.get_by(VideoSchema, %{id: id}) do
      nil ->
        {:error, :not_found}

      {:error, error} ->
        {:error, error}

      video ->
        {:ok, to_video(video)}
    end
  end

  defp to_video(video_schema) do
    %Video{
      id: Map.get(video_schema, :id),
      zip_path: Map.get(video_schema, :zip_path)
    }
  end
end
