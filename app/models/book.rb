class Book < ApplicationRecord
  belongs_to :author
  belongs_to :genre

  searchkick word_start: [:name, :price, :genre_name]

  scope :search_import, -> { includes(:genre, :author) }

  def search_data
    {
      name: name,
      price: price
    }
          attributes.merge(
      genre_name: genre.name,
      author_first_name: author.first_name,
      author_last_name: author.last_name
      )
  end
end
