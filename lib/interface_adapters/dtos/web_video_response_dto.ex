defmodule VideoCompactor.InterfaceAdapters.DTOs.WebVideoResponseDTO do
  alias VideoCompactor.Domain.Entities.Video

  @derive Jason.Encoder
  defstruct [:id, :zip_path]

  @type t :: %__MODULE__{
          id: String.t(),
          zip_path: String.t()
        }

  @callback from_map(map()) :: {:ok, t()} | {:error, String.t()}
  def from_map(map) do
    map_with_atoms =
      map
      |> Enum.map(fn {key, value} ->
        {String.to_existing_atom(key), value}
      end)
      |> Map.new()

    result = %__MODULE__{
      id: Map.get(map_with_atoms, :id),
      zip_path: Map.get(map_with_atoms, :zip_path)
    }

    {:ok, result}
  end

  @callback from_domain(Video.t()) :: {:ok, t()}
  def from_domain(%Video{} = video) do
    result = %__MODULE__{
      id: video.id,
      zip_path: video.zip_path
    }

    {:ok, result}
  end
end
