defmodule VideoCompactor.UseCases.GetVideo do

  def get_video(id, repository \\ VideoRepository) do
    repository.get_by_id(id)
  end
end
