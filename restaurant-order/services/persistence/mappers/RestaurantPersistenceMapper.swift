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
        restaurantPersistenceDto.name = restaurant.name
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
            menuItemPersistenceDto.name = menuItem.name
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
    
    static func toDomainModel(from restaurantPersistenceDtoOptional: RestaurantPersistenceDto?) -> Restaurant? {
        var restaurant: Restaurant? = nil
        
        if let restaurantPersistenceDto = restaurantPersistenceDtoOptional {
            restaurant = Restaurant()
            restaurant?.id = restaurantPersistenceDto.id
            restaurant?.name = restaurantPersistenceDto.name
            restaurant?.menu = toMenuDomainModel(from: restaurantPersistenceDto.menu)
        }
        
        return restaurant
    }
    
    private static func toMenuDomainModel(from menuPersistenceDtoOptional: MenuPersistenceDto?) -> Menu? {
        var menu: Menu? = nil
        
        if let menuPersistenceDto = menuPersistenceDtoOptional {
            menu = Menu()
            menu?.id = menuPersistenceDto.id
            
            let mappedCategories = menuPersistenceDto.categories.map(toCategoryDomainModel)
            
            var categories: [Category] = []
            
            mappedCategories.forEach { category in
                categories.append(category)
            }
            
            menu?.categories = categories
        }
        
        return menu
    }
    
    private static func toCategoryDomainModel(from categoryPersistenceDtoOptional: CategoryPersistenceDto?) -> Category {
        var category: Category = Category()
        
        if let categoryPersistenceDto = categoryPersistenceDtoOptional {
            category.id = categoryPersistenceDto.id
            category.name = categoryPersistenceDto.name
            
            let mappedMenuItems = categoryPersistenceDto.items.map(toMenuItemDomainModel)
            
            var menuItemArray: [MenuItem] = []
            
            mappedMenuItems.forEach { item in
                menuItemArray.append(item)
            }
            
            category.items = menuItemArray
        }
        
        return category
    }
    
    private static func toMenuItemDomainModel(from menuItemPersistenceDtoOptional: MenuItemPersistenceDto?) -> MenuItem {
        var menuItem = MenuItem()
        
        if let menuItemPersistenceDto = menuItemPersistenceDtoOptional {
            menuItem.id = menuItemPersistenceDto.id
            menuItem.category = menuItemPersistenceDto.category
            menuItem.name = menuItemPersistenceDto.name
            menuItem.quantity = menuItemPersistenceDto.quantity.value
            menuItem.quantityType = menuItemPersistenceDto.quantityType
            menuItem.price = toMoneyDomainModel(from: menuItemPersistenceDto.price)
        }
        
        return menuItem
    }
    
    private static func toMoneyDomainModel(from moneyPersistenceDtoOptional: MoneyPersistenceDto?) -> Money? {
        var money: Money? = nil
        
        if let moneyPersistenceDto = moneyPersistenceDtoOptional {
            money = Money()
            
            money?.value = moneyPersistenceDto.value
            money?.currency = moneyPersistenceDto.currency
        }
        
        return money
    }
}
