module RestaurantsHelper
    def cache_key_for_restaurant(restaurant)
    "restaurant-#{restaurant.id}-#{restaurant.updated_at}-#{restaurant.comments.count}"
    end
    def cache_key_for_restaurants_table
    "restaurants-table-#{Restaurant.maximum(:updated_at)}-#{Comment.maximum(:updated_at)}"
    end
end
