class Genre < ApplicationRecord
  has_many :books

  after_commit :reindex_book

  def reindex_book
    book.reindex # or reindex_async
  end
end
