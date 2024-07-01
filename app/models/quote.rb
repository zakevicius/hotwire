# frozen_string_literal: true

class Quote < ApplicationRecord
  has_many :line_item_dates, dependent: :destroy
  belongs_to :company

  validates :name, presence: true

  scope :recent, -> { order(id: :desc) }

  # after_create_commit do
  #   broadcast_prepend_to 'quotes',
  #                        partial: 'quotes/quote',
  #                        locals: { quote: self },
  #                        target: 'quotes'
  # end

  # after_create_commit -> { broadcast_prepend_later_to 'quotes' }
  # after_update_commit -> { broadcast_replace_later_to 'quotes' }
  # after_destroy_commit -> { broadcast_remove_to 'quotes' }

  # Those three callbacks are equivalent to the following single line
  broadcasts_to ->(quote) { [quote.company, 'quotes'] }, inserts_by: :prepend
end
