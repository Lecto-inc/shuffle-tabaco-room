# frozen_string_literal: true

require "socket"
require "timeout"

RSpec.describe ShuffleTabacoRoom do
  before do
    allow(Date).to receive(:today).and_return(Date.new(2026, 10, 27))
  end

  it "has a version number" do
    expect(ShuffleTabacoRoom::VERSION).not_to be nil
  end

  it "only selects members available today without duplicates" do
    members = ShuffleTabacoRoom::Members.new.shuffle

    expect(members.map { |member| member[:user_id] }).to match_array(%w[test-a test-b test-c])
  end

  it "runs the CLI and posts the notification to a local HTTP stub" do
    server = TCPServer.new("127.0.0.1", 0)
    request = nil
    listener = Thread.new do
      socket = server.accept
      path = socket.gets
      headers = {}
      while (line = socket.gets) != "\r\n"
        key, value = line.split(":", 2)
        headers[key.downcase] = value.strip
      end
      request = { path: path, body: socket.read(headers.fetch("content-length").to_i) }
      body = '{"ok":true}'
      socket.write("HTTP/1.1 200 OK\r\nContent-Type: application/json\r\nContent-Length: #{body.bytesize}\r\nConnection: close\r\n\r\n#{body}")
      socket.close
    end
    web_client = Slack::Web::Client.new(endpoint: "http://127.0.0.1:#{server.addr[1]}/api/")
    allow(Slack::Web::Client).to receive(:new).and_return(web_client)

    Timeout.timeout(5) do
      ShuffleTabacoRoom::CLI.start(%w[shuffle random])
      listener.join
    end

    expect(request[:path]).to start_with("POST /api/chat.postMessage ")
    message = URI.decode_www_form(request[:body]).to_h
    expect(message["channel"]).to eq("random")
    expect(message["as_user"]).to eq("true")
    mentions = message.fetch("text").scan(/<@(test-[a-d])>/).flatten
    expect(mentions.size).to eq(2)
    expect(mentions.uniq.size).to eq(2)
    expect(mentions - %w[test-a test-b test-c]).to be_empty
  ensure
    listener&.kill
    server&.close
  end
end
