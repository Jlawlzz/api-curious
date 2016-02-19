class Artist < ActiveRecord::Base
  has_many :songs

  def self.find_or_create_artist(norm_data)
    if find_artist(norm_data).nil?
      @artist = Artist.create(sc_id: norm_data[:artist][:sc_id],
                    echo_id: norm_data[:artist][:echo_id],
                    name: norm_data[:artist][:name])
    end
    @artist
  end

  def self.find_artist(norm_data)
    @artist = Artist.find_by(echo_id: norm_data[:artist][:echo_id])
  end
end
