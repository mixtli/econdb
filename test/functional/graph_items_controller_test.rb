require 'test_helper'

class GraphItemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:graph_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create graph_item" do
    assert_difference('GraphItem.count') do
      post :create, :graph_item => { }
    end

    assert_redirected_to graph_item_path(assigns(:graph_item))
  end

  test "should show graph_item" do
    get :show, :id => graph_items(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => graph_items(:one).to_param
    assert_response :success
  end

  test "should update graph_item" do
    put :update, :id => graph_items(:one).to_param, :graph_item => { }
    assert_redirected_to graph_item_path(assigns(:graph_item))
  end

  test "should destroy graph_item" do
    assert_difference('GraphItem.count', -1) do
      delete :destroy, :id => graph_items(:one).to_param
    end

    assert_redirected_to graph_items_path
  end
end
