{:ok, _} = Application.ensure_all_started(:ex_machina)
{:ok, _} = Application.ensure_all_started(:bypass)

ExUnit.start(capture_log: true)
