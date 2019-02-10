class User < ApplicationRecord
  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]                                                  #providerはどのサービスで認証したのかを見分けるもの
    uid = auth[:uid]
    user_name = auth[:info][:user_name]
    image_url = auth[:info][:image]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.user_name = user_name
      user.image_url = image_url
    end
  end
end