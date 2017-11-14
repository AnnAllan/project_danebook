require 'rails_helper'
require 'support/factory_girl'

describe Post do

  let(:post){build(:post)}

  it "is valid with valid inputs" do
    expect(post).to be_valid
  end

  it "must have a user_id" do
    post = build(:post, user_id: nil)
    expect(post).to_not be_valid
  end

  it "must have content between 1 and 1000 characters" do
    post = build(:post, content: "")
    expect(post).to_not be_valid

    post = build(:post, content: "")
    expect(post).to_not be_valid

    post = build(:post, content: "long"* 251)
    expect(post).to_not be_valid
  end


end
