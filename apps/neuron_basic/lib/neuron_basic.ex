require Logger

defmodule NeuronInverter do
  use GenServer

  @name "NeuronInverter"

  def start_link(state, opts \\ []) do
    Logger.info("Starting #{@name} link")
    GenServer.start_link(__MODULE__, state, opts)
  end

  def handle_call(:primed?, _from, state) do
    {:reply, {:primed, state.primed}, state}
  end


end
