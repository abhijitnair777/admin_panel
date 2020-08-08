class Genre < ApplicationRecord
  has_many :books	

  searchkick
end
