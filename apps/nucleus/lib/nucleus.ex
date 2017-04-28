defmodule Nucleus.Supervisor do
  @moduledoc """
  Documentation for Nucleus.
  """

  use Supervisor

    def start(_type, _opts) do
      Supervisor.start_link(__MODULE__, [])
    end

    def init([]) do
      children = [
        worker(Nucleus.Observers.Cluster, [%{cluster_size: 10},  [name: MyCluster]])
      ]

      # supervise/2 is imported from Supervisor.Spec
      supervise(children, strategy: :one_for_one)
    end

end
