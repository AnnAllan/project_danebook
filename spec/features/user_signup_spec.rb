require 'rails_helper'
feature 'User signup' do
  context "user is not signed in"
    before do
      visit(root_path)
    end

    scenario 'New user can submit valid info to sign up' do
      sign_up
      expect{ click_button('Sign Up') }.to change(User, :count).by(1)
    end

    scenario "Redirects to user profile edit page after creation" do
      sign_up
      click_button('Sign Up')
      user = User.find_by_email('firsttest@example.com')
      expect(current_path).to eq(edit_user_profile_path(user))
    end

    scenario "User not created if field left blank" do
      sign_up(email: nil)
      expect{ click_button('Sign Up') }.to change(User, :count).by(0)
    end
end

feature 'User sign in' do

  context "User exists"
    before do
      visit(root_path)
      sign_up
      click_button('Sign Up')
      sign_out
    end

    scenario "User can sign in" do
      sign_in
      user = User.find_by_email('firsttest@example.com')
      expect(current_path).to eq(user_profile_path(user.id))
    end

  context "User does not exist"
    scenario "Nonexistent user can't sign in" do
      visit(root_path)
      sign_in(email: "nonexistentemail@example.com")
      expect(current_path).to eq(root_path)
    end
end

feature 'Profile access' do
  context 'User logged in'
    before do
      visit(root_path)
      sign_up
      click_button('Sign Up')
      sign_out
      visit(root_path)
      sign_in
    end

    scenario 'User can access their own profile' do
      user = User.find_by_email('firsttest@example.com')
      visit(user_profile_path(user))
      expect(page).to have_content('Words to Live by')
    end

    scenario "User can access other users' profiles" do
      new_user = User.find_by_email('firsttest@example.com')
      visit(user_profile_path(new_user))
      expect(page).to have_content('Words to Live by')
    end
end

feature 'Editing profile' do
  context 'User logged in'
    before do
      visit(root_path)
      sign_up
      click_button('Sign Up')
      sign_out
      visit(root_path)
      sign_in
    end

    scenario 'User can see edit button on their own profile' do
      user = User.find_by_email('firsttest@example.com')
      visit(user_profile_path(user))
      expect(page).to have_content('Edit')
    end

    scenario 'User can edit their own profile' do
      user = User.find_by_email('firsttest@example.com')
      visit(user_profile_path(user))
      click_link('Edit')
      expect(current_path).to eq(edit_user_profile_path(user))
    end
end

feature 'Writing posts' do
  context 'User logged in'
    before do
      visit(root_path)
      sign_up
      click_button('Sign Up')
      sign_out
      visit(root_path)
      sign_in
    end

    # scenario 'User can write post on their own profile' do
    #   user = User.find_by_email('firsttest@example.com')
    #   visit(user_posts_path(user))
    #
    #   write_post
    #   expect(page).to have_content('I am a post')
    # end
end

#
#     scenario "User can write post on other users' profiles" do
#       new_user = User.find_by_email('foo@bar.com')
#       visit(user_posts_path(new_user))
#       write_post
#       click_button('Create Post')
#       expect(page).to have_content('This is a test post')
#     end
#
# feature 'Like/Unlike posts' do
#   context 'User logged in' do
#     before do
#       visit(root_path)
#       sign_up(email: 'bar@foo.com')
#       click_button('Create User')
#       log_out
#       visit(root_path)
#       sign_up
#       click_button('Create User')
#     end
#
#     scenario 'User can like post on their own profile' do
#       user = User.find_by_email('foo@bar.com')
#       visit(user_posts_path(user))
#       write_post
#       click_button('Create Post')
#       click_link('Like(0)')
#       expect(page).to have_content('Unlike(1)')
#     end
#
#     scenario 'User can unlike post on their own profile' do
#       user = User.find_by_email('foo@bar.com')
#       visit(user_posts_path(user))
#       write_post
#       click_button('Create Post')
#       click_link('Like(0)')
#       click_link('Unlike(1)')
#       expect(page).to have_content('Like(0)')
#     end
#   end
