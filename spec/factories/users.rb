FactoryBot.define do
  factory :user do
  	sequence(:username) {|n| "user#{n}"}
    password {"123456"}
  end
end
