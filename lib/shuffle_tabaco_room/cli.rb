require "shuffle_tabaco_room"
require "thor"

class ShuffleTabacoRoom::CLI < Thor
  desc "shuffle CHANNEL", "メンバーをシャッフルして結果をSlackに通知します"
  def shuffle(channel)
    a, b, c = ShuffleTabacoRoom::Members.new.shuffle
    ShuffleTabacoRoom::Slack.new(channel: channel).notify(a, b)
  end
end
