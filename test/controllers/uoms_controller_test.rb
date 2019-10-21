require 'test_helper'

class UomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get uoms_index_url
    assert_response :success
  end

  test "should get show" do
    get uoms_show_url
    assert_response :success
  end

  test "should get new" do
    get uoms_new_url
    assert_response :success
  end

  test "should get edit" do
    get uoms_edit_url
    assert_response :success
  end

end
