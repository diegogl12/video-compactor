defmodule VideoCompactor.Domain.Entities.Video do
  @derive {Jason.Encoder, only: [:id, :file_path]}
  defstruct [id: nil, file_path: nil]

  @type t :: %__MODULE__{
          id: String.t(),
          file_path: String.t()
        }

  def new(attrs) do
    video =
      struct(
        __MODULE__,
        Map.merge(attrs, %{})
      )

    {:ok, video}
  end
end
