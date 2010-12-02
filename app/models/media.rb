class Media < ActiveRecord::Base
  belongs_to :media_container, :polymorphic => true
  
  has_attached_file :image,
    :styles => {
      :small => "150x150",
      :thumb => "100x100#"},
    :url => "/images/:class/:id/:style_:basename.:extension",
    :path => ":rails_root/public/images/:class/:id/:style_:basename.:extension",
    :default_url => "rails.png"

  def url(*args)
    image.url(*args)
  end

  def name
    image_file_name
  end

  def content_type
    image_content_type
  end

  def size
    image_file_size
  end
end
