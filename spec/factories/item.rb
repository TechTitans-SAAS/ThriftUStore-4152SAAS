# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    id {1}
    title {'item1'}
    detail {'this is detail about item1'}
    price {2}
    user


    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('spec', 'features', 'files', 'image.jpeg')), filename: 'image.jpeg', content_type: 'image/jpeg')

    end


  end
end