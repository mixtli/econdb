require 'test_helper'

class CurrenciesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:currencies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create currency" do
    assert_difference('Currency.count') do
      post :create, :currency => { }
    end

    assert_redirected_to currency_path(assigns(:currency))
  end

  test "should show currency" do
    get :show, :id => currencies(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => currencies(:one).to_param
    assert_response :success
  end

  test "should update currency" do
    put :update, :id => currencies(:one).to_param, :currency => { }
    assert_redirected_to currency_path(assigns(:currency))
  end

  test "should destroy currency" do
    assert_difference('Currency.count', -1) do
      delete :destroy, :id => currencies(:one).to_param
    end

    assert_redirected_to currencies_path
  end
end
