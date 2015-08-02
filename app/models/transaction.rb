class Transaction
  include Mongoid::Document

  embedded_in :bill

  field :payer, type: String
  field :dollar, type: Integer
  field :cent, type: Integer

  validates_presence_of :payer, :dollar, :cent
  validates_length_of :cent, :maximum => 2
end
