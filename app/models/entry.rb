class Entry < ApplicationRecord

  has_many :attachments

  validates :date, presence: true
  validates :content, presence: true

  scope :ordered, -> { order(date: :asc) }

  def title
    "##{id}"
  end

end
