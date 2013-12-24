require 'test_helper'

class GrumpsControllerTest < ActionController::TestCase
  setup do
    @grump = grumps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grumps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grump" do
    assert_difference('Grump.count') do
      post :create, grump: { name: @grump.name, published_at: @grump.published_at }
    end

    assert_redirected_to grump_path(assigns(:grump))
  end

  test "should show grump" do
    get :show, id: @grump
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @grump
    assert_response :success
  end

  test "should update grump" do
    patch :update, id: @grump, grump: { name: @grump.name, published_at: @grump.published_at }
    assert_redirected_to grump_path(assigns(:grump))
  end

  test "should destroy grump" do
    assert_difference('Grump.count', -1) do
      delete :destroy, id: @grump
    end

    assert_redirected_to grumps_path
  end
end
