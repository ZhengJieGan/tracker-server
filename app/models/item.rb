class Item
  include Mongoid::Document
  include Mongoid::Timestamps
  field :image, type: String
  field :title, type: String
end
