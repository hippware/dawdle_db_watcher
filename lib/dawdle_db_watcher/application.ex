defmodule DawdleDBWatcher.Application do
  @moduledoc """
  The Dawdle DB Watcher Service.
  """
  use Application

  def start(_type, _args) do
    DawdleDB.Watcher.Supervisor.start_link()
  end
end
