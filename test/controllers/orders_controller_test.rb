require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { address: @order.address, arrived: @order.arrived, arrived_at: @order.arrived_at, assigned: @order.assigned, confirmed_at: @order.confirmed_at, customer_id: @order.customer_id, paid: @order.paid, phone: @order.phone, price: @order.price, ready: @order.ready, restaurant_id: @order.restaurant_id, shipped_at: @order.shipped_at, zip: @order.zip }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order, order: { address: @order.address, arrived: @order.arrived, arrived_at: @order.arrived_at, assigned: @order.assigned, confirmed_at: @order.confirmed_at, customer_id: @order.customer_id, paid: @order.paid, phone: @order.phone, price: @order.price, ready: @order.ready, restaurant_id: @order.restaurant_id, shipped_at: @order.shipped_at, zip: @order.zip }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
