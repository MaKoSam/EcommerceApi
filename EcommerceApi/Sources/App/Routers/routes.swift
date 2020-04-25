import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    let authController = AuthController()
    let infoController = UserInfoController()
    let addressController = UserAddressController()
    
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
}
