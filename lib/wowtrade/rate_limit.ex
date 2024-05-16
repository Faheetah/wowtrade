defmodule Wowtrade.RateLimit do
  use GenServer

  @limit 600

  defstruct [current: 0, remaining: @limit, requests: List.duplicate(0, 60)]

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  # Simulate request floods with: Enum.map(0..500, &Wowtrade.RateLimit.request/1)
  def request(_nothing \\ 0) do
    GenServer.call(__MODULE__, :request)
  end

  def get_request_limits() do
    GenServer.call(__MODULE__, :get_limits)
  end

  @impl true
  def init(_params) do
    schedule_tick()

    {:ok, %Wowtrade.RateLimit{}}
  end

  @impl true
  def handle_call(:request, _from, state) do
    if state.current < 50 && state.remaining > 0 do
      {:reply, :ok, Map.put(state, :current, state.current + 1)}
    else
      {:reply, {:error, "rate limit exceeded"}, state}
    end
  end

  @impl true
  def handle_call(:get_limits, _from, state) do
    {:reply, %{second: state.current, hour: @limit - state.remaining}, state}
  end

  @impl true
  def handle_info(:tick, %__MODULE__{} = state) do
    schedule_tick()


    current = state.current
    [new | requests] = state.requests

    remaining = state.remaining + new - current

    {
      :noreply, %__MODULE__{
        current: 0,
        remaining: remaining > @limit && @limit || remaining,
        requests: Enum.reverse([current | Enum.reverse(requests)])
      }
    }
  end

  defp schedule_tick() do
    Process.send_after(self(), :tick, 1_000)
  end
end
