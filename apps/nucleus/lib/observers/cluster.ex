require Logger

defmodule Nucleus.Observers.Cluster do
  use GenServer

  def start_link(state, opts \\ []) do
    Logger.info("Starting NOC link")
    {:ok, pid} = GenServer.start_link(__MODULE__, state, opts)
    {:ok, pids} = process_state_configurationp(state, humanize_pid(pid))
    {:ok, pid}
  end

  def handle_call(:pop, _from, []) do
    {:reply, nil, []}
  end

  def handle_call(:pop, _from, [h | t]) do
    Logger.info("Call to NCO")
    {:reply, h, t}
  end

  def handle_cast({:push, h}, t) do
    Logger.info("Cast to NCO")
    {:noreply, [h | t]}
  end

  def process_state_configurationp(%{cluster_size: neuron_count}, parent_pid) do
    Logger.info("Starting #{inspect(neuron_count)} neurons")
    neuron_pids = Range.new(0,neuron_count)
      |> Enum.map(fn(idx) ->
        Nucleus.Supervisor.Neuron.start(:cluster_sibling, [name: :"#{parent_pid}MyNeuron#{idx}"])
      end)
      |> Enum.map(fn({:ok, pid}) -> pid end)
    {:ok, neuron_pids}
  end

  def humanize_pid(pid) do
    str = "#{inspect(pid)}"
    "#PID<" <> pid = str
    pid
  end
end
