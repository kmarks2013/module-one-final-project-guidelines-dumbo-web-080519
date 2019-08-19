class Merchandise < ActiveRecord::Base
    has_many :purchases
    has_many :attendees, through: :purchases
end