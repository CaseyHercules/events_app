class Event < ApplicationRecord
    validates :name, presence: true
    validates :event_type, presence: true
end
