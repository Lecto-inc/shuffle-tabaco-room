# frozen_string_literal: true

ENV["SLACK_API_TOKEN"] = "test-only-token"
ENV["MEMBERS"] = '[{"name":"A","availables":[],"user_id":"test-a"},{"name":"B","availables":["tue"],"user_id":"test-b"},{"name":"C","availables":["tue"],"user_id":"test-c"},{"name":"D","availables":["mon"],"user_id":"test-d"}]'

require "shuffle_tabaco_room"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
