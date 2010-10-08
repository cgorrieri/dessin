class User < ActiveRecord::Base

  has_many :folders
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :avatar, :pseudo, :birth_date, :sex, :description, :role, :email, :password, :password_confirmation, :remember_me

  validates :pseudo, :presence => true, :uniqueness => true
  validates :birth_date, :presence => true

  SEX = {'Non dit' => 'NC', 'Homme' => 'H', 'Femme' => 'F'}

  has_many :friends, :foreign_key => 'user_id'

  has_attached_file :avatar,
    :styles => {:thumb => "150x150#"},
    :url => "/images/avatar/:id/:style_:basename.:extension",
    :path => ":rails_root/public/images/avatar/:id/:style_:basename.:extension",
    :default_url => "/images/avatar/default.jpeg"

  def url(*args)
    avatar.url(*args)
  end

  def name
    avatar_file_name
  end

  def content_type
    avatar_content_type
  end

  def size
    avatar_file_size
  end

end
