defmodule JiraTest do
  use ExUnit.Case
  doctest Jira

  test "greets the world" do
    assert Jira.hello() == :world
  end
end
