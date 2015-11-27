module FoodsHelper
    def cache_key_for_food(food)
        "food-#{food.id}-#{food.updated_at}"
    end
    def cache_key_for_foods_table(restaurant)
        "foods-table-#{restaurant.foods.maximum(:updated_at)}"
    end
    def cache_key_for_food_detail(food)
        "foods-detail-#{food.id}-#{food.updated_at}"
    end
end
