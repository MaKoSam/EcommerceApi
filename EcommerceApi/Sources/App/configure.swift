import Vapor
import FluentPostgreSQL
import PostgreSQL
import Authentication

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    try services.register(FluentPostgreSQLProvider())
    try services.register(AuthenticationProvider())
    
    let router = EngineRouter.default()
    try routes(router)
    
    var middleware = MiddlewareConfig()
    middleware.use(FileMiddleware.self)
    middleware.use(ErrorMiddleware.self)
    
    
    let pgConfig = PostgreSQLDatabaseConfig(hostname: "127.0.0.1",
                                            port: 5432,
                                            username: "postgres",
                                            database: "Ecommerce",
                                            password: "MaznikerProperty1",
                                            transport: .cleartext)
    let pgConnection = PostgreSQLDatabase(config: pgConfig)
    
    var database = DatabaseConfig()
    database.add(database: pgConnection, as: .psql)
    database.enableLogging(on: .psql)
    
    services.register(router, as: Router.self)
    services.register(middleware)
    services.register(database)
    
}
