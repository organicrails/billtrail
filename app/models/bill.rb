class Bill
  include Mongoid::Document
  field :event_name, type: String
  field :urlID, type: String

  # creates a urlID that the users can refer to afterwards
  field :_id, type: String, default: ->{ urlID }

  # contains many transactions
  embeds_many :transactions
  embeds_many :friends

  # validates presence of event_name and urlID.
  validates_presence_of :event_name, :urlID

  #validates the uniqueness of urlID
  validates_uniqueness_of :urlID

end
