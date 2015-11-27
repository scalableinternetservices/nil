module FoodsHelper
    def cache_key_for_food_row_customer(food)
        "food-#{food.id}-#{food.updated_at}"
    end
    def cache_key_for_food_row_restaurant(food)
        "food-#{food.id}-#{food.updated_at}"
    end
    def cache_key_for_foods_table_customer(restaurant)
        "foods-table-#{restaurant.id}-#{restaurant.foods.maximum(:updated_at)}"
    end
    def cache_key_for_foods_table_restaurant(restaurant)
        "foods-table-#{restaurant.id}-#{restaurant.foods.maximum(:updated_at)}"
    end
    def cache_key_for_food_detail(food)
        "foods-detail-#{food.id}-#{food.updated_at}"
    end
end
