require "slack"

Slack.configure do |config|
  config.token = ENV.fetch('SLACK_API_TOKEN')
end

class ShuffleTabacoRoom::Slack
  attr_reader :client, :channel

  def initialize(channel:)
    @client  = Slack::Web::Client.new
    @channel = channel
  end

  def notify(a, b)
    client.chat_postMessage(
      channel: channel,
      as_user: true,
      text: <<~MSG,
        今日のタバコ部屋行きは...
        <@#{a[:user_id]}> さん
        <@#{b[:user_id]}> さん
        です！
      MSG
    )
  end
end
