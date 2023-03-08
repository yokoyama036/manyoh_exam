FactoryBot.define do
  factory :user do
    name { '横山' }
    email { '123456@gmail.com' }
    password { "123456" }
    password_confirmation { "123456" }
    admin { false }
  end
  factory :user2, class: User do
    name { '横川' }
    email { '222222@gmail.com' }
    password { "222222" }
    password_confirmation { "222222" }
    admin { true }
  end
end
