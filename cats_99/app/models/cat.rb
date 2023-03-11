require "action_view"

class Cat < ApplicationRecord
    include ActionView::Helpers::DateHelper

    CAT_COLORS = ["orange", "grey", "black", "white"]

    validates :birth_date, :color, :name,:sex, presence: true
    validates :color, inclusion: { in: CAT_COLORS,
    message: "%{value} is not a valid color" }
    validates :sex, inclusion: { in: %w(M F),
    message: "%{value} is not a valid sex" }
    validate :birth_date_cannot_be_in_the_future

  def birth_date_cannot_be_in_the_future
    if birth_date.present? && birth_date > Date.today
      errors.add(:birth_date, "can't be in the future")
    end
  end

  def age
    time_ago_in_words(self.birth_date)
  end


end
