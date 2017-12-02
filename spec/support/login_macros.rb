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

  def sign_in(user)
    visit root_path
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button "Sign in"
  end

  def sign_out
    click_link "Logout"
  end

  

end
