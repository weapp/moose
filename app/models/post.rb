# == Schema Information
#
# Table name: posts
#
#  id                      :integer          not null, primary key
#  text                    :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#

class Post < ActiveRecord::Base
  belongs_to :user

  attr_accessible :text, :attachment

  #has_attached_file :attachment, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_attached_file :attachment
  # => ,:path => ":rails_root/uploads/:class/:id/:basename.:extension"

  def to_param
    id
  end

  def self.find(id)
    find_by_id(id)
  end

end
