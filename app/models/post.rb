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
#  user_id                 :integer
#

class Post < ActiveRecord::Base
  belongs_to :user
  has_many :post_tags
  has_many :tags, through: :post_tags

  attr_accessible :text, :attachment, :tag_ids, :user_id, :public

  #has_attached_file :attachment, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_attached_file :attachment
  # => ,:path => ":rails_root/uploads/:class/:id/:basename.:extension"

  default_scope order('posts.created_at DESC').includes :tags

  scope :tagged, lambda { |tag| where('tags.tag' => tag) }


end
