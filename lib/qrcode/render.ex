defmodule QRCode.Render do
  @moduledoc """
  Render the QR Code matrix.
  """

  @doc """
  Render the QR Code to terminal.
  """
  @spec render(QRCode.Matrix.t) :: :ok
  def render(%QRCode.Matrix{matrix: matrix}) do
    Tuple.to_list(matrix)
    |> Stream.map(fn e ->
      Tuple.to_list(e)
      |> Enum.map(&do_render/1)
    end)
    |> Enum.intersperse("\n")
  end

  defp do_render(1),         do: "\e[40m  \e[0m"
  defp do_render(0),         do: "\e[0;107m  \e[0m"
  defp do_render(nil),       do: "\e[0;106m  \e[0m"
  defp do_render(:data),     do: "\e[0;102m  \e[0m"
  defp do_render(:reserved), do: "\e[0;104m  \e[0m"

  @doc """
  Rotate the QR Code 90 degree clockwise and render to terminal.
  """
  @spec render2(QRCode.Matrix.t) :: :ok
  def render2(%QRCode.Matrix{matrix: matrix}) do
    (for e <- Tuple.to_list(matrix), do: Tuple.to_list(e))
    |> Enum.reverse()
    |> transform()
    |> Stream.map(fn e ->
      Enum.map(e, &do_render/1)
    end)
    |> Enum.intersperse("\n")
  end

  defp transform(matrix) do
    for e <- Enum.zip(matrix), do: Tuple.to_list(e)
  end
end
