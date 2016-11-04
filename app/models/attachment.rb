class Attachment < ActiveRecord::Base

  belongs_to :entry

  mount_uploader :file, AttachmentUploader

  validates :name, presence: true
  validates :extension, presence: true
  validates :size, presence: true
  validates :file, presence: true

  before_validation(on: :create) {
    self.name = self.file.file.filename if self.file.present?
    self.extension = self.file.file.extension.downcase if self.file.present?
    self.size = self.file.file.size if self.file.present?
  }

  def image?
    ["png", "jpg", "gif", "jpeg"].include?(extension)
  end

end
