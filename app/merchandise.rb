class Merchandise < ActiveRecord::Base
    has_many :purchases
    has_many :attendees, through: :purchases
    belongs_to :booth 

    
end