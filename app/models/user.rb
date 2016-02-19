class User < ActiveRecord::Base
  has_many :playlists
  
  def self.find_or_create_by_auth(auth)
    user = find_or_create_by(uid: auth[:uid])
    user.update_attributes(
       uid:                auth.uid,
       username:         auth.info.name,
       token:              auth.credentials.token)
    user.save
    user
  end

end
