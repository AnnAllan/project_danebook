module LoginMacros

  def sign_up(first_name:   'Firsttest',
              last_name:    'Lasttest',
              email:        'firsttest@example.com',
              password:     'password',
              confirmation: 'password',
              day:          '23',
              month:        '8',
              year:         '1988')
    within("#signup") do
      fill_in 'First name', with: first_name
      fill_in 'Last name', with: last_name
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: confirmation
      select(day, from: 'Day')
      select(month, from: 'Month')
      select(year, from: 'Year')
    end
  end

  def sign_up_another(first_name:   'Firsttest2',
              last_name:    'Lasttest2',
              email:        'firsttest2@example.com',
              password:     'password',
              confirmation: 'password',
              day:          '24',
              month:        '8',
              year:         '1988')
    within("#signup") do
      fill_in 'First name', with: first_name
      fill_in 'Last name', with: last_name
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: confirmation
      select(day, from: 'Day')
      select(month, from: 'Month')
      select(year, from: 'Year')
    end
  end

  def sign_in(email: 'firsttest@example.com',
               password: 'password')
    visit root_path
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_button "Sign in"
  end

  def sign_out
    click_link "Logout"
  end

  def write_post(content: 'I am a post',
                  user_id: 1)
    fill_in 'content', with: content
    fill_in 'user_id', with: user_id
    click_button "Post"
  end


end
