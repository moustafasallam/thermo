class Thermostat < ApplicationRecord

  has_many :readings, dependent: :destroy

  validates :household_token, presence: true
  validates :household_token, uniqueness: { case_sensitive: false }

  before_validation :generate_household_token, if: :is_new_record

  def is_new_record
    self.new_record?
  end

  def generate_household_token
    self.household_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(household_token: random_token)
    end
  end

  def update_counter
    self.with_lock do
      self.counter += 1
      self.save!
    end
    self.counter
  end

  def fetch_stats
    Reading.select("
      AVG(temperature) as avg_temperature, MAX(temperature) as max_temperature, MIN(temperature) as min_temperature,
      AVG(humidity) as avg_humidity, MAX(humidity) as max_humidity, MIN(humidity) as min_humidity,
      AVG(battery_charge) as avg_battery_charge, MAX(battery_charge) as max_battery_charge, MIN(battery_charge) as min_battery_charge,
      COUNT(id) as total_count
      ").group("thermostat_id").where(thermostat_id: self.id)
  end


end
