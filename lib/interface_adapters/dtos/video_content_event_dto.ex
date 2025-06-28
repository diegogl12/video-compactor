defmodule VideoCompactor.InterfaceAdapters.DTOs.VideoContentEventDTO do
  alias VideoCompactor.Domain.Entities.Video

  defstruct [:video_id, :path, :extension]

  @type t :: %__MODULE__{
          video_id: String.t(),
          path: bitstring(),
          extension: String.t()
        }

  @callback from_map(map()) :: {:ok, t()} | {:error, String.t()}
  def from_map(map) do
    map_with_atoms = atom_map(map)

    result = %__MODULE__{
      video_id: Map.get(map_with_atoms, :video_id),
      path: Map.get(map_with_atoms, :path),
      extension: Map.get(map_with_atoms, :extension)
    }

    {:ok, result}
  end

  def from_json(json) do
    json
    |> Jason.decode!()
    |> atom_map()
    |> from_map()
  end

  def to_domain(%__MODULE__{} = dto) do
    {:ok,
     %Video{
       id: dto.video_id,
       temp_file_path: dto.path,
       extension: dto.extension
     }}
  end

  defp atom_map(map) do
    map
    |> Enum.map(fn
      {key, value} when is_binary(key) -> {String.to_existing_atom(key), value}
      {key, value} -> {key, value}
    end)
    |> Map.new()
  end
end
