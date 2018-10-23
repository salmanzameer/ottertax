RSpec.describe VerificationsController, type: :controller do
  let!(:ssn_code) { create(:ssn_code, ssn: '1234', code: '54231') }

  describe 'GET #verify' do
    context 'when ssn and code does not match' do
      subject { get :verify, xhr: true, params: { ssn: '2244', code: '12543' } }
      before { subject }

      it 'status should be 404' do
        expect(JSON.parse(response.body)["status"]).to eq(404)
      end
    end

    context 'when ssn and code does match' do
      subject { get :verify, xhr: true, params: { ssn: '1234', code: '54231' } }
      before { subject }

      it 'status should be 400' do
        expect(JSON.parse(response.body)["status"]).to eq(400)
      end

      it 'should return token' do
        expect(JSON.parse(response.body)["token"]).not_to be_nil 
      end
    end
  end

  describe 'GET #invite' do
    context 'when session token does not match with param token' do
      subject { get :invite, params: { auth_token: '1s2w12' }, session: { verification_token: '1sdewd12edw' } }
      before { subject }

      it 'flash notice equals' do
        expect(flash[:notice]).to match('Please verify you ssn and security code.')
      end
    end

    context 'when session token does match with param token' do
      subject { get :invite, params: { auth_token: '1s2w12' }, session: { verification_token: '1s2w12' } }
      before { subject }

      it 'flash notice to be nil' do
        expect(flash[:notice]).to be_nil
      end
    end
  end

  describe 'GET #send_invite' do
    context 'when session token does not match with param token' do
      subject { post :send_invite, params: { auth_token: '1s2w12' }, session: { verification_token: '1sdewd12edw' } }
      before { subject }

      it 'flash notice equals' do
        expect(flash[:notice]).to match('Please verify you ssn and security code.')
      end
    end

    context 'when session token does match with param token' do
      subject { post :send_invite, params: { auth_token: '1s2w12' }, session: { verification_token: '1s2w12' } }
      before { subject }

      it 'flash notice to be nil' do
        expect(flash[:notice]).to be_nil
      end
    end
  end
end
