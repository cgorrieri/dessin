class HomeController < ApplicationController
  def index
    @medias = Media.find_all_by_media_container_type('Gallery').reverse[0..9]
    @informations = Information.all.reverse[0..6]
  end

end
