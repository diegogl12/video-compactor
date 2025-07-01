defmodule VideoCompactor.InterfaceAdapters.Gateways.Clients.Ffmpex do
  import FFmpex
  use FFmpex.Options

  @behaviour VideoCompactor.Domain.Clients.VideoSplitterBehaviour

  @impl true
  def split_video(video_path, output_path) do
    FFmpex.new_command()
    |> add_global_option(option_y())
    |> add_input_file(video_path)
    |> add_output_file(output_path)
    |> add_stream_specifier(stream_type: :video)
    |> add_stream_option(option_vf("fps=1"))
    |> execute()
    |> case do
      {:ok, _} -> :ok
      {:error, error} -> {:error, error}
    end
  end
end
