# frozen_string_literal: true

include ActionDispatch::TestProcess::FixtureFile
RSpec.describe DocumentsController, type: :controller do
  let!(:ssn_code) { create(:ssn_code, ssn: '1234', code: '54231') }
  let!(:user) { create(:user, ssn_code_id: ssn_code.id) }
  let!(:document) { create(:document, user_id: user.id) }

  before { sign_in(user) }

  describe 'GET #index' do
    context 'when user have documents' do
      subject { get :index }
      before { subject }

      it 'documents should not be empty' do
        expect(assigns(:documents)).not_to be_empty
      end

      it 'documents count should be 1' do
        expect(assigns(:documents).count).to eq(1)
      end

      it 'should be document' do
        expect(assigns(:documents).first).to eq(document)
      end
    end

    context 'when user dont have documents' do
      subject { get :index }
      before { subject; document.delete }

      it 'documents should not be empty' do
        expect(assigns(:documents)).to be_empty
      end

      it 'documents count should be 1' do
        expect(assigns(:documents).count).to eq(0)
      end
    end
  end

  describe 'GET #email_doc' do
    context 'when user have documents' do
      subject { get :email_doc, params: { id: document.id, email: 'salmantest@gmail.com' } }
      before { document.uploaded_file = fixture_file_upload(Rails.root.join('test/fixtures/test.pdf')); document.save; subject }

      it 'flash notice equals' do
        expect(flash[:success]).to match('Email has been sent successfully.')
      end
    end
  end

  describe 'GET #show' do
    context 'when user have documents' do
      subject { get :show, params: { id: document.id } }
      before { document.uploaded_file = fixture_file_upload(Rails.root.join('test/fixtures/test.pdf')); document.save; subject }

      it 'response content type should equal pdf' do
        response.header['Content-Type'].should eql('application/pdf')
      end
    end
  end

  describe 'POST #create' do
    context 'create document' do
      subject { post :create, params: { document: { year: 2017, file_format: 1, form_name: 1, file: fixture_file_upload(Rails.root.join('test/fixtures/test.pdf')) } } }
      before { subject }

      it '' do
        expect(assigns(:document))
      end
    end
  end

  describe 'GET #edit' do
    context 'edit document' do
      subject { get :edit, params: { id: document.id } }
      before { subject }

      it 'document id is equal to curent doc id' do
        expect(assigns(:document).id).to eq(document.id)
      end
    end
  end

  describe 'PUT #update' do
    context 'update document' do
      subject { post :update, params: { id: document.id, document: { year: 2018, file_format: 2, form_name: 2, file: fixture_file_upload(Rails.root.join('test/fixtures/test.pdf')) } } }
      before { subject }

      it 'document year to update' do
        expect(assigns(:document).year).to eq(2018)
      end

      it 'document year not eq to previous year' do
        expect(assigns(:document).year).not_to eq(2017)
      end

      it 'document file_format' do
        expect(assigns(:document).file_format).to eq(2)
      end

      it 'document form_name to update' do
        expect(assigns(:document).form_name).to eq(2)
      end
    end
  end
end
