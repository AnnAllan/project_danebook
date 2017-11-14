require 'rails_helper'

FactoryGirl.define do

  factory :user do
    sequence(:first_name){ |n| "First#{n}"}
    email     { "#{first_name}@example.com"}
    last_name "Last"
    password  "password"
    password_confirmation "password"
    dob   {Date.parse('06-06-1996')}
  end

  factory :post_like, class: "Like" do
    association :likable, :factory => :post
  end

  factory :comment_like, class: "Like" do
    association :likable, :factory => :post_comment
  end

  factory :post_comment, class: "Comment" do
    association :commentable, :factory => :post
    content sequence(:content){ |n| "Post comment body#{n}"}
    user
  end


  factory :post do
    content sequence(:content){ |n| "Post body#{n}"}
    user
  end

  factory :profile do
    college     "Penn State"
    hometown    "Pittsburgh"
    location    "Undisclosed"
    phone       "111-111-1111"
    motto       "Don't let the sound of your own wheels drive you crazy"
    about       "I was born a poor black child..."
    gender      "female"
    user
  end

end
