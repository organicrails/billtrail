class Bill
  include Mongoid::Document
  field :event_name, type: String

  # 1-N relationships for transactions
  embeds_many :transactions

  validates_presence_of :event_name
end
