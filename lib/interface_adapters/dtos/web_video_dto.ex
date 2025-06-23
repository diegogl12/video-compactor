defmodule VideoCompactor.InterfaceAdapters.DTOs.WebVideoDTO do
  alias VideoCompactor.Domain.Entities.Video

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

  @callback to_domain(t()) :: {:ok, Video.t()}
  def to_domain(%__MODULE__{} = dto) do
    result = %Video{
      id: dto.id,
      zip_path: dto.zip_path
    }

    {:ok, result}
  end
end
