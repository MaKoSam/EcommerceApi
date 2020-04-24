import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    let authController = AuthController()
    
    router.group("auth"){ group in
        group.post("register", use: authController.register)
        group.post("sign_in", use: authController.signin)
        /*group.post("restore_password", use: authController.restorePassword)
        group.post("refresh_token", use: authController.refreshToken)*/
    }
}
