FactoryBot.define do
  factory :user do
    email { 'testsample1@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
