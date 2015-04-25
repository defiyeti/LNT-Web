require 'test_helper'

class StatsControllerTest < ActionController::TestCase
  setup do
    @stat = stats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stat" do
    assert_difference('Stat.count') do
      post :create, stat: { electricity_usage: @stat.electricity_usage, id: @stat.id, month: @stat.month, natural_gas_usage: @stat.natural_gas_usage, user_id: @stat.user_id, water_usage: @stat.water_usage, year: @stat.year }
    end

    assert_redirected_to stat_path(assigns(:stat))
  end

  test "should show stat" do
    get :show, id: @stat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stat
    assert_response :success
  end

  test "should update stat" do
    patch :update, id: @stat, stat: { electricity_usage: @stat.electricity_usage, id: @stat.id, month: @stat.month, natural_gas_usage: @stat.natural_gas_usage, user_id: @stat.user_id, water_usage: @stat.water_usage, year: @stat.year }
    assert_redirected_to stat_path(assigns(:stat))
  end

  test "should destroy stat" do
    assert_difference('Stat.count', -1) do
      delete :destroy, id: @stat
    end

    assert_redirected_to stats_path
  end
end
