FactoryBot.define do
  factory :game do
  	user factory: :user
    columns { 3 }
    rows { 3 }
    mines { 5 }
    state { 0 }
  end
end
