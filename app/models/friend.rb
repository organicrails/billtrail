class Friend
  include Mongoid::Document
  embedded_in :bill

  field :name, type: String

  # ensures that name is not empty
  validates_presence_of :name

end
