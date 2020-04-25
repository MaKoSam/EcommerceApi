import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    let authController = AuthController()
    let infoController = UserInfoController()
    let addressController = UserAddressController()
    let admin = AdminController()
    let shop = ItemsController()
    
    router.group("admin"){ group in
        group.post("configure", use: admin.config) //Тестинг, Запускать для конфигурации стандартных размерой/категорий товаров
        group.post("add_item", use: admin.addItem)
    }
    
    router.group("auth"){ group in
        group.post("register", use: authController.register)
        group.post("sign_in", use: authController.signin)
        /*group.post("restore_password", use: authController.restorePassword)
        group.post("refresh_token", use: authController.refreshToken)*/
    }
    
    router.group("user"){ group in
        group.post("get", use: infoController.getInfo)
        group.post("update", use: infoController.updateInfo)
    }
    
    router.group("address"){ group in
        group.post("get", use: addressController.getAddress)
        group.post("update", use: addressController.updateAddress)
    }
    
    router.group("shop_items"){ group in
        group.post("get", use: shop.get)
        
    }
}
