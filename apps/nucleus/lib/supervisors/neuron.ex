defmodule Nucleus.Supervisor.Neuron do
  @moduledoc """
  Documentation for Nucleus.
  """

  use Supervisor

    def start(_type, options) do
      Supervisor.start_link(__MODULE__, options)
    end

    def init([name: name]) do
      children = [
        worker(NeuronInverter, [%{primed: false},  [name: name]])
      ]

      # supervise/2 is imported from Supervisor.Spec
      supervise(children, strategy: :one_for_one)
    end

end
