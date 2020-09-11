FactoryBot.define do
  factory :cell do
    game factory: :game
    x_axis { 1 }
    y_axis { 1 }
    mines_around { 1 }
    state { 0 }
  end
end
