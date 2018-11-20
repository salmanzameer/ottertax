# frozen_string_literal: true

RSpec.describe Users::RegistrationsController, type: :controller do
  let!(:ssn_code) { create(:ssn_code, ssn: '1234', code: '54231') }
  let!(:user) { create(:user, ssn_code_id: ssn_code.id) }

  describe '#after_update_path_for' do
    subject { Users::RegistrationsController.new.send(:after_update_path_for, user) }

    context 'when resource is present' do
      it 'will return document path' do
        
      end
    end
  end
end