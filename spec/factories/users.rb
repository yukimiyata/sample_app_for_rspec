FactoryBot.define do
  factory :user do
    password { 'password' }
    password_confirmation { 'password' }
  end
end
