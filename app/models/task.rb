class Task < ActiveRecord::Base
    belongs_to :user
    validates :name, presence: true
    validates :description, presence: true
    validates :effort,  numericality: { greater_than: 0, less_than_or_equal_to: 100 }
    validates :priority,  numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10, only_integer: true }
    validates :user_id, presence: true
end