FactoryGirl.define do
  factory :notification do
    title "MyString"
    content "MyText"
    resolve_link "MyString"
    read false
    read_time "2017-08-09 02:32:21"
    user nil
  end
end
