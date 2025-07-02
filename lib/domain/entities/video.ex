defmodule VideoCompactor.Domain.Entities.Video do
  @derive {Jason.Encoder, only: [:id, :temp_file_path, :zip_path, :status, :extension]}
  defstruct id: nil, temp_file_path: nil, zip_path: nil, status: nil, extension: nil

  @type t :: %__MODULE__{
          id: String.t(),
          temp_file_path: String.t() | nil,
          zip_path: String.t() | nil,
          status: String.t() | nil,
          extension: String.t() | nil
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
