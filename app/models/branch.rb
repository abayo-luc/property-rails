class Branch < ActiveRecord::Base
  # Relations
  belongs_to :agent
  has_many :listing
  # Validations
  validates :agent, presence: true
  validates :name, presence: true, length: { maximum:50}
  validates :address_1, presence: true, length: { maximum:50}
  validates :address_2, length: { maximum:50}
  validates :address_3, length: { maximum:50}
  validates :address_4, length: { maximum:50}
  validates :town_city, presence: true, length: { in: 3..50 }
  validates :county, presence: true, length: { in: 3..50 }
  validates :postcode, presence: true, length: { in: 7..10 }
  validates :country, presence: true, length: { in: 3..50 }
  validates :display_address, presence: true, length: { in: 3..200 }
  validates :status, presence: true, numericality: { only_integer: true }

  #Geocoder
  geocoded_by :postcode
  after_validation :geocode

  # Scopes
  def self.belongs_to_current_user(current_user)
    self.joins(:agent).where(
      'agents.user_id = ?', current_user.id
    )
  end

  def self.belongs_to_agent(id)
    self.where('branches.agent_id = ?', id)
  end
  # Functions
  nilify_blanks :types => [:text]
end
