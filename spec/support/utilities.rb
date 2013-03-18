module SessionMacros

  def sign_in(user)
    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end

  def toggle_mobile
    visit root_path
    click_link "toggle_mobile"
  end

  def add_part(part)
    toggle_mobile
    sign_in(@user)
    click_link "Parts"
    fill_in "Part Name", with: part
    click_button "Add Part"
  end

  def build_workorder(user)

  end

end
