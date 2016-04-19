class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, :login, length: { maximum: 50 }

  # validates :first_name, :last_name, :login, presence: true

  mount_uploader :avatar, AvatarUploader

  # mount_uploaders :images, ImageUploader
  # serialize :images, Array

end
