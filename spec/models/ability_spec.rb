# frozen_string_literal: true

RSpec.describe Ability do
  let!(:ssn_code) { create(:ssn_code, ssn: '1234', code: '54231') }
  let!(:user) { create(:user, ssn_code_id: ssn_code.id) }
  
  describe '#initialize' do
    subject { Ability.new(user) }

    context 'user present' do
      it 'should return class' do
        expect(subject.class).to eq(Ability)
      end
    end
  end
end
