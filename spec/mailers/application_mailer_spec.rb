# frozen_string_literal: true

include ActionDispatch::TestProcess::FixtureFile
RSpec.describe ApplicationMailer do
  let!(:ssn_code) { create(:ssn_code, ssn: '1234', code: '54231') }
  let!(:user) { create(:user, ssn_code_id: ssn_code.id) }
  let!(:document) { create(:document, user_id: user.id) }

  describe '#send_document' do
    before { document.uploaded_file = fixture_file_upload(Rails.root.join('test/fixtures/test.pdf')) }
    subject { ApplicationMailer.send_document(document, 'salman@xoho.tech').deliver }

    context 'send email' do
      it 'it will send email' do
        subject
      end
    end
  end
end
