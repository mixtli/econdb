require 'test_helper'

class DataSourceTemplatesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:data_source_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create data_source_template" do
    assert_difference('DataSourceTemplate.count') do
      post :create, :data_source_template => { }
    end

    assert_redirected_to data_source_template_path(assigns(:data_source_template))
  end

  test "should show data_source_template" do
    get :show, :id => data_source_templates(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => data_source_templates(:one).to_param
    assert_response :success
  end

  test "should update data_source_template" do
    put :update, :id => data_source_templates(:one).to_param, :data_source_template => { }
    assert_redirected_to data_source_template_path(assigns(:data_source_template))
  end

  test "should destroy data_source_template" do
    assert_difference('DataSourceTemplate.count', -1) do
      delete :destroy, :id => data_source_templates(:one).to_param
    end

    assert_redirected_to data_source_templates_path
  end
end
