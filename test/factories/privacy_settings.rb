FactoryGirl.define do
  factory :privacy_setting do
    user nil
    presence false
    phone_number false
    address ""
    email ""
    dob ""
    created_at false
  end
end
