class Purhcase < ActiveRecord::Base
    belongs_to :attendees
    belongs_to :merchandises

end