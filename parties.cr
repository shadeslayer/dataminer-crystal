# Array of parties in a province
class Parties < Array
  def initialize(data_hash = {} of KeyType => ValueType)
    # TODO: Optimize this so that we don't read it again
    # and again
    party_data = {} of KeyType => ValueType
    File.readlines(data_hash["party_data"]).each do |s|
      match = s.scan(/(\w{2})(\d{4})(\d{2})(\d{6})([[:print:]]{,50})([[:print:]]{,150})/)
      match.flatten!
      match[4].strip!
      match[5].strip!
      party_data[match[3]] = { "shortName" => match[4],
                               "fullName"  => match[5] }
    end

    File.readlines(data_hash["vote_data"]).each do |s|
      # Data on how things are matched :
      #   First 2 characters are election type
      #   Next 4 characters are year
      #   Next 2 characters are month
      #   Next 2 characters are province id
      #   Next 3 characters city id
      #   Next 2 characters are district id
      #   Next 6 characters are party id
      #   Next 8 characters are vote count
      # We get a array of arrays back
      match = s.scan(/(\w{2})(\d{4})(\d{2})(\d{2})(\d{3})(\d{2})(\d{6})(\d{8})/)
      match.flatten!

      # Make sure the province id and city id matches
      next unless match[3] == data_hash["id"]
      next unless match[4] == data_hash["cid"]

      # Don't count parties with 0 votes
      next unless match[7].to_i > 0
      self << {
        "party_id" => match[6],
        "name" => party_data[match[6]],
        "vote_count" => match[7].to_f
      }
    end
  end
end
