# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id {1}
    full_name {'Zhicheng Zou'}
    uid {"zz3105"}
    email {"zz3105@columbia.edu"}
    password {"123456"}
  end
end