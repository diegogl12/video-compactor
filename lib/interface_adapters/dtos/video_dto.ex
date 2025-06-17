defmodule VideoCompactor.InterfaceAdapters.DTOs.WebVideoDTO do
  alias VideoCompactor.Domain.Entities.Video

  defstruct [:id, :file_path]

  @type t :: %__MODULE__{
          id: String.t(),
          file_path: String.t()
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
      file_path: Map.get(map_with_atoms, :file_path)
    }

    {:ok, result}
  end

  @callback to_domain(t()) :: {:ok, Video.t()}
  def to_domain(%__MODULE__{} = dto) do
    result = %Video{
      id: dto.id,
      file_path: dto.file_path
    }

    {:ok, result}
  end
end
