FactoryBot.define do
  factory :user do
    email { 'testsample@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
