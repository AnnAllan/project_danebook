require 'rails_helper'
require 'support/factory_girl'

describe User do

  let(:user){build(:user)}


  it "is valid with proper inputs" do
    expect(user).to be_valid
  end

  context "associations" do
    # it "creates a profile" do
    #   user.save
    #   expect(user).to receive(:profile)
    #   user.profile
    # end

    # it "cannot have more than one profile" do
    #   user.save
    #   new_profile = build(:profile)
    #   expect{user.profile << new_profile}.to raise_error
    # end

    it "creates a token" do
      user.save
      expect(user.auth_token).to be_truthy
    end

    it "cannot have duplicate tokens" do
      user.save
      token = user.auth_token
      new_user = build(:user, auth_token: token)
      new_user.save
      expect(new_user.auth_token).to_not eq(token)
    end

    it "can have many posts" do
      user.posts = create_list(:post, 5)
      user.save
      expect(user.posts.count).to eq(5)
    end
  end

  context "first name" do

    it "is invalid without a first name" do
      user = build(:user, first_name: nil)
      expect(user).to_not be_valid
    end

    it "has a first name between 1 and 30 letters" do
      user = build(:user, first_name: "")
      expect(user).to_not be_valid

      user = build(:user, first_name: "firstnameiswaytoooooooooooooooooooolong")
      expect(user).to_not be_valid

      user = build(:user, first_name: "  ")
      expect(user).to_not be_valid

      user = build(:user, first_name: "1238")
      expect(user).to_not be_valid
    end
  end

  context "last name" do
    it "is invalid without a last name" do
      user = build(:user, last_name: nil)
      expect(user).to_not be_valid
    end

    it "has a last name between 1 and 30 letters" do
      user = build(:user, last_name: "")
      expect(user).to_not be_valid

      user = build(:user, last_name: "lastnameiswaytoooooooooooooooooooolong")
      expect(user).to_not be_valid

      user = build(:user, last_name: "  ")
      expect(user).to_not be_valid

      user = build(:user, last_name: "1238")
      expect(user).to_not be_valid
    end
  end

  context "email" do

    it "is invalid without an email" do
      user = build(:user, email: nil)
      expect(user).to_not be_valid
    end

    it "must be unique" do
      user = build(:user, email: "me@example.com")
      user.save
      new_user = build(:user, first_name: "first", last_name: "last",
                        email: "me@example.com", password: "password",
                        password_confirmation: "password")

      expect(new_user).to_not be_valid
    end

    it "is invalid if email input doesn't have '@'" do
      user = build(:user, email: "me.example.com")
      expect(user).to_not be_valid
    end
  end

  context "password" do

    it "has password length between 8 and 25 characters" do
      str = "short"
      user = build(:user, password: str, password_confirmation: str)
      expect(user).to_not be_valid

      str= "lastnameiswaytoooooooooooooooooooolong"
      user = build(:user, password: str, password_confirmation: str)
      expect(user).to_not be_valid
    end

    it "should have matching password and password confirmation" do
      user = build(:user, password: "password", password_confirmation: "notpassword")
      expect(user).to_not be_valid
    end
  end

  context "methods" do
    it "responds to full_name method" do
      expect{user.full_name}.to_not raise_error
    end
  end
end
