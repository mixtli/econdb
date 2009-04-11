require 'test_helper'

class DataSourcesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:data_sources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create data_source" do
    assert_difference('DataSource.count') do
      post :create, :data_source => { }
    end

    assert_redirected_to data_source_path(assigns(:data_source))
  end

  test "should show data_source" do
    get :show, :id => data_sources(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => data_sources(:one).to_param
    assert_response :success
  end

  test "should update data_source" do
    put :update, :id => data_sources(:one).to_param, :data_source => { }
    assert_redirected_to data_source_path(assigns(:data_source))
  end

  test "should destroy data_source" do
    assert_difference('DataSource.count', -1) do
      delete :destroy, :id => data_sources(:one).to_param
    end

    assert_redirected_to data_sources_path
  end
end
