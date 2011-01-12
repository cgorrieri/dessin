class Gallery < ActiveRecord::Base
  belongs_to :user
  has_many :drawings, :as => :media_container, :class_name => 'Media', :dependent => :destroy

  MIN_KEYWORDS = 1
  MAX_KEYWORDS = 4

  validates :name, :presence => true
  validate :keywords_validation

  def keywords_validation
    if self.keywords.nil?
      number_of_keywords = 0
    else
      number_of_keywords = self.keywords.split(',').count
    end
    if number_of_keywords < MIN_KEYWORDS || number_of_keywords > MAX_KEYWORDS
      errors.add(:keywords , :keywords_must_be_contains_between, :min => MIN_KEYWORDS, :max => MAX_KEYWORDS)
    end
  end

  @@per_page = 10
  
end
