# frozen_string_literal: true

include ActionDispatch::TestProcess::FixtureFile
RSpec.describe Document do
  let!(:ssn_code) { create(:ssn_code, ssn: '1234', code: '54231') }
  let!(:user) { create(:user, ssn_code_id: ssn_code.id) }
  let!(:document) { create(:document, user_id: user.id) }

  describe '#uploaded_file' do
    subject { document.uploaded_file = fixture_file_upload(Rails.root.join('test/fixtures/test.pdf')) }

    context 'when file is present' do
      it 'should return test.pdf' do
        subject
        expect(document.filename).to eq('test.pdf')
      end
    end
  end

  describe '#encrypt' do
    subject { document.send(:encrypt, fixture_file_upload(Rails.root.join('test/fixtures/test.pdf')).read) }

    context 'when file is present' do
      it 'should not be nil' do
        expect(subject).not_to be_nil
      end
    end
  end

  describe '#decrypt' do
    subject do
      document.uploaded_file = fixture_file_upload(Rails.root.join('test/fixtures/test.pdf'))
      document.save
      document.send(:decrypt, document.file_contents)
    end

    context 'when file is present' do
      it 'should not be nil' do
        expect(subject).not_to be_nil
      end
    end
  end
end
