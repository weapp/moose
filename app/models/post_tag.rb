# == Schema Information
#
# Table name: post_tags
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  tag_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostTag < ActiveRecord::Base
  belongs_to :post
  belongs_to :tag
  attr_accessible :post_id, :tag_id
end
