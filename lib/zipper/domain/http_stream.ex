defmodule Zipper.Domain.HttpStream do
  def get(url) do
    Stream.resource(
      start_fun(url),
      &next_fun/1,
      &end_fun/1
    )
  end

  defp start_fun(url) do
    fn ->
      HTTPoison.get!(
        url,
        %{},
        stream_to: self(),
        async: :once
      )
    end
  end

  defp next_fun(%HTTPoison.AsyncResponse{id: id} = resp) do
    receive do
      %HTTPoison.AsyncStatus{id: ^id} ->
        HTTPoison.stream_next(resp)
        {[], resp}

      %HTTPoison.AsyncHeaders{id: ^id} ->
        HTTPoison.stream_next(resp)
        {[], resp}

      %HTTPoison.AsyncChunk{id: ^id, chunk: chunk} ->
        HTTPoison.stream_next(resp)
        {[chunk], resp}

      %HTTPoison.AsyncEnd{id: ^id} ->
        {:halt, resp}
    end
  end

  defp end_fun(%HTTPoison.AsyncResponse{id: id}), do: :hackney.stop_async(id)
end
