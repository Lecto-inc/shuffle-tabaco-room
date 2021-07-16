require "shuffle_tabaco_room"
require "thor"

class ShuffleTabacoRoom::CLI < Thor
  desc "shuffle", "メンバーをシャッフルして結果をSlackに通知します"
  def shuffle
    a, b = ShuffleTabacoRoom::Members.new.shuffle
    pp a, b
    puts "今日は #{a[:name]} #{b[:name]}"
  end
end
