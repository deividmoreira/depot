class Product < ActiveRecord::Base
  default_scope :order => 'title'
  has_many :line_items
  
  validates :title, :description, :image_url, :price, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
  validates :image_url, :format => {:with => %r{\.(gif|jpg|png)$}i,
                                    :message => 'must be a URl for GIF, JPG or PNG image.'}
  before_destroy :ensure_not_referenced_by_any_line_item
  
  private
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line items present')
      return false  
    end
  end                                    
                                    
end
