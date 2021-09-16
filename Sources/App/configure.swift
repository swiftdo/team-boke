import Vapor
import Leaf
import Fluent
import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) throws {
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.views.use(.leaf)
    // app.leaf.cache.isEnabled = app.environment.isRelease
    
    app.databases.use(.postgres(hostname: "localhost",
                                username: "vapor",
                                password: "vapor",
                                database: "blog"),
                      as: .psql)
    try routes(app)
}
