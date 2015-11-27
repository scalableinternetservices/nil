module OrdersHelper
    def cache_key_for_order_row_restaurant(order)
        "order-#{order.id}-#{order.updated_at}"
    end
    def cache_key_for_orders_table_shipper
       "orders-table-#{Order.where(ready:true).count}" 
    end
    def cache_key_for_order_row_shipper(order)
        "order-#{order.id}-#{order.updated_at}"
    end
end
