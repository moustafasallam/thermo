FactoryBot.define do
  factory :thermostat do
  	id						    { rand(1234567..9999999) }
    location          {Faker::Address.full_address}
    created_at        {Time.now}
    updated_at        {Time.now}

    ################# with readings ################
    trait :with_readings do
      after(:create) do |thermo, evaluator|
        create_list(:reading, 10, thermostat: thermo)
      end
    end
  end
end