# encoding: utf-8
require "csv"

require "./parties"
# Class for providing data at a community
# level.
class City
  attr_accessor :name
  attr_accessor :id
  attr_accessor :parties
  attr_accessor :result

  def initialize(data_hash = {} of KeyType => ValueType)
    @name = data_hash["Name"]
    @id = data_hash["cid"]
    @parties = Parties.new(data_hash: data_hash)

    total_votes = 0.0
    parties.each do |party|
      total_votes += party["vote_count"]
    end

    @result = {} of KeyType => ValueType
    @result["parties"] = [] of ElementType
    parties.each do |party|
      percentage = (party["vote_count"] / total_votes) * 100
      @result["parties"] << {
        "name" => party["name"]["shortName"],
        "total_votes" => total_votes,
        "vote_count" => party["vote_count"],
        "percentage" =>  percentage }
    end
  end
end
