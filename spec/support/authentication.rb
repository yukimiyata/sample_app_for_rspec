module AuthenticationForFeatureRequest
  def login user, password = 'password'

    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: password
    click_button 'Login'

    visit user_path(user)
  end
end