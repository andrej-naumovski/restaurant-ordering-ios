//
//  RestaurantPersistenceMapper.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/26/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

class RestaurantPersistenceMapper {
    static func toPersistenceDto(from restaurant: Restaurant) -> RestaurantPersistenceDto {
        let restaurantPersistenceDto = RestaurantPersistenceDto()
        
        restaurantPersistenceDto.id = restaurant.id
        restaurantPersistenceDto.menu = toMenuPersistenceDto(from: restaurant.menu)
        
        return restaurantPersistenceDto
    }
    
    private static func toMenuPersistenceDto(from menuOptional: Menu?) -> MenuPersistenceDto {
        let menuPersistenceDto = MenuPersistenceDto()
        
        if let menu = menuOptional {
            menuPersistenceDto.id = menu.id
            let categoryPersistenceDtos = menu.categories?.map(toCategoryPersistenceDto)
            categoryPersistenceDtos?.forEach { category in
                menuPersistenceDto.categories.append(category)
            }
        }
        
        return menuPersistenceDto
    }
    
    private static func toCategoryPersistenceDto(from categoryOptional: Category?) -> CategoryPersistenceDto {
        let categoryPersistenceDto = CategoryPersistenceDto()
        
        if let category = categoryOptional {
            categoryPersistenceDto.id = category.id
            categoryPersistenceDto.name = category.name
            
            let menuItemPersistenceDtos = category.items?.map(toMenuItemPersistenceDto)
            
            menuItemPersistenceDtos?.forEach { menuItem in
                categoryPersistenceDto.items.append(menuItem)
            }
        }
        
        return categoryPersistenceDto
    }
    
    private static func toMenuItemPersistenceDto(from menuItemOptional: MenuItem?) -> MenuItemPersistenceDto {
        let menuItemPersistenceDto = MenuItemPersistenceDto()
        if let menuItem = menuItemOptional {
            menuItemPersistenceDto.id = menuItem.id
            menuItemPersistenceDto.category = menuItem.category
            menuItemPersistenceDto.price = toMoneyPersistenceDto(from: menuItem.price)
            menuItemPersistenceDto.quantity.value = menuItem.quantity
            menuItemPersistenceDto.quantityType = menuItem.quantityType
        }
        
        return menuItemPersistenceDto
    }
    
    private static func toMoneyPersistenceDto(from moneyOptional: Money?) -> MoneyPersistenceDto {
        let moneyPersistenceDto = MoneyPersistenceDto()
        if let money = moneyOptional {
            moneyPersistenceDto.value = money.value
            moneyPersistenceDto.currency = money.currency
        }
        
        return moneyPersistenceDto
    }
}
