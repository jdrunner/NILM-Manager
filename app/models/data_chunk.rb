class DataChunk
  include Mongoid::Document
  
  field :start_at, type: DateTime
  field :end_at, type: DateTime
  field :comment, type: String
  field :archive, type: String
 


end
