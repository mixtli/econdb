require 'test_helper'

class StockExchangesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stock_exchanges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stock_exchange" do
    assert_difference('StockExchange.count') do
      post :create, :stock_exchange => { }
    end

    assert_redirected_to stock_exchange_path(assigns(:stock_exchange))
  end

  test "should show stock_exchange" do
    get :show, :id => stock_exchanges(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => stock_exchanges(:one).to_param
    assert_response :success
  end

  test "should update stock_exchange" do
    put :update, :id => stock_exchanges(:one).to_param, :stock_exchange => { }
    assert_redirected_to stock_exchange_path(assigns(:stock_exchange))
  end

  test "should destroy stock_exchange" do
    assert_difference('StockExchange.count', -1) do
      delete :destroy, :id => stock_exchanges(:one).to_param
    end

    assert_redirected_to stock_exchanges_path
  end
end
