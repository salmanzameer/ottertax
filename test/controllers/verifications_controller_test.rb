# frozen_string_literal: true

require 'test_helper'

class VerificationsControllerTest < ActionDispatch::IntegrationTest
  test 'should get verify' do
    get verifications_verify_url
    assert_response :success
  end

  test 'should get invite' do
    get verifications_invite_url
    assert_response :success
  end
end
