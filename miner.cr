require "./region"

class Miner
  attr_accessor :regions
  def initialize(data_hash = {} of KeyType => ValueType)
    @regions = [] of ElementType
    data_hash.keys.each do |region|
      puts "Processing #{region}"
      @regions << Region.new(data_hash: data_hash[region])
    end
  end

  def dump
    puts "Start dumping to out.json"
  end
end
