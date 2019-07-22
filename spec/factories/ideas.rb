FactoryBot.define do
  factory :idea do
    title {Faker::Hacker.say_something_smart}
    body {Faker::Hipster.paragraph(2, true, 4)}
  end
end
