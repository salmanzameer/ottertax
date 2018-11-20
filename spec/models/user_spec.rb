# frozen_string_literal: true

RSpec.describe User, type: :model do
  let!(:ssn_code) { create(:ssn_code, ssn: '1234', code: '54231') }
  let!(:user) { create(:user, ssn_code_id: ssn_code.id, first_name: 'Salman', last_name: 'Zameer') }

  describe '#full_name' do
    subject { user.full_name }

    context 'when user is present' do
      it 'user full name is' do
        expect(subject).to eq('Salman Zameer')
      end
    end
  end
end
