class Attendee < ActiveRecord::Base
    has_many :purchases
    has_many :merchandises, through: :purchases

end