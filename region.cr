require "./province"

# Super class which encapsulates all Provinces in Spain
# Data representation :
#   { "Andulucia" => {data} }
class Region
  attr_accessor :name
  attr_accessor :provinces

  # Pass a data hash which contains a Region => Data file mapping
  def initialize(data_hash = {} of KeyType => ValueType)
    @provinces = [] of ElementType
    data_hash["Provinces"].keys.each do |province|
      puts "Processing #{data_hash["Provinces"][province]}"

      @name = data_hash["Provinces"][province]
      @provinces << Province.new(data_hash:
      {
        "Name" => data_hash["Provinces"][province],
        "id" => province,
        "party_data" => data_hash["party_data"],
        "party_data" => data_hash["vote_data"]
      })
    end
  end
end
