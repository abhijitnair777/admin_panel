class Book < ApplicationRecord
  belongs_to :author
  belongs_to :genre

  searchkick word_start: [:name, :price, :genre]

  def search_data
    {
      name: name,
      price: price
    }
        attributes.merge(
    genre_name: genres.map(&:name)
  )
  end
end
