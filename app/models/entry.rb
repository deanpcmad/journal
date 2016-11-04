class Entry < ApplicationRecord

  has_many :attachments

  validates :date, presence: true
  validates :content, presence: true

end
