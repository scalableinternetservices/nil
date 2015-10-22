require 'test_helper'

class UserCustomersControllerTest < ActionController::TestCase
  setup do
    @user_customer = user_customers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_customers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_customer" do
    assert_difference('UserCustomer.count') do
      post :create, user_customer: { address: @user_customer.address, name: @user_customer.name, phone: @user_customer.phone, zipcode: @user_customer.zipcode }
    end

    assert_redirected_to user_customer_path(assigns(:user_customer))
  end

  test "should show user_customer" do
    get :show, id: @user_customer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_customer
    assert_response :success
  end

  test "should update user_customer" do
    patch :update, id: @user_customer, user_customer: { address: @user_customer.address, name: @user_customer.name, phone: @user_customer.phone, zipcode: @user_customer.zipcode }
    assert_redirected_to user_customer_path(assigns(:user_customer))
  end

  test "should destroy user_customer" do
    assert_difference('UserCustomer.count', -1) do
      delete :destroy, id: @user_customer
    end

    assert_redirected_to user_customers_path
  end
end
