# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  tag        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
  has_many :post_tags
  has_many :posts, through: :post_tags
  
  attr_accessible :tag


  # def to_param
  #   tag
  # end

  # def self.find(tag)
  #   find_by_tag(tag)
  # end

  # def self.from_param(param)
  #   self.first :conditions => { :tag => param }
  # end

end
