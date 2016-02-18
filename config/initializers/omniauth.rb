# setting up Omniauth on initialize
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], skip_jwt: true,
     scope: 'profile',
     image_aspect_ratio: 'square',
     image_size: 48,
     access_type: 'online',
     name: 'google',
     prompt: 'select_account'
end


Echowrap.configure do |config|
   config.api_key =       'SWOUMYTGV1Z9RU0RU'
   config.consumer_key =  '507bf603c2988d68f49c17577d33a093'
   config.shared_secret = 'rI36al/AR3elGVNGSyIQ7g'
end
