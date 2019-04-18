# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :dawdle,
  start_pollers: false,
  backend: Dawdle.Backend.SQS
