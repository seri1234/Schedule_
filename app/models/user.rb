class User < ApplicationRecord
  has_many :day_schedule, dependent: :destroy
  validates :provider ,presence: true
  validates :uid ,presence: true
  validates :user_name ,presence: true 

  def self.find_or_create_from_auth_hash(auth_hash)
    provider = auth_hash[:provider]                                             #providerはどのサービスで認証したのかを見分けるもの
    uid = auth_hash[:uid]
    user_name = auth_hash[:info][:name]
    image_url = auth_hash[:info][:image]
    
    
    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.user_name = user_name
      user.image_url = image_url
    end
  end
end