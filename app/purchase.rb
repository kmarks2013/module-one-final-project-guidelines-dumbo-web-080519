class Purchase < ActiveRecord::Base
    belongs_to :attendee
    belongs_to :merchandise

end