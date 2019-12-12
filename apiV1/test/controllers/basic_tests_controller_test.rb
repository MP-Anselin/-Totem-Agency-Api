require 'test_helper'

class BasicTestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @basic_test = basic_tests(:one)
  end

  test "should get index" do
    get basic_tests_url, as: :json
    assert_response :success
  end

  test "should create basic_test" do
    assert_difference('BasicTest.count') do
      post basic_tests_url, params: { basic_test: { description: @basic_test.description, name: @basic_test.name } }, as: :json
    end

    assert_response 201
  end

  test "should show basic_test" do
    get basic_test_url(@basic_test), as: :json
    assert_response :success
  end

  test "should update basic_test" do
    patch basic_test_url(@basic_test), params: { basic_test: { description: @basic_test.description, name: @basic_test.name } }, as: :json
    assert_response 200
  end

  test "should destroy basic_test" do
    assert_difference('BasicTest.count', -1) do
      delete basic_test_url(@basic_test), as: :json
    end

    assert_response 204
  end
end
