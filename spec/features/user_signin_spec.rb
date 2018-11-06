RSpec.feature 'User Sign In', js: true do
  let!(:ssn_code) { create(:ssn_code, ssn: '1234', code: '54231') }
  let!(:user)     { create(:user, email: 'salman@gmail.com', ssn_code_id: ssn_code.id) }
  
  context 'When user have valid credentials' do
    before { user }
    scenario 'Fill signin page for user' do
      visit 'users/sign_in'

      fill_in 'Email Address', with: 'salman@gmail.com'
      fill_in 'Password', with: 'password'
      click_on('Log in')
      expect(page).to have_current_path(documents_path)
    end
  end

  context 'When user dont have email credentials' do
    before { user }
    scenario 'Fill signin page for user' do
      visit 'users/sign_in'

      fill_in 'Email Address', with: 'salman1@gmail.com'
      fill_in 'Password', with: 'password3'
      click_on('Log in')
      expect(page).to have_content 'Invalid Email or password.'
    end
  end
end
