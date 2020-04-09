class Partnership < ApplicationRecord
  belongs_to :partner
  belongs_to :place
end
