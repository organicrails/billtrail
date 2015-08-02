class Bill
  include Mongoid::Document
  field :name, type: String
  field :dollar, type: Integer
  field :cent, type: Integer
end
