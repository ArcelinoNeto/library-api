class Author < ApplicationRecord
    has_many :books, dependent: :destroy

    validates_presence_of :name
    validates_uniqueness_of :name
    validates_presence_of :genre_predominant
    validates_presence_of :years_old
end
