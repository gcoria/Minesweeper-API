FactoryBot.define do
  factory :game do
  	user factory: :user
    columns { 1 }
    rows { 1 }
    mines { 1 }
    state { 0 }
  end
end
