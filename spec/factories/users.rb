FactoryBot.define do
  factory :user do
    email { 'testsample@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
