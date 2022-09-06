class Book < ApplicationRecord
  belongs_to :author

  validates_presence_of :title
  validates_presence_of :genre
  validates_presence_of :puclication_date
  validates_presence_of :publishing_company
end
