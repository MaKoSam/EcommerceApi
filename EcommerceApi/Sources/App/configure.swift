import Vapor
import FluentPostgreSQL
import PostgreSQL
import Authentication

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    let router = EngineRouter.default()
    try routes(router)
    
    try services.register(FluentPostgreSQLProvider())
    try services.register(AuthenticationProvider())
    services.register(router, as: Router.self)
    
    var middleware = MiddlewareConfig()
    middleware.use(FileMiddleware.self)
    middleware.use(ErrorMiddleware.self)
    services.register(middleware)
    
    let pgConfig = PostgreSQLDatabaseConfig(hostname: "127.0.0.1",
                                            port: 5432,
                                            username: "postgres",
                                            database: "Ecommerce",
                                            password: keychain.password,
                                            transport: .cleartext)
    let pgConnection = PostgreSQLDatabase(config: pgConfig)
    
    var database = DatabasesConfig()
    database.add(database: pgConnection, as: .psql)
    database.enableLogging(on: .psql)
    services.register(database)
    
    var migrations = MigrationConfig()
    migrations.add(model: Users.self, database: DatabaseIdentifier<Users.Database>.psql)
    migrations.add(model: UserToken.self, database: DatabaseIdentifier<UserToken.Database>.psql)
    services.register(migrations)
    
    Users.defaultDatabase = .psql
    UserToken.defaultDatabase = .psql
}
