defmodule Zipper.Domain.AgentTest do
  use Zipper.TestCase, async: false

  alias Zipper.Domain.Agent

  @archive_name "archive"

  setup do
    Agent.invalidate()

    :ok
  end

  test "should have initial empty state" do
    assert %{} == Agent.state()
  end

  test "should mark archive as not completed" do
    Agent.mark_started(@archive_name)

    assert %{@archive_name => false} = Agent.state()
  end

  test "should mark archive as completed" do
    Agent.mark_started(@archive_name)
    Agent.mark_finished(@archive_name)

    assert %{@archive_name => true} = Agent.state()
  end

  test "should check archive status" do
    assert nil == Agent.status(@archive_name)

    Agent.mark_started(@archive_name)

    assert false == Agent.status(@archive_name)

    Agent.mark_finished(@archive_name)

    assert Agent.status(@archive_name)
  end
end
