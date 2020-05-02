import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    let authController = AuthController()
    let infoController = UserInfoController()
    let addressController = UserAddressController()
    let admin = AdminController()
    let shop = ItemsController()
    let color = ColorController()
    let size = SizeController()
    let category = CategoryController()
    
    router.group("admin"){ group in
        group.post("configure", use: admin.config) //Тестинг, Запускать для конфигурации стандартных размерой/категорий товаров
        group.post("add_item", use: admin.addItem)
    }
    
    router.group("auth"){ group in
        group.post("register", use: authController.register)
        group.post("sign_in", use: authController.signin)
//        group.post("restore_password", use: authController.restorePassword)
        group.post("refresh_token", use: authController.refreshToken)
    }
    
    router.group("user"){ group in
        group.post("get", use: infoController.getInfo)
        group.post("update", use: infoController.updateInfo)
    }
    
    router.group("address"){ group in
        group.post("get", use: addressController.getAddress)
        group.post("update", use: addressController.updateAddress)
    }
    
    router.group("shop"){ group in
        group.post("get_items", use: shop.get)
        group.post("get_category", use: category.get)
        group.post("get_size", use: size.get)
        group.post("get_color", use: color.get)
    }
}
