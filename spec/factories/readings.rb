FactoryBot.define do
  factory :reading do
  	id						    { rand(1234567..9999999) }
  	number				    {0}
    temperature       {rand(-55.5..55.5)}
    humidity          {rand(0.0..120.5)}
    battery_charge    {rand(0.0..100.0)}
    created_at        {Time.now}
    updated_at        {Time.now}

    association  :thermostat, factory: :thermostat

    before(:create) do |reading, evaluator|
      evaluator.thermostat.counter += 1
      reading.number = evaluator.thermostat.counter
    end

  end
end