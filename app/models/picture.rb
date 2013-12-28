class Picture < ActiveRecord::Base
  # attr_accessible :description, :gallery_id, :image, :crop_x, :crop_y, :crop_w, :crop_h, :gallery_token
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  belongs_to :gallery

  mount_uploader :image, ImageUploader

  after_update :crop_image

  def to_jq_upload
    {
      "name" => read_attribute(:image),
      "size" => image.size,
      "url" => image.url,
      "preview_url" => image.preview.url,
      "delete_url" => id,
      "picture_id" => id,
      "delete_type" => "DELETE"
    }
  end

  def crop_image
    raise "Not working because using S3"
    # image.recreate_versions! if crop_x.present?
    # # current_version = self.image.current_path
    # current_version = self.image.url
    # large_version = "#{Rails.root}/public" + self.image.versions[:large].to_s

    # FileUtils.rm(current_version)
    # FileUtils.cp(large_version, current_version)
  end
end
