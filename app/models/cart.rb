class Cart
  include Mongoid::Document
  include Mongoid::Timestamps
  field :item_id, type: String
  field :quantity, type: Integer
  belongs_to :user
end
