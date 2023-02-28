class Cart
  include Mongoid::Document
  include Mongoid::Timestamps
  field :item_id, type: String
  field :title, type: String
  field :image, type: String
  field :quantity, type: Integer
  belongs_to :user

  has_many :item, dependent: :destroy
end
