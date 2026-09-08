require "test_helper"

class NovinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @novine = novines(:one)
  end

  test "should get index" do
    get novines_url
    assert_response :success
  end

  test "should get new" do
    get new_novine_url
    assert_response :success
  end

  test "should create novine" do
    assert_difference("Novine.count") do
      post novines_url, params: { novine: { name: @novine.name, publish: @novine.publish, title: @novine.title, user_id: @novine.user_id } }
    end

    assert_redirected_to novine_url(Novine.last)
  end

  test "should show novine" do
    get novine_url(@novine)
    assert_response :success
  end

  test "should get edit" do
    get edit_novine_url(@novine)
    assert_response :success
  end

  test "should update novine" do
    patch novine_url(@novine), params: { novine: { name: @novine.name, publish: @novine.publish, title: @novine.title, user_id: @novine.user_id } }
    assert_redirected_to novine_url(@novine)
  end

  test "should destroy novine" do
    assert_difference("Novine.count", -1) do
      delete novine_url(@novine)
    end

    assert_redirected_to novines_url
  end
end
