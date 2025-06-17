defmodule VideoCompactor.Domain.Repositories.VideoRepositoryBehaviour do
  alias VideoCompactor.Domain.Entities.Video

  @callback create(Video.t()) :: {:ok, Video.t()} | {:error, any()}
  @callback update(Video.t()) :: {:ok, Video.t()} | {:error, any()}
  @callback get_by_id(String.t()) :: {:ok, Video.t()} | {:error, any()}
end
