require 'test_helper'

class UtilityTipsControllerTest < ActionController::TestCase
  setup do
    @utility_tip = utility_tips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:utility_tips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create utility_tip" do
    assert_difference('UtilityTip.count') do
      post :create, utility_tip: { id: @utility_tip.id, order: @utility_tip.order, text: @utility_tip.text }
    end

    assert_redirected_to utility_tip_path(assigns(:utility_tip))
  end

  test "should show utility_tip" do
    get :show, id: @utility_tip
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @utility_tip
    assert_response :success
  end

  test "should update utility_tip" do
    patch :update, id: @utility_tip, utility_tip: { id: @utility_tip.id, order: @utility_tip.order, text: @utility_tip.text }
    assert_redirected_to utility_tip_path(assigns(:utility_tip))
  end

  test "should destroy utility_tip" do
    assert_difference('UtilityTip.count', -1) do
      delete :destroy, id: @utility_tip
    end

    assert_redirected_to utility_tips_path
  end
end
