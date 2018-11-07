# frozen_string_literal: true

RSpec.feature 'User Verification', js: true do
  let!(:ssn_code)  { create(:ssn_code, ssn: '1234', code: 'asdfg') }
  let!(:ssn_code1) { create(:ssn_code, ssn: '1212', code: 'sdfgh') }
  let!(:user)      { create(:user, email: 'salman@gmail.com', ssn_code_id: ssn_code1.id) }

  describe 'verify user ssn and code' do
    context 'When user have valid credentials' do
      scenario 'Fill verification form' do
        visit '/register'

        fill_in 'Last 4 digits of SSN', with: '1234'
        fill_in '5 character access code', with: 'asdfg'
        click_on('Register')
        expect(page).to have_content 'Register: Enter your email'
      end
    end

    context 'When user dont have valid credentials' do
      before { user }
      scenario 'Fill verification form' do
        visit '/register'

        fill_in 'Last 4 digits of SSN', with: '1212'
        fill_in '5 character access code', with: 'sdfgh'
        click_on('Register')
        expect(page).to have_content 'The information you entered does not match our records. Please try again.'
      end
    end
  end

  describe 'invite user with email' do
    context 'enter valid email and confirm email' do
      scenario 'Fill verification form' do
        visit '/register'

        fill_in 'Last 4 digits of SSN', with: '1234'
        fill_in '5 character access code', with: 'asdfg'
        click_on('Register')

        fill_in 'Email', with: 'salman1@gmail.com'
        fill_in 'Confirm Email', with: 'salman1@gmail.com'

        click_on('Register')
        expect(page).to have_current_path(user_session_path)
      end
    end

    context 'enter already used email address' do
      scenario 'Fill verification form' do
        visit '/register'

        fill_in 'Last 4 digits of SSN', with: '1234'
        fill_in '5 character access code', with: 'asdfg'
        click_on('Register')

        fill_in 'Email', with: 'salman@gmail.com'
        fill_in 'Confirm Email', with: 'salman@gmail.com'

        click_on('Register')
        expect(page).to have_content 'User with this email already present.'
      end
    end
  end
end
