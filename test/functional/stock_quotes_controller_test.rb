require 'test_helper'

class StockQuotesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stock_quotes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stock_quote" do
    assert_difference('StockQuote.count') do
      post :create, :stock_quote => { }
    end

    assert_redirected_to stock_quote_path(assigns(:stock_quote))
  end

  test "should show stock_quote" do
    get :show, :id => stock_quotes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => stock_quotes(:one).to_param
    assert_response :success
  end

  test "should update stock_quote" do
    put :update, :id => stock_quotes(:one).to_param, :stock_quote => { }
    assert_redirected_to stock_quote_path(assigns(:stock_quote))
  end

  test "should destroy stock_quote" do
    assert_difference('StockQuote.count', -1) do
      delete :destroy, :id => stock_quotes(:one).to_param
    end

    assert_redirected_to stock_quotes_path
  end
end
