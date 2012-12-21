class AddAttachmentAttachmentToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.has_attached_file :attachment
    end
  end

  def self.down
    drop_attached_file :posts, :attachment
  end
end
